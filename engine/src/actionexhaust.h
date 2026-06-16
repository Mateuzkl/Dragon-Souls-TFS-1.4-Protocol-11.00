/**
 * The Forgotten Server - a free and open-source MMORPG server emulator
 * Copyright (C) 2019 Mark Samman <mark.samman@gmail.com>
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program; if not, write to the Free Software Foundation, Inc.,
 * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
 */

#ifndef FS_ACTIONEXHAUST_H_3F3A0D4A569E4F0F9A084222B35E0E19
#define FS_ACTIONEXHAUST_H_3F3A0D4A569E4F0F9A084222B35E0E19

#include <cstdint>

#include "items.h"

enum class ActionExhaustCategory : uint8_t {
	UseItem,
	Potion,
	Rune,
	Machete,
};

inline bool isPotionActionItem(const ItemType& it)
{
	return it.type == ITEM_TYPE_POTION;
}

inline bool isRuneActionItem(const ItemType& it)
{
	return it.isRune();
}

inline bool isMacheteActionItem(uint16_t itemId)
{
	switch (itemId) {
		case 2420:
		case 2442:
			return true;
		default:
			return false;
	}
}

inline ActionExhaustCategory getActionExhaustCategory(const ItemType& it, uint16_t itemId)
{
	if (isPotionActionItem(it)) {
		return ActionExhaustCategory::Potion;
	}

	if (isRuneActionItem(it)) {
		return ActionExhaustCategory::Rune;
	}

	if (isMacheteActionItem(itemId)) {
		return ActionExhaustCategory::Machete;
	}

	return ActionExhaustCategory::UseItem;
}

inline uint32_t getActionExhaustSubId(ActionExhaustCategory category)
{
	switch (category) {
		case ActionExhaustCategory::Potion:
			return EXHAUST_POTION;
		case ActionExhaustCategory::Rune:
			return EXHAUST_RUNE;
		case ActionExhaustCategory::Machete:
			return EXHAUST_MACHETE;
		case ActionExhaustCategory::UseItem:
		default:
			return EXHAUST_USEITEM;
	}
}

#endif
