#!/usr/bin/env bash
set -Eeuo pipefail

# Build the current Dragon Souls checkout; never pull or replace local sources.
SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd -P)"
SOURCE_DIR="${SCRIPT_DIR}/engine"
BUILD_DIR="${SCRIPT_DIR}/build-release"
OUTPUT_BIN="${SCRIPT_DIR}/tfs"
UI_LANG="${TFS_BUILD_LANG:-}"
UBUNTU_TARGET="${TFS_UBUNTU_TARGET:-auto}"
JOBS="${JOBS:-}"
UNITY_BUILD=ON
CLEAN_BUILD=0
SKIP_DEPS=0
SKIP_BUILD=0
CHECK_ONLY=0
NONINTERACTIVE=0
TEMP_OUTPUT=""
SUDO=()
MISSING_PACKAGES=()

declare -A MSG_PT=(
  [title]="Dragon Souls - compilacao Linux (Ubuntu 20.04 / 22.04 / 24.04)"
  [unsupported]="Sistema nao suportado: %s %s. Use Ubuntu 20.04, 22.04 ou 24.04; outras versoes e distribuicoes nao sao suportadas."
  [mismatch]="--ubuntu %s nao corresponde ao Ubuntu instalado (%s). Esta opcao nao faz cross-compilation."
  [detected]="Ubuntu %s detectado. Projeto: %s"
  [project]="Nao encontrei engine/CMakeLists.txt e engine/src neste projeto: %s"
  [missing]="Dependencias ausentes: %s"
  [skip_missing]="Instale as dependencias ou execute novamente sem --skip-deps."
  [install]="Instalando somente dependencias ausentes via apt."
  [sudo]="Instalacao requer root ou sudo. Nao execute todo o script com sudo; ele pede permissao apenas para o apt."
  [tool]="Ferramenta ausente ou incompativel: %s"
  [ready]="Dependencias verificadas. CMake %s; GCC %s; LuaJIT %s."
  [unsafe]="Caminho de build/saida recusado para proteger seus arquivos: %s"
  [cache]="Cache de build pertence a outro projeto/gerador. Confira %s; use --clean somente para um build deste Dragon Souls."
  [clean]="Limpando somente: %s"
  [build]="Compilando Release com %s job(s); unity build: %s."
  [binary]="CMake terminou, mas nao encontrei um binario executavel em %s"
  [links]="Falha ao verificar bibliotecas do binario: %s"
  [done]="Binario pronto: %s"
  [run]="Para iniciar manualmente: cd %q && %q"
  [check]="Verificacao concluida. Nenhum pacote instalado e nenhuma compilacao executada."
  [deps_only]="Dependencias prontas. Compilacao nao executada (--skip-build)."
  [failure]="Falha na linha %s (codigo %s). Nenhum servidor foi iniciado."
)

declare -A MSG_EN=(
  [title]="Dragon Souls - Linux build (Ubuntu 20.04 / 22.04 / 24.04)"
  [unsupported]="Unsupported system: %s %s. Use Ubuntu 20.04, 22.04 or 24.04; other releases and distributions are not supported."
  [mismatch]="--ubuntu %s does not match the installed Ubuntu (%s). This option does not cross-compile."
  [detected]="Ubuntu %s detected. Project: %s"
  [project]="Could not find engine/CMakeLists.txt and engine/src in this project: %s"
  [missing]="Missing dependencies: %s"
  [skip_missing]="Install the dependencies or run again without --skip-deps."
  [install]="Installing only missing dependencies through apt."
  [sudo]="Installation requires root or sudo. Do not run the entire script with sudo; only apt needs elevated permission."
  [tool]="Missing or incompatible tool: %s"
  [ready]="Dependencies checked. CMake %s; GCC %s; LuaJIT %s."
  [unsafe]="Refused build/output path to protect your files: %s"
  [cache]="Build cache belongs to another project/generator. Check %s; use --clean only for a build of this Dragon Souls checkout."
  [clean]="Cleaning only: %s"
  [build]="Building Release with %s job(s); unity build: %s."
  [binary]="CMake finished, but no executable binary was found at %s"
  [links]="Could not verify binary libraries: %s"
  [done]="Binary ready: %s"
  [run]="To start manually: cd %q && %q"
  [check]="Checks completed. No packages installed and no compilation performed."
  [deps_only]="Dependencies ready. Compilation skipped (--skip-build)."
  [failure]="Failed at line %s (exit code %s). No server was started."
)

declare -A MSG_ES=(
  [title]="Dragon Souls - compilacion Linux (Ubuntu 20.04 / 22.04 / 24.04)"
  [unsupported]="Sistema no compatible: %s %s. Usa Ubuntu 20.04, 22.04 o 24.04; otras versiones y distribuciones no son compatibles."
  [mismatch]="--ubuntu %s no coincide con el Ubuntu instalado (%s). Esta opcion no hace compilacion cruzada."
  [detected]="Ubuntu %s detectado. Proyecto: %s"
  [project]="No encontre engine/CMakeLists.txt y engine/src en este proyecto: %s"
  [missing]="Dependencias faltantes: %s"
  [skip_missing]="Instala las dependencias o ejecuta de nuevo sin --skip-deps."
  [install]="Instalando solo dependencias faltantes mediante apt."
  [sudo]="La instalacion requiere root o sudo. No ejecutes todo el script con sudo; solo apt necesita permiso elevado."
  [tool]="Herramienta ausente o incompatible: %s"
  [ready]="Dependencias verificadas. CMake %s; GCC %s; LuaJIT %s."
  [unsafe]="Ruta de build/salida rechazada para proteger tus archivos: %s"
  [cache]="El cache pertenece a otro proyecto/generador. Revisa %s; usa --clean solo para un build de este Dragon Souls."
  [clean]="Limpiando solamente: %s"
  [build]="Compilando Release con %s job(s); unity build: %s."
  [binary]="CMake termino, pero no encontre un binario ejecutable en %s"
  [links]="No se pudieron verificar las bibliotecas del binario: %s"
  [done]="Binario listo: %s"
  [run]="Para iniciar manualmente: cd %q && %q"
  [check]="Verificacion completada. Sin instalar paquetes ni compilar."
  [deps_only]="Dependencias listas. Compilacion omitida (--skip-build)."
  [failure]="Fallo en la linea %s (codigo %s). No se inicio ningun servidor."
)

message() {
  local key="$1"
  shift
  local format
  case "${UI_LANG:-pt}" in
    en) format="${MSG_EN[$key]}" ;;
    es) format="${MSG_ES[$key]}" ;;
    *) format="${MSG_PT[$key]}" ;;
  esac
  # Formats are constants from the dictionaries above, never user input.
  # shellcheck disable=SC2059
  printf -- "${format}\n" "$@"
}

die() { message "$@" >&2; exit 1; }
usage_error() { printf '[ERROR] %s\n' "$*" >&2; exit 2; }
cleanup() { if [[ -n "${TEMP_OUTPUT}" ]]; then rm -f -- "${TEMP_OUTPUT}"; fi; }
on_error() {
  local code=$? line="${BASH_LINENO[0]:-?}"
  message failure "${line}" "${code}" >&2
  exit "${code}"
}

usage() {
  cat <<'EOF'
Dragon Souls - Ubuntu 20.04 / 22.04 / 24.04 only
Usage: bash build.sh [options]

  --lang pt|en|es             Language (interactive choice; default: pt)
  --ubuntu 20.04|22.04|24.04   Require this installed Ubuntu version (auto-detected)
  --jobs N                   Parallel jobs (default: CPU count limited by available RAM)
  --no-unity                 Disable CMake unity build
  --clean                    Clean this project's build-release before compiling
  --output PATH              Output binary (default: tfs at the repository root)
  --skip-deps                Never install dependencies; fail if any are missing
  --skip-build               Prepare dependencies only
  --check                    Read-only environment/dependency checks; never build/install
  --non-interactive          Use detected/default choices
  -h, --help                 Show help

Environment: TFS_BUILD_LANG=pt|en|es, TFS_UBUNTU_TARGET=auto|20.04|22.04|24.04, JOBS=N
Other Ubuntu releases and distributions are rejected, including with --ubuntu.
This script does not start the server, change branches, or update the checkout.
EOF
}

parse_args() {
  while (($#)); do
    case "$1" in
      --lang|--ubuntu|--jobs|--output)
        [[ $# -ge 2 && -n "$2" && "$2" != --* ]] || usage_error "$1 requires a value"
        case "$1" in
          --lang) UI_LANG="$2" ;;
          --ubuntu) UBUNTU_TARGET="$2" ;;
          --jobs) JOBS="$2" ;;
          --output) OUTPUT_BIN="$2" ;;
        esac
        shift 2 ;;
      --no-unity) UNITY_BUILD=OFF; shift ;;
      --clean) CLEAN_BUILD=1; shift ;;
      --skip-deps) SKIP_DEPS=1; shift ;;
      --skip-build) SKIP_BUILD=1; shift ;;
      --check) CHECK_ONLY=1; shift ;;
      --non-interactive) NONINTERACTIVE=1; shift ;;
      -h|--help) usage; exit 0 ;;
      *) usage_error "Unknown option: $1" ;;
    esac
  done
  case "${UBUNTU_TARGET}" in auto|20.04|22.04|24.04) ;; *) usage_error "--ubuntu: only 20.04, 22.04 or 24.04" ;; esac
  if [[ -n "${JOBS}" ]]; then
    [[ "${JOBS}" =~ ^[1-9][0-9]{0,3}$ ]] || usage_error "--jobs/JOBS must be a positive integer (1..1024)"
    ((JOBS <= 1024)) || usage_error "--jobs/JOBS must be <= 1024"
  fi
}

choose_language() {
  if [[ -z "${UI_LANG}" && "${NONINTERACTIVE}" -eq 0 && -t 0 ]]; then
    printf '1) Portugues  2) English  3) Espanol\n'
    read -r -p '> [1] ' UI_LANG || UI_LANG=pt
  fi
  case "${UI_LANG:-pt}" in
    pt|pt-br|1) UI_LANG=pt ;;
    en|2) UI_LANG=en ;;
    es|3) UI_LANG=es ;;
    *) usage_error "--lang/TFS_BUILD_LANG: pt, en or es" ;;
  esac
}

detect_system() {
  OS_ID=unknown
  OS_VERSION=unknown
  if [[ -r /etc/os-release ]]; then
    local ID="" VERSION_ID=""
    # shellcheck disable=SC1091
    source /etc/os-release
    OS_ID="${ID:-unknown}"
    OS_VERSION="${VERSION_ID:-unknown}"
  fi
}

validate_system() {
  detect_system
  case "${OS_ID}:${OS_VERSION}" in
    ubuntu:20.04|ubuntu:22.04|ubuntu:24.04) ;;
    *) die unsupported "${OS_ID}" "${OS_VERSION}" ;;
  esac
  [[ "$(uname -s)" == Linux ]] || die unsupported "$(uname -s)" "${OS_VERSION}"
  if [[ "${UBUNTU_TARGET}" != auto && "${UBUNTU_TARGET}" != "${OS_VERSION}" ]]; then
    die mismatch "${UBUNTU_TARGET}" "${OS_VERSION}"
  fi
  [[ -f "${SOURCE_DIR}/CMakeLists.txt" && -d "${SOURCE_DIR}/src" ]] || die project "${SCRIPT_DIR}"
  message detected "${OS_VERSION}" "${SCRIPT_DIR}"
}

package_installed() {
  [[ "$(dpkg-query -W -f='${Status}' "$1" 2>/dev/null)" == 'install ok installed' ]]
}

collect_missing_packages() {
  local package
  local -a packages=(build-essential cmake ninja-build pkg-config ca-certificates
    libboost-system-dev libboost-filesystem-dev libboost-iostreams-dev
    libluajit-5.1-dev luajit libpugixml-dev libcrypto++-dev libfmt-dev
    zlib1g-dev protobuf-compiler)
  # Do not replace an existing MySQL client installation with MariaDB.
  if ! package_installed default-libmysqlclient-dev && ! package_installed libmysqlclient-dev; then
    packages+=(libmariadb-dev libmariadb-dev-compat)
  fi
  MISSING_PACKAGES=()
  for package in "${packages[@]}"; do
    if ! package_installed "${package}"; then MISSING_PACKAGES+=("${package}"); fi
  done
}

ensure_dependencies() {
  command -v dpkg-query >/dev/null || die tool dpkg-query
  collect_missing_packages
  if ((${#MISSING_PACKAGES[@]})); then
    message missing "${MISSING_PACKAGES[*]}"
    if ((SKIP_DEPS || CHECK_ONLY)); then die skip_missing; fi
    command -v apt-get >/dev/null || die tool apt-get
    if ((EUID != 0)); then
      command -v sudo >/dev/null || die sudo
      SUDO=(sudo)
    fi
    message install
    "${SUDO[@]}" apt-get update
    "${SUDO[@]}" apt-get install -y --no-install-recommends "${MISSING_PACKAGES[@]}"
    collect_missing_packages
    ((${#MISSING_PACKAGES[@]} == 0)) || die missing "${MISSING_PACKAGES[*]}"
  fi
}

check_tools() {
  local tool cmake_version gcc_version luajit_version
  for tool in cmake gcc g++ ninja pkg-config protoc ldd; do
    command -v "${tool}" >/dev/null || die tool "${tool}"
  done
  cmake_version="$(cmake --version | awk 'NR == 1 {print $3}')"
  gcc_version="$(g++ -dumpfullversion -dumpversion)"
  dpkg --compare-versions "${cmake_version}" ge 3.16 || die tool 'CMake >= 3.16'
  dpkg --compare-versions "${gcc_version}" ge 9 || die tool 'GCC >= 9 (C++17)'
  pkg-config --exists luajit || die tool 'LuaJIT (pkg-config luajit)'
  luajit_version="$(pkg-config --modversion luajit)"
  LUA_INCLUDE_DIR="$(pkg-config --variable=includedir luajit)"
  LUA_LIBRARY="$(pkg-config --variable=libdir luajit)/libluajit-5.1.so"
  [[ -f "${LUA_INCLUDE_DIR}/luajit.h" && -f "${LUA_LIBRARY}" ]] || die tool 'LuaJIT headers/library'
  message ready "${cmake_version}" "${gcc_version}" "${luajit_version}"
}

validate_paths() {
  [[ ! -L "${BUILD_DIR}" ]] || die unsafe "${BUILD_DIR}"
  [[ "$(realpath -m -- "${BUILD_DIR}")" == "${SCRIPT_DIR}/build-release" ]] || die unsafe "${BUILD_DIR}"
  [[ ! -e "${BUILD_DIR}" || -d "${BUILD_DIR}" ]] || die unsafe "${BUILD_DIR}"
  if [[ "${OUTPUT_BIN}" != /* ]]; then OUTPUT_BIN="${SCRIPT_DIR}/${OUTPUT_BIN}"; fi
  [[ ! -L "${OUTPUT_BIN}" ]] || die unsafe "${OUTPUT_BIN}"
  OUTPUT_BIN="$(realpath -m -- "${OUTPUT_BIN}")"
  case "${OUTPUT_BIN}" in
    "${SCRIPT_DIR}"|"${SOURCE_DIR}"|"${SOURCE_DIR}"/*|"${SCRIPT_DIR}/data"|"${SCRIPT_DIR}/data"/*|"${SCRIPT_DIR}/.git"|"${SCRIPT_DIR}/.git"/*|"${BUILD_DIR}")
      die unsafe "${OUTPUT_BIN}" ;;
    "${BUILD_DIR}"/*) [[ "${OUTPUT_BIN}" == "${BUILD_DIR}/tfs" ]] || die unsafe "${OUTPUT_BIN}" ;;
  esac
  if [[ -e "${OUTPUT_BIN}" ]]; then
    [[ -f "${OUTPUT_BIN}" && "$(head -c 4 -- "${OUTPUT_BIN}")" == $'\177ELF' ]] || die unsafe "${OUTPUT_BIN}"
  fi
}

prepare_build_dir() {
  local cache="${BUILD_DIR}/CMakeCache.txt" cached_source cached_generator
  if [[ -f "${cache}" ]]; then
    cached_source="$(sed -n 's/^CMAKE_HOME_DIRECTORY:INTERNAL=//p' "${cache}")"
    cached_generator="$(sed -n 's/^CMAKE_GENERATOR:INTERNAL=//p' "${cache}")"
    [[ "${cached_source}" == "${SOURCE_DIR}" ]] || die cache "${BUILD_DIR}"
    [[ "${cached_generator}" == Ninja || "${CLEAN_BUILD}" -eq 1 ]] || die cache "${BUILD_DIR}"
  elif [[ -f "${BUILD_DIR}/.dragon-souls-build" ]]; then
    [[ "$(cat -- "${BUILD_DIR}/.dragon-souls-build")" == "${SOURCE_DIR}" ]] || die cache "${BUILD_DIR}"
  elif [[ -d "${BUILD_DIR}" ]]; then
    [[ -z "$(find "${BUILD_DIR}" -mindepth 1 -maxdepth 1 -print -quit)" ]] || die unsafe "${BUILD_DIR}"
  fi
  if ((CLEAN_BUILD)) && [[ -d "${BUILD_DIR}" ]]; then
    # validate_paths rejects symlinks and requires this exact project-local path.
    validate_paths
    message clean "${BUILD_DIR}"
    rm -rf --one-file-system -- "${BUILD_DIR}"
  fi
  mkdir -p -- "${BUILD_DIR}"
  printf '%s\n' "${SOURCE_DIR}" > "${BUILD_DIR}/.dragon-souls-build"
}

build_server() {
  if [[ -z "${JOBS}" ]]; then
    local memory_jobs
    JOBS="$(nproc)"
    memory_jobs="$(awk '/MemAvailable:/ {print int($2 / 2097152)}' /proc/meminfo)"
    memory_jobs="${memory_jobs:-1}"
    ((memory_jobs > 0)) || memory_jobs=1
    if ((JOBS > memory_jobs)); then JOBS="${memory_jobs}"; fi
  fi
  prepare_build_dir
  message build "${JOBS}" "${UNITY_BUILD}"
  cmake -S "${SOURCE_DIR}" -B "${BUILD_DIR}" -G Ninja \
    -DCMAKE_BUILD_TYPE=Release -DUSE_LUAJIT=ON \
    "-DENABLE_UNITY_BUILD=${UNITY_BUILD}" \
    "-DLUA_INCLUDE_DIR=${LUA_INCLUDE_DIR}" "-DLUA_LIBRARY=${LUA_LIBRARY}" \
    "-DLUA_LIBRARIES=${LUA_LIBRARY};m;dl"
  cmake --build "${BUILD_DIR}" --target tfs --parallel "${JOBS}"

  local built_binary="${BUILD_DIR}/tfs" links
  [[ -f "${built_binary}" && -x "${built_binary}" ]] || die binary "${built_binary}"
  links="$(ldd "${built_binary}" 2>&1)" || die links "${links}"
  [[ "${links}" != *'not found'* ]] || die links "${links}"
  if [[ "${OUTPUT_BIN}" != "${built_binary}" ]]; then
    mkdir -p -- "$(dirname -- "${OUTPUT_BIN}")"
    TEMP_OUTPUT="$(mktemp "$(dirname -- "${OUTPUT_BIN}")/.dragon-souls-tfs.XXXXXX")"
    install -m 755 -- "${built_binary}" "${TEMP_OUTPUT}"
    mv -fT -- "${TEMP_OUTPUT}" "${OUTPUT_BIN}"
    TEMP_OUTPUT=""
  fi
  message done "${OUTPUT_BIN}"
  message run "${SCRIPT_DIR}" "${OUTPUT_BIN}"
}

main() {
  trap on_error ERR
  trap cleanup EXIT
  parse_args "$@"
  choose_language
  message title
  # This gate runs before apt, cleanup, CMake, or any other mutation.
  validate_system
  validate_paths
  ensure_dependencies
  check_tools
  if ((CHECK_ONLY)); then
    message check
  elif ((SKIP_BUILD)); then
    message deps_only
  else
    build_server
  fi
}

if [[ "${BASH_SOURCE[0]}" == "$0" ]]; then main "$@"; fi
