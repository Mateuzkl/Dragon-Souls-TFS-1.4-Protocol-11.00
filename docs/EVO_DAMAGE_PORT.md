# Port do dano EVO/Oldtimes

## Escopo e fontes verificadas

O teto e os multiplicadores deste port vieram de `EVO/Source Oldtimes` e
`EVO/vocations.xml`. A revisão da distribuição usa também a source do servidor
real indicada pelo mantenedor em `PEX/Pex-Season`.

As duas revisões EVO divergem justamente no ponto que explica os hits quase
zerados:

| Revisão | Máximo base | Roll melee normal |
|---|---|---|
| Source Oldtimes | `floor(skill * attack / 20) + attack` | `random_range(0, maxDamage)` |
| Pex-Season | `floor(skill * attack / 2) + attack` | `random_range(attack * 30, maxDamage)` |

O commit-base e todas as branches disponíveis do Pex usam o limite inferior
`attack * 30`. A função `random_range` dele é uniforme e inclusiva. A troca
posterior por `safeRandomWeaponDamage` apenas protege overflow e ordena os
limites; não alterou essa distribuição.

Nenhum arquivo de vídeo foi encontrado nos anexos, em `EVO` ou em
`PEX/Pex-Season`. Portanto este relatório não inventa uma análise por frames ou
por arma. A evidência prática disponível é a amostra numérica fornecida; a
evidência do comportamento EVO real é a source Pex indicada pelo mantenedor.

## Causa raiz e correção

O PR havia portado o teto Oldtimes, mas também havia portado o intervalo
`0..maxDamage`. Em uma distribuição uniforme, qualquer região do intervalo tem
probabilidade proporcional ao seu tamanho. Com teto final 3877, cerca de 7,8%
dos rolls ficam abaixo de 300; hits como 15, 20, 98 ou 196 são consequência
direta, não um problema de Attack, vocation ou WeaponClass.

Não há evidência para trocar o uniforme por `normal_random`. O Pex real usa
uniforme com um mínimo derivado do Attack.

O teto aprovado usa coeficiente `/20`, dez vezes menor que o `/2` do Pex. Para
preservar essa escala sem restaurar o teto muito maior do Pex, o limite inferior
homólogo também é reduzido dez vezes:

```text
baseMax = floor(skill * attack / 20) + attack
baseMin = min(baseMax, attack * 3)       # (attack * 30) / 10
roll = uniform_integer(baseMin, baseMax)
weaponHit = trunc(roll * attackStrength / 100)
weaponHit = trunc(weaponHit * vocationDamage)
primaryPhysical = trunc(weaponHit * WeaponClass)
```

O `min(baseMax, ...)` apenas mantém um intervalo válido para skills extremamente
baixos; ele não reduz nem substitui o teto. Não há número absoluto como 1000,
clamp no hit final, exceção por item, level ou vocation.

Para skill 153, Attack 230, vocation 1.3, Class A 1.5 e modo Attack:

```text
baseMin = 230 * 3 = 690
baseMax = floor(153 * 230 / 20) + 230 = 1989
finalMin = trunc(trunc(690 * 1.3f) * 1.5) = 1344
finalMax = trunc(trunc(1989 * 1.3f) * 1.5) = 3877
```

O máximo não foi reduzido. Skill e Attack continuam formando o teto; Attack
também determina o piso natural. Vocation e WeaponClass escalam os dois extremos
na mesma ordem já usada pelo PR.

## Estatísticas

Percentis abaixo usam interpolação linear R-7. Os críticos foram excluídos.

### Amostra atual fornecida (53 hits normais)

| Min | P1 | P5 | P25 | Mediana | Média | P75 | P95 | P99 | Máx |
|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|
| 256 | 306,44 | 594,20 | 1299 | 1797 | 1918,19 | 2476 | 3198,20 | 3693,32 | 3776 |

### Simulação determinística de 100.000 hits

Seed 3696, skill 153, Attack 230, vocation 1.3, Class A 1.5, Attack mode,
Inc.Phys 0 e sem mitigação do alvo:

| Distribuição | Min | P1 | P5 | P25 | Mediana | Média | P75 | P95 | P99 | Máx |
|---|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|
| Antes: uniforme `0..1989` | 0 | 37 | 189 | 963 | 1938 | 1936,54 | 2908 | 3684 | 3838 | 3877 |
| Depois: uniforme `690..1989` | 1344 | 1369 | 1467 | 1972 | 2610 | 2609,87 | 3246 | 3751 | 3852 | 3877 |

Hits menores que 300: 7813 antes e zero depois. Isso não ocorre por clamp:
1344 é o resultado natural de `Attack * 3`, vocation e Class A.

### Regressão de progressão

Cada célula mostra a média de 100.000 hits, sempre com vocation 1.3 e modo
Attack. Em todas as linhas a ordem é `Default < C < B < A < God`; em todas as
colunas armas com skill/Attack maiores causam mais dano.

| Skill / Attack | Default | C 1.15 | B 1.3 | A 1.5 | God 2.0 |
|---|---:|---:|---:|---:|---:|
| 50 / 50 | 210,68 | 241,75 | 273,48 | 315,79 | 421,36 |
| 100 / 100 | 584,28 | 671,42 | 759,12 | 876,17 | 1168,57 |
| 153 / 230 | 1740,08 | 2000,60 | 2261,65 | 2609,87 | 3480,16 |
| 200 / 300 | 2728,11 | 3136,82 | 3546,09 | 4091,91 | 5456,22 |

WeaponClass continua sendo uma extensão do Dragon Souls. No Pex ela aparece na
descrição dos itens (a Adamantiun Axe é `Class.A`), mas não existe parser nem
multiplicador `weaponClass` naquela source. O port mantém os multiplicadores já
aprovados: Default 1.00, F 1.00, E 1.03, D 1.05, C 1.08, B 1.10,
S 1.18, J 1.20, God 1.25 e A 3.15.

## Critical, mitigação e sistemas preservados

Os críticos fornecidos foram analisados separadamente: 4064, 4480, 5182, 3982 e
5173 (min 3982, mediana 4480, média 4576,20, max 5182). Nenhum deles participa
das tabelas de hit normal.

Esta revisão não altera critical. O TFS do PR continua com configuração
hardcoded por vocation em `combat.cpp`; Dragon Slayer usa 12% e multiplicador
2.3. A UI continua mostrando os skills modernos de critical, que podem ficar em
zero mesmo com esse crítico de vocation ativo. Essa divergência está documentada
aqui e deve ser corrigida em tarefa separada para não misturar dois sistemas no
fix de distribuição.

Inc.Phys, Inc.Element, PvP, Prey, imbuement, leech, defense, shield e armor
continuam nas mesmas etapas. Armor/defense são reduções posteriores ao roll e
podem diminuir ou bloquear o dano contra um alvo específico; eles não criam o
intervalo de dano bruto da arma e não foram modificados.

Também não foram alterados fist, spells, runes, wands, monstros ou o cálculo
elemental independente do TFS. A mudança de mínimo é aplicada somente ao dano
físico normal de armas melee e distance, os dois caminhos em que a source Pex
possui o piso `Attack * 30`.

## Testes e conteúdo do PR

- Simulação C++ local de 100.000 hits antes/depois com assertions do mínimo,
  máximo e percentis.
- Vinte regressões: quatro pares skill/Attack por cinco Weapon Classes.
- Build unity completo do servidor com GCC e `-Wall -Werror`.
- Revisão do diff e do histórico para impedir artefatos de teste.

Os simuladores foram executados fora do repositório. Não fazem parte do diff nem
do histórico final `engine/tests`, CTest, `evo_damage_simulation.py` ou
`evo_weapon_damage_test.cpp`.

O diff funcional deste ajuste contém somente o helper do mínimo em
`engine/src/evo_weapon_damage.h` e a passagem do intervalo uniforme em
`engine/src/weapons.cpp`. O crítico e `getMaxWeaponDamage()` permanecem
inalterados.
