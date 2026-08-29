# Port do dano EVO/Oldtimes

## Escopo e referências

Este port usa como fonte de verdade `EVO/Source Oldtimes` e `EVO/vocations.xml`. A fórmula física, o RNG, os modos de luta, os multiplicadores de vocation e os attack speeds foram confirmados diretamente nesses arquivos antes da alteração.

Não havia vídeo EVO nem `config.lua` original na pasta recebida. Por isso, o relatório não afirma validação visual por arma e não inventa os valores do crítico antigo. O `config.lua.dist` também não define `criticaldamage`; o loader legado usa zero como padrão quando essa configuração está ausente.

## Fórmulas

### EVO original

Para fist, sword, club, axe e distance:

```text
baseMax = floor(skill * attack / 20) + attack
roll = uniform_integer(0, baseMax)
hit = floor(roll * attackStrength / 100)
```

`attackStrength` é 100 no Attack, 50 no Balanced e 30 no Defense. O código antigo usa o Attack do próprio item de munição no distance; o Attack do bow não é somado ao dano.

O RNG `random_range(lowest, highest)` do Oldtimes é uniforme e inclusivo. Level não participa do dano físico. Wand usa seu próprio intervalo fixo e não usa essa fórmula.

### Dragon Souls antes

No modo Attack, o teto anterior era aproximadamente:

```text
round(level / 5 + (((skill / 4 + 1) * (attack / 3)) * 1.03) / attackFactor)
* meleeDamage ou distDamage
* WeaponClass
```

O roll era `normal_random`. Distance somava o Attack do bow ao Attack da munição e ainda aplicava um mínimo baseado no level.

### Dragon Souls depois

```text
baseMax = floor(skill * attack / 20) + attack
roll = uniform_integer(0, baseMax)
weaponHit = trunc(trunc(roll * attackStrength / 100) * vocationDamage)
primaryPhysical = trunc(weaponHit * WeaponClass)
```

Os truncamentos são intencionais e ocorrem por camada. O multiplicador de vocation continua armazenado como `float`, como nos dois engines. Para dano elemental nativo da arma, o Attack elemental tem cálculo independente; WeaponClass continua restrito ao primary físico. Imbuement divide o primary já calculado entre primary/secondary sem duplicar o total.

## Causa raiz da explosão

O problema não era um único valor: havia cascata real entre fórmula moderna, multiplicador de vocation excessivo, WeaponClass, crítico e Inc.

Exemplo Dragon Slayer, level 500, skill 200, Sword of Teseu Attack 170, classe C 1.15:

```text
Antes: round(100 + ((51 * 56.666...) * 1.03)) * 8.0 * 1.15 = 28.308 de teto pré-crítico
Depois: (200 * 170 / 20 + 170) -> roll -> * 1.3 -> * 1.15 = 2.794 de teto pré-crítico
```

Com crítico 2.3 e Inc.Phys total de 60%, o teto simulado anterior chegou a 104.165; depois do port ficou em 10.282. Não há cap: a redução resulta somente da fórmula e dos multiplicadores corretos.

## Pipeline efetivo após o port

1. Seleção do skill correto: fist, sword, club, axe ou distance.
2. Cálculo do teto EVO sem level e, no distance com munição, sem somar o Attack do bow.
3. Roll uniforme inclusivo entre zero e o teto.
4. Attack strength EVO: 100%, 50% ou 30%.
5. Multiplicador EVO da vocation: `meleeDamage` ou `distDamage`.
6. WeaponClass no primary físico. Para munição, a classe do bow é usada como fallback.
7. Primary e secondary são montados separadamente; elemento nativo usa somente seu Attack elemental.
8. Crítico custom atual é verificado uma vez e modifica somente o primary.
9. Player contra Player não-black-skull recebe a redução moderna de 50% uma vez, nos dois componentes.
10. Leech atual é calculado.
11. Imbuement converte uma parcela do componente existente sem aumentar o total.
12. Prey ofensivo é aplicado; depois cada grupo Inc. é somado por tipo e aplicado uma vez (`20 + 20 + 20 = 60%`, portanto `x1.60`).
13. Prey defensivo do alvo é aplicado.
14. `combatBlockHit` moderno processa shield/armor/defense; o secondary elemental não é tratado como físico.
15. O dano final é enviado a health/mana.

Spells, runes, wands, monstros e a API moderna `getAttackFactor()` não foram reescritos.

## Vocações antes/depois

Os IDs 0 a 16 foram comparados automaticamente contra o XML EVO: zero divergências em damage, defense, armor e attack speed. Os campos modernos de wand/magic foram preservados.

| ID | Vocation | Antes M/D | Depois M/D | Antes Def/Arm | Depois Def/Arm | Antes ms | Depois ms |
|---:|---|---:|---:|---:|---:|---:|---:|
| 0 | None | 1.0/1.0 | 1.2/1.2 | 1.0/1.0 | 1.1/1.1 | 2000 | 2500 |
| 1 | Sorcerer | 1.0/1.0 | 1.2/1.2 | 1.0/1.0 | 1.1/1.1 | 2000 | 2000 |
| 2 | Druid | 1.0/1.0 | 1.2/1.2 | 1.0/1.0 | 1.1/1.1 | 2000 | 1500 |
| 3 | Archer | 1.0/1.0 | 1.4/1.4 | 1.0/1.0 | 1.1/1.1 | 2000 | 2000 |
| 4 | Knight | 1.0/1.0 | 1.3/1.3 | 1.0/1.0 | 1.1/1.1 | 2000 | 2000 |
| 5 | Master Sorcerer | 1.0/1.0 | 1.2/1.2 | 1.0/1.0 | 1.1/1.1 | 2000 | 1500 |
| 6 | Elder Druid | 1.0/1.0 | 1.2/1.2 | 1.0/1.0 | 1.1/1.1 | 2000 | 1500 |
| 7 | Royal Archer | 1.0/1.0 | 1.5/1.5 | 1.0/1.0 | 1.1/1.1 | 2000 | 1500 |
| 8 | Elite Knight | 1.0/1.0 | 1.3/1.3 | 1.0/1.0 | 1.1/1.1 | 2000 | 1500 |
| 9 | Wyzard | 1.0/1.0 | 1.2/1.2 | 1.0/1.0 | 1.1/1.1 | 1000 | 800 |
| 10 | Cleric | 1.0/1.0 | 1.2/1.2 | 1.0/1.0 | 1.1/1.1 | 1000 | 800 |
| 11 | Ranger | 1.0/2.0 | 1.4/1.4 | 1.5/1.0 | 1.2/1.2 | 600 | 800 |
| 12 | Slayer | 6.0/1.0 | 1.3/1.3 | 1.5/1.8 | 1.2/1.2 | 600 | 800 |
| 13 | Dark Wyzard | 1.0/1.0 | 1.2/1.2 | 1.0/1.0 | 1.1/1.1 | 800 | 500 |
| 14 | Elemental Cleric | 1.0/1.0 | 1.2/1.2 | 1.0/1.0 | 1.1/1.1 | 800 | 500 |
| 15 | Elven Ranger | 1.0/4.0 | 1.4/1.4 | 3.0/1.0 | 1.2/1.2 | 400 | 500 |
| 16 | Dragon Slayer | 8.0/1.0 | 1.3/1.3 | 3.0/2.4 | 1.2/1.2 | 500 | 500 |

O Game Master moderno é ID 21, enquanto a referência antiga usa ID 20. Ele foi deixado intacto porque não existe equivalência exata por ID.

## Simulação estatística

Execução determinística: seed 3696, level 500, skill 200, modo Attack, 100.000 hits por linha, sem crítico e sem Inc. Esta tabela separa o hit bruto do DPS calculado com o attack speed de cada versão.

| Vocation/arma | Antes média | Antes máx | Antes DPS | Depois média | Depois P95 | Depois máx | Depois DPS |
|---|---:|---:|---:|---:|---:|---:|---:|
| Knight / Darkness Sword Atk 70 | 663.81 | 1326 | 331.90 | 501.04 | 952 | 1000 | 250.52 |
| Elite Knight / Alabarda of Fire Atk 160 C | 1667.18 | 3337 | 833.59 | 1316.21 | 2498 | 2630 | 877.47 |
| Slayer / Alabarda of Fire Atk 160 C | 10009.28 | 20023 | 16682.13 | 1315.99 | 2502 | 2630 | 1644.99 |
| Dragon Slayer / Sword of Teseu Atk 170 C | 14156.65 | 28307 | 28313.29 | 1400.21 | 2654 | 2794 | 2800.43 |
| Ranger / Bullet Atk 92 | 1710.44 | 3422 | 2850.73 | 708.60 | 1346 | 1416 | 885.74 |
| Elven Ranger / Bullet Atk 92 | 3415.66 | 6844 | 8539.16 | 707.92 | 1345 | 1416 | 1415.84 |

Também foi executada uma segunda rodada com crítico atual e Inc. 60%. O script imprime Min, P1, P5, P25, mediana, média, P75, P95, P99, máximo, desvio padrão, hits/s e DPS para todas as linhas.

| Vocation/arma | Antes máximo | Antes DPS | Depois máximo | Depois DPS |
|---|---:|---:|---:|---:|
| Knight / Darkness Sword | 4243 | 582.40 | 3200 | 439.01 |
| Elite Knight / Alabarda of Fire | 10672 | 1470.35 | 8416 | 1546.69 |
| Slayer / Alabarda of Fire | 67274 | 29850.91 | 8837 | 2948.08 |
| Dragon Slayer / Sword of Teseu | 104165 | 52311.31 | 10282 | 5181.90 |
| Ranger / Bullet | 5475 | 4557.82 | 2266 | 1416.75 |
| Elven Ranger / Bullet | 10950 | 13676.91 | 2266 | 2257.89 |

Comando reproduzível:

```bash
python3 engine/tests/evo_damage_simulation.py --hits 100000 --level 500 --skills 50 100 150 200 300
python3 engine/tests/evo_damage_simulation.py --hits 100000 --level 500 --skills 200 --inc-percent 60 --include-critical
```

## Testes e builds

- Testes determinísticos: 100/50 = 300; 200/100 = 1100; casos de truncamento, fight modes e ordem vocation/WeaponClass.
- Simulação base: 6 vocations x 5 skills x antes/depois x 100.000 = 6.000.000 hits.
- GCC 13.3 Linux, unity build oficial, `-Wall -Werror`: servidor compilado e linkado; CTest 1/1 passou.
- Clang 18.1 Linux: helper compilado com `-Wall -Wextra -Werror`; CTest 1/1 passou. O servidor inteiro também compilou e linkou em build diagnóstica.
- ASan + UBSan no teste puro, tanto GCC quanto Clang: passou sem erro.

A build Clang stock do repositório ainda trata avisos antigos como erro em arquivos fora deste port: `-Winconsistent-missing-override`, array de progresso mágico fora do limite, `std::move` pessimista, `abs` em unsigned, comparação impossível em Lua, campo privado não usado e concatenação string+inteiro em `databasemanager.cpp`. A build diagnóstica removeu somente o `-Werror` global/suprimiu essas categorias para validar o restante. Nenhum aviso apontou para os arquivos novos/alterados do dano. A build GCC sem unity também expõe um problema antigo de ordem de include (`slots_t` em `movement.h`); a configuração unity padrão passa.

## Alterações e commits

| Commit | Conteúdo |
|---|---|
| `6736d94` | Fórmula, RNG, fight mode e camadas EVO de melee/distance/fist/element |
| `84e69b2` | Semântica e attack speeds do XML EVO |
| `0594e66` | Correção separada do avanço Sword/Club/Axe/Fist |
| `133aee6` | Testes CTest e simulador estatístico |

Arquivos funcionais alterados: `engine/src/evo_weapon_damage.h`, `engine/src/weapons.cpp`, `engine/src/weapons.h`, `engine/src/player.cpp`, `engine/src/player.h`, `data/XML/vocations.xml`. Infraestrutura de teste: `engine/CMakeLists.txt`, `engine/src/CMakeLists.txt`, `engine/tests/CMakeLists.txt`, `engine/tests/evo_weapon_damage_test.cpp`, `engine/tests/evo_damage_simulation.py`.

## Confirmações e diferenças restantes

- Não existe cap artificial de dano, `std::min(damage, 9000)` ou branch por level/vocation.
- Não existe mais a cascata indevida 6.0/8.0 ou 2.0/4.0 nas vocations. Cada camada legítima é aplicada uma vez.
- WeaponClass permanece: Default 1.0, C 1.15, B 1.30, A 1.50, God 2.00.
- Inc.Phys e todos os Inc.Element permanecem e são somados por tipo antes de uma única aplicação.
- O crítico antigo não foi somado ao atual; apenas o crítico custom moderno continua ativo uma vez.
- PvP 50%, Prey, imbuement, leech, defense, shield e armor modernos permanecem no pipeline.
- O bug legado que condicionava `damageMultiplier` a `blockCount`/checagem de defense ou armor não foi reproduzido. O multiplicador EVO é aplicado deterministicamente na camada da arma, sem depender de o alvo ainda ter block count.
- Hit chance/range à distância ainda usa a arquitetura moderna do TFS: o EVO usava, por padrão, Arrow 80%/range 5, Bolt 90%/range 6, Bullet 100%/range 8 e outros 50%/range 4, com override de XML. O dano à distância, porém, já usa somente Distance skill + Attack da munição, como o EVO.
- Defense/armor usam os multiplicadores XML EVO, mas a matemática de mitigação continua sendo `combatBlockHit` moderna, conforme o requisito de preservar a arquitetura do TFS 1.4.
- Wands/spells mantêm suas fórmulas e RNG modernos. Sem o `criticaldamage` original, os valores do crítico EVO não podem ser reconstruídos com evidência.
- Não foi possível produzir resultados por intervalo/arma do vídeo porque nenhum arquivo de vídeo foi entregue. Os três nomes citados foram simulados como cenários de engenharia com os Attack encontrados no projeto, não apresentados como medição visual do EVO.

Portanto, a matemática comprovada do dano físico EVO está portada dentro das camadas modernas solicitadas. Isso não é equivalência binária de todo o engine Oldtimes: as diferenças acima são deliberadas, rastreáveis e necessárias até receber o vídeo/config original ou autorizar também a troca de hit chance/range e mitigação moderna.
