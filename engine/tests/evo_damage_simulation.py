#!/usr/bin/env python3

import argparse
import math
import random
import statistics
import struct


SCENARIOS = (
    # name, weapon, attack, class, old/current multiplier, EVO multiplier,
    # old/current speed, EVO speed, current critical chance/multiplier
    ("Knight", "Darkness Sword", 70, 1.0, 1.0, 1.3, 2000, 2000, 10, 2.0),
    ("Elite Knight", "Alabarda of Fire", 160, 1.15, 1.0, 1.3, 2000, 1500, 10, 2.0),
    ("Slayer", "Alabarda of Fire", 160, 1.15, 6.0, 1.3, 600, 800, 11, 2.1),
    ("Dragon Slayer", "Sword of Teseu", 170, 1.15, 8.0, 1.3, 500, 500, 12, 2.3),
    ("Ranger", "Bullet", 92, 1.0, 2.0, 1.4, 600, 800, 0, 1.0),
    ("Elven Ranger", "Bullet", 92, 1.0, 4.0, 1.4, 400, 500, 0, 1.0),
)


def float32(value):
    return struct.unpack("f", struct.pack("f", value))[0]


def cpp_round(value):
    return math.floor(value + 0.5)


def modern_maximum(level, skill, attack):
    return cpp_round((level // 5) + (((((skill / 4.0) + 1) * (attack / 3.0)) * 1.03)))


def evo_maximum(skill, attack):
    return (skill * attack) // 20 + attack


def normal_roll(rng, minimum, maximum):
    if minimum == maximum:
        return minimum
    difference = maximum - minimum
    value = rng.gauss(0.5, 0.25)
    if value < 0.0:
        increment = difference // 2
    elif value > 1.0:
        increment = (difference + 1) // 2
    else:
        increment = cpp_round(value * difference)
    return minimum + increment


def scale_layers(damage, vocation_multiplier, class_multiplier, critical, inc_percent):
    damage = int(damage * float32(vocation_multiplier))
    damage = int(damage * class_multiplier)
    if critical:
        damage = int(damage * critical)
    if inc_percent:
        damage += cpp_round(damage * (inc_percent / 100.0))
    return damage


def summarize(values, speed):
    ordered = sorted(values)

    def percentile(percent):
        index = cpp_round((len(ordered) - 1) * (percent / 100.0))
        return ordered[index]

    mean = statistics.fmean(ordered)
    return {
        "min": ordered[0],
        "p1": percentile(1),
        "p5": percentile(5),
        "p25": percentile(25),
        "median": percentile(50),
        "mean": mean,
        "p75": percentile(75),
        "p95": percentile(95),
        "p99": percentile(99),
        "max": ordered[-1],
        "stdev": statistics.pstdev(ordered),
        "hps": 1000.0 / speed,
        "dps": mean * (1000.0 / speed),
    }


def run_scenario(rng, hits, level, skill, scenario, inc_percent, include_critical):
    (name, weapon, attack, class_multiplier, before_multiplier, after_multiplier,
     before_speed, after_speed, critical_chance, critical_multiplier) = scenario

    before_max = int(modern_maximum(level, skill, attack) * float32(before_multiplier) * class_multiplier)
    after_max = evo_maximum(skill, attack)
    before = []
    after = []
    for _ in range(hits):
        critical = None
        if include_critical and rng.randint(1, 100) <= critical_chance:
            critical = critical_multiplier

        before_hit = normal_roll(rng, 0, before_max)
        if critical:
            before_hit = int(before_hit * critical)
        if inc_percent:
            before_hit += cpp_round(before_hit * (inc_percent / 100.0))
        before.append(before_hit)

        after_roll = rng.randint(0, after_max)
        after.append(scale_layers(after_roll, after_multiplier, class_multiplier, critical, inc_percent))

    return (
        name,
        weapon,
        attack,
        before_max,
        after_max,
        summarize(before, before_speed),
        summarize(after, after_speed),
    )


def print_row(version, name, weapon, skill, attack, base_maximum, stats):
    print(
        f"| {version} | {name} | {weapon} | {skill} | {attack} | {base_maximum} | "
        f"{stats['min']} | {stats['p1']} | {stats['p5']} | {stats['p25']} | "
        f"{stats['median']} | {stats['mean']:.2f} | {stats['p75']} | {stats['p95']} | "
        f"{stats['p99']} | {stats['max']} | {stats['stdev']:.2f} | "
        f"{stats['hps']:.3f} | {stats['dps']:.2f} |"
    )


def main():
    parser = argparse.ArgumentParser(description="Compare Dragon Souls weapon damage before and after the EVO port.")
    parser.add_argument("--hits", type=int, default=100_000)
    parser.add_argument("--level", type=int, default=500)
    parser.add_argument("--skills", type=int, nargs="+", default=(50, 100, 150, 200, 300))
    parser.add_argument("--inc-percent", type=int, default=0)
    parser.add_argument("--include-critical", action="store_true")
    parser.add_argument("--seed", type=int, default=0xE70)
    args = parser.parse_args()

    rng = random.Random(args.seed)
    print(f"hits={args.hits}, level={args.level}, inc={args.inc_percent}%, critical={args.include_critical}, seed={args.seed}")
    print("| Version | Vocation | Weapon | Skill | Attack | Base max | Min | P1 | P5 | P25 | Median | Mean | P75 | P95 | P99 | Max | StdDev | Hits/s | DPS |")
    print("|---|---|---|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|")
    for skill in args.skills:
        for scenario in SCENARIOS:
            name, weapon, attack, before_max, after_max, before, after = run_scenario(
                rng, args.hits, args.level, skill, scenario, args.inc_percent, args.include_critical
            )
            print_row("Before", name, weapon, skill, attack, before_max, before)
            print_row("After", name, weapon, skill, attack, after_max, after)


if __name__ == "__main__":
    main()
