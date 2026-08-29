#ifndef FS_EVO_WEAPON_DAMAGE_H
#define FS_EVO_WEAPON_DAMAGE_H

#include <cstdint>

namespace EvoWeaponDamage {

inline int32_t getBaseMaximum(int32_t attackSkill, int32_t attackValue)
{
	const int64_t skillDamage = (static_cast<int64_t>(attackSkill) * attackValue) / 20;
	return static_cast<int32_t>(skillDamage + attackValue);
}

inline int32_t getBaseMinimum(int32_t attackValue, int32_t maximum)
{
	if (attackValue <= 0 || maximum <= 0) {
		return 0;
	}

	// Pex rolls from attackValue * 30 with a /2 maximum. This port keeps the
	// approved /20 maximum, so the equivalent lower-bound scale is 10x lower.
	const int64_t minimum = static_cast<int64_t>(attackValue) * 3;
	return static_cast<int32_t>(minimum < maximum ? minimum : maximum);
}

inline int32_t applyAttackStrength(int32_t damage, uint32_t attackStrength)
{
	return static_cast<int32_t>((static_cast<int64_t>(damage) * attackStrength) / 100);
}

inline int32_t applyMultiplier(int32_t damage, double multiplier)
{
	return static_cast<int32_t>(damage * multiplier);
}

inline int32_t scale(int32_t damage, uint32_t attackStrength, double vocationMultiplier, double weaponClassMultiplier = 1.0)
{
	damage = applyAttackStrength(damage, attackStrength);
	damage = applyMultiplier(damage, vocationMultiplier);
	return applyMultiplier(damage, weaponClassMultiplier);
}

} // namespace EvoWeaponDamage

#endif
