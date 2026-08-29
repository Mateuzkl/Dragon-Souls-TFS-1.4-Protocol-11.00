#include "evo_weapon_damage.h"

#include <cassert>
#include <cstdint>
#include <iostream>

int main()
{
	// Deterministic examples taken directly from the Oldtimes formula.
	assert(EvoWeaponDamage::getBaseMaximum(100, 50) == 300);
	assert(EvoWeaponDamage::getBaseMaximum(200, 100) == 1100);

	// Integer division must match the legacy floor-before-adding-attack order.
	assert(EvoWeaponDamage::getBaseMaximum(1, 1) == 1);
	assert(EvoWeaponDamage::getBaseMaximum(99, 51) == 303);
	assert(EvoWeaponDamage::getBaseMaximum(300, 170) == 2720);

	// EVO fight modes scale the rolled hit, not the pre-roll maximum.
	assert(EvoWeaponDamage::applyAttackStrength(300, 100) == 300);
	assert(EvoWeaponDamage::applyAttackStrength(300, 50) == 150);
	assert(EvoWeaponDamage::applyAttackStrength(300, 30) == 90);

	// Vocation and modern WeaponClass are separate, ordered layers.
	// Vocation values are stored as float by both engines before integer truncation.
	assert(EvoWeaponDamage::scale(301, 50, static_cast<double>(1.3f), 1.5) == 291);
	assert(EvoWeaponDamage::scale(1100, 100, static_cast<double>(1.3f), 2.0) == 2858);

	std::cout << "EVO weapon damage regression tests passed\n";
	return 0;
}
