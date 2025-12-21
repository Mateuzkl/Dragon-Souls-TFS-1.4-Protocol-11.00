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

#include "otpch.h"

#if __has_include("luajit/lua.hpp")
#include <luajit/lua.hpp>
#else
#include <lua.hpp>
#endif

#include <algorithm>
#include <limits>
#include "configmanager.h"
#include "game.h"
#include "pugicast.h"



extern Game g_game;

namespace {

std::string getGlobalString(lua_State* L, const char* identifier, const char* defaultValue)
{
	lua_getglobal(L, identifier);
	if (!lua_isstring(L, -1)) {
		lua_pop(L, 1);
		return defaultValue;
	}

	size_t len;
	const char* str = lua_tolstring(L, -1, &len);
	std::string ret(str, len);
	lua_pop(L, 1);
	return ret;
}

int32_t getGlobalNumber(lua_State* L, const char* identifier, const int32_t defaultValue = 0)
{
	lua_getglobal(L, identifier);
	if (!lua_isnumber(L, -1)) {
		lua_pop(L, 1);
		return defaultValue;
	}

	int32_t val = lua_tonumber(L, -1);
	lua_pop(L, 1);
	return val;
}

bool getGlobalBoolean(lua_State* L, const char* identifier, const bool defaultValue)
{
	lua_getglobal(L, identifier);
	if (!lua_isboolean(L, -1)) {
		if (!lua_isstring(L, -1)) {
			lua_pop(L, 1);
			return defaultValue;
		}

		size_t len;
		const char* str = lua_tolstring(L, -1, &len);
		std::string ret(str, len);
		lua_pop(L, 1);
		return booleanString(ret);
	}

	int val = lua_toboolean(L, -1);
	lua_pop(L, 1);
	return val != 0;
}

float getGlobalFloat(lua_State* L, const char* identifier, const float defaultValue = 0.0)
{
	lua_getglobal(L, identifier);
	if (!lua_isnumber(L, -1)) {
		lua_pop(L, 1);
		return defaultValue;
	}

	float val = lua_tonumber(L, -1);
	lua_pop(L, 1);
	return val;
}

double getGlobalDouble(lua_State* L, const char* identifier, const double defaultValue = 0.0)
{
	lua_getglobal(L, identifier);
	if (!lua_isnumber(L, -1)) {
		lua_pop(L, 1);
		return defaultValue;
	}

	double val = lua_tonumber(L, -1);
	lua_pop(L, 1);
	return val;
}

ExperienceStages loadLuaStages(lua_State* L)
{
	ExperienceStages stages;
	lua_getglobal(L, "experienceStages");
	if (!lua_istable(L, -1)) {
		return {};
	}

	lua_pushnil(L);
	while (lua_next(L, -2) != 0) {
		const auto tableIndex = lua_gettop(L);
		auto minLevel = LuaScriptInterface::getField<uint32_t>(L, tableIndex, "minlevel", 1);
		auto maxLevel = LuaScriptInterface::getField<uint32_t>(L, tableIndex, "maxlevel", std::numeric_limits<uint32_t>::max());
		auto multiplier = LuaScriptInterface::getField<float>(L, tableIndex, "multiplier", 1.0f);
		stages.emplace_back(minLevel, maxLevel, multiplier);
		lua_pop(L, 4);
	}
	lua_pop(L, 1);

	std::sort(stages.begin(), stages.end());
	return stages;
}

SkillStages loadLuaSkillStages(lua_State* L)
{
	SkillStages stages;
	lua_getglobal(L, "skillStages");
	if (!lua_istable(L, -1)) {
		return {};
	}

	lua_pushnil(L);
	while (lua_next(L, -2) != 0) {
		const auto tableIndex = lua_gettop(L);
		auto minSkill = LuaScriptInterface::getField<uint32_t>(L, tableIndex, "minskill", 1);
		auto maxSkill = LuaScriptInterface::getField<uint32_t>(L, tableIndex, "maxskill", std::numeric_limits<uint32_t>::max());
		auto multiplier = LuaScriptInterface::getField<float>(L, tableIndex, "multiplier", 1.0f);
		stages.emplace_back(minSkill, maxSkill, multiplier);
		lua_pop(L, 4);
	}
	lua_pop(L, 1);

	std::sort(stages.begin(), stages.end());
	return stages;
}

MagicLevelStages loadLuaMagicLevelStages(lua_State* L)
{
	MagicLevelStages stages;
	lua_getglobal(L, "magicLevelStages");
	if (!lua_istable(L, -1)) {
		return {};
	}

	lua_pushnil(L);
	while (lua_next(L, -2) != 0) {
		const auto tableIndex = lua_gettop(L);
		auto minMagic = LuaScriptInterface::getField<uint32_t>(L, tableIndex, "minmagic", 0);
		auto maxMagic = LuaScriptInterface::getField<uint32_t>(L, tableIndex, "maxmagic", std::numeric_limits<uint32_t>::max());
		auto multiplier = LuaScriptInterface::getField<float>(L, tableIndex, "multiplier", 1.0f);
		stages.emplace_back(minMagic, maxMagic, multiplier);
		lua_pop(L, 4);
	}
	lua_pop(L, 1);

	std::sort(stages.begin(), stages.end());
	return stages;
}

ExperienceStages loadXMLStages()
{
	pugi::xml_document doc;
	pugi::xml_parse_result result = doc.load_file("data/XML/stages.xml");
	if (!result) {
		return {};
	}

	ExperienceStages stages;
	for (auto stageNode : doc.child("stages").children()) {
		if (strcasecmp(stageNode.name(), "config") == 0) {
			if (!stageNode.attribute("enabled").as_bool()) {
				return {};
			}
		} else {
			uint32_t minLevel = 1, maxLevel = std::numeric_limits<uint32_t>::max();
			float multiplier = 1.0f;
			
			if (auto minLevelAttribute = stageNode.attribute("minlevel")) {
				minLevel = pugi::cast<uint32_t>(minLevelAttribute.value());
			}

			if (auto maxLevelAttribute = stageNode.attribute("maxlevel")) {
				maxLevel = pugi::cast<uint32_t>(maxLevelAttribute.value());
			}

			if (auto multiplierAttribute = stageNode.attribute("multiplier")) {
				multiplier = pugi::cast<float>(multiplierAttribute.value());
			}

			stages.emplace_back(minLevel, maxLevel, multiplier);
		}
	}

	std::sort(stages.begin(), stages.end());
	return stages;
}

SkillStages loadXMLSkillStages()
{
	pugi::xml_document doc;
	pugi::xml_parse_result result = doc.load_file("data/XML/skillstages.xml");
	if (!result) {
		return {};
	}

	SkillStages stages;
	for (auto stageNode : doc.child("skillstages").child("skills").children()) {
		if (strcasecmp(stageNode.name(), "config") == 0) {
			if (!stageNode.attribute("enabled").as_bool()) {
				return {};
			}
		} else {
			uint32_t minSkill, maxSkill;
			float multiplier;
			if (auto minSkillAttribute = stageNode.attribute("minskill")) {
				minSkill = pugi::cast<uint32_t>(minSkillAttribute.value());
			} else {
				minSkill = 1;
			}

			if (auto maxSkillAttribute = stageNode.attribute("maxskill")) {
				maxSkill = pugi::cast<uint32_t>(maxSkillAttribute.value());
			} else {
				maxSkill = 0;
			}

			if (auto multiplierAttribute = stageNode.attribute("multiplier")) {
				multiplier = pugi::cast<float>(multiplierAttribute.value());
			} else {
				multiplier = 1;
			}

			stages.emplace_back(minSkill, maxSkill, multiplier);
		}
	}

	std::sort(stages.begin(), stages.end());
	return stages;
}

MagicLevelStages loadXMLMagicLevelStages()
{
	pugi::xml_document doc;
	pugi::xml_parse_result result = doc.load_file("data/XML/skillstages.xml");
	if (!result) {
		return {};
	}

	MagicLevelStages stages;
	for (auto stageNode : doc.child("skillstages").child("magiclevel").children()) {
		if (strcasecmp(stageNode.name(), "config") == 0) {
			if (!stageNode.attribute("enabled").as_bool()) {
				return {};
			}
		} else {
			uint32_t minMagic, maxMagic;
			float multiplier;
			if (auto minMagicAttribute = stageNode.attribute("minmagic")) {
				minMagic = pugi::cast<uint32_t>(minMagicAttribute.value());
			} else {
				minMagic = 0;
			}

			if (auto maxMagicAttribute = stageNode.attribute("maxmagic")) {
				maxMagic = pugi::cast<uint32_t>(maxMagicAttribute.value());
			} else {
				maxMagic = 0;
			}

			if (auto multiplierAttribute = stageNode.attribute("multiplier")) {
				multiplier = pugi::cast<float>(multiplierAttribute.value());
			} else {
				multiplier = 1;
			}

			stages.emplace_back(minMagic, maxMagic, multiplier);
		}
	}

	std::sort(stages.begin(), stages.end());
	return stages;
}

} // namespace

ConfigManager::ConfigManager()
{
	string [CONFIG_FILE] = "config.lua";
	loaded = false;
}

bool ConfigManager::load()
{
	lua_State* L = luaL_newstate();
	if (!L) {
		throw std::runtime_error("Failed to allocate memory");
	}

	luaL_openlibs(L);

	if (luaL_dofile(L, configFileLua.c_str())) {
		console::print(CONSOLEMESSAGE_TYPE_ERROR, "[Error - ConfigManager::load] " + std::string(lua_tostring(L, -1)));
		lua_close(L);
		return false;
	}

	//parse config
	if (!loaded) { //info that must be loaded one time (unless we reset the modules involved)
		boolean[BIND_ONLY_GLOBAL_ADDRESS] = getGlobalBoolean(L, "bindOnlyGlobalAddress", false);
		boolean[OPTIMIZE_DATABASE] = getGlobalBoolean(L, "startupDatabaseOptimization", true);

		string[IP] = getGlobalString(L, "ip", "127.0.0.1");
		string[MAP_NAME] = getGlobalString(L, "mapName", "forgotten");
		string[MAP_AUTHOR] = getGlobalString(L, "mapAuthor", "Unknown");
		string[HOUSE_RENT_PERIOD] = getGlobalString(L, "houseRentPeriod", "never");
		string[MYSQL_HOST] = getGlobalString(L, "mysqlHost", "127.0.0.1");
		string[MYSQL_USER] = getGlobalString(L, "mysqlUser", "forgottenserver");
		string[MYSQL_PASS] = getGlobalString(L, "mysqlPass", "");
		string[MYSQL_DB] = getGlobalString(L, "mysqlDatabase", "forgottenserver");
		string[MYSQL_SOCK] = getGlobalString(L, "mysqlSock", "");
		string[VERSION_STR] = getGlobalString(L, "clientVersionStr", "");

		integer[SQL_PORT] = getGlobalNumber(L, "mysqlPort", 3306);
		integer[GAME_PORT] = getGlobalNumber(L, "gameProtocolPort", 7172);
		integer[LOGIN_PORT] = getGlobalNumber(L, "loginProtocolPort", 7171);
		integer[STATUS_PORT] = getGlobalNumber(L, "statusProtocolPort", 7171);
		integer[CHECK_PORT] = getGlobalNumber(L, "checkProtocolPort", 7175);
		integer[MARKET_OFFER_DURATION] = getGlobalNumber(L, "marketOfferDuration", 30 * 24 * 60 * 60);

		// Load proxy list
		string[PROXY_LIST] = getGlobalString(L, "proxyList", "");
		StringVector proxies = explodeString(string[PROXY_LIST], ";");
		for (const std::string& proxyInfo : proxies) {
			StringVector info = explodeString(proxyInfo, ",");
			if (info.size() == 4) {
				const std::string& ip = info[1];
				const std::string& name = info[3];
				uint16_t proxyId = std::stoi(info[0]);
				uint16_t port = std::stoi(info[2]);
				auto it = proxyList.emplace(std::piecewise_construct, std::forward_as_tuple(proxyId), std::forward_as_tuple(ip, port, name));
				if (it.second) {
					console::print(CONSOLEMESSAGE_TYPE_INFO, "> Loaded proxy with id: " + std::to_string(proxyId) + ", ip: " + ip + ", port: " + std::to_string(port) + ", name: " + name);
				}
			}
		}

		integer[VERSION_MIN] = getGlobalNumber(L, "clientVersionMin", CLIENT_VERSION_MIN);
		integer[VERSION_MAX] = getGlobalNumber(L, "clientVersionMax", CLIENT_VERSION_MAX);
		integer[FREE_DEPOT_LIMIT] = getGlobalNumber(L, "freeDepotLimit", 2000);
		integer[PREMIUM_DEPOT_LIMIT] = getGlobalNumber(L, "premiumDepotLimit", 8000);
		integer[AUTOLOOT_MODE] = getGlobalNumber(L, "autolootmode", 0); //Autoloot
		integer[VIP_AUTOLOOT_LIMIT] = getGlobalNumber(L, "vip_autoloot", 25);
		integer[FREE_AUTOLOOT_LIMIT] = getGlobalNumber(L, "free_autoloot", 15);

		boolean[PROTO_BUFF] = getGlobalNumber(L, "protobuff", false); //Autoloot

		doubling[SPAWN_SPEED] = getGlobalNumber(L, "spawnSpeed", 1.0);

	}

	boolean[ALLOW_CHANGEOUTFIT] = getGlobalBoolean(L, "allowChangeOutfit", true);
	boolean[ONE_PLAYER_ON_ACCOUNT] = getGlobalBoolean(L, "onePlayerOnlinePerAccount", true);
	boolean[AIMBOT_HOTKEY_ENABLED] = getGlobalBoolean(L, "hotkeyAimbotEnabled", true);
	boolean[REMOVE_RUNE_CHARGES] = getGlobalBoolean(L, "removeChargesFromRunes", true);
	boolean[EXPERIENCE_FROM_PLAYERS] = getGlobalBoolean(L, "experienceByKillingPlayers", false);
	boolean[FREE_PREMIUM] = getGlobalBoolean(L, "freePremium", false);
	boolean[REPLACE_KICK_ON_LOGIN] = getGlobalBoolean(L, "replaceKickOnLogin", true);
	boolean[ALLOW_CLONES] = getGlobalBoolean(L, "allowClones", false);
	boolean[MARKET_PREMIUM] = getGlobalBoolean(L, "premiumToCreateMarketOffer", true);
	boolean[EMOTE_SPELLS] = getGlobalBoolean(L, "emoteSpells", false);
	boolean[STAMINA_SYSTEM] = getGlobalBoolean(L, "staminaSystem", true);
	boolean[WARN_UNSAFE_SCRIPTS] = getGlobalBoolean(L, "warnUnsafeScripts", true);
	boolean[CONVERT_UNSAFE_SCRIPTS] = getGlobalBoolean(L, "convertUnsafeScripts", true);
	boolean[CLASSIC_EQUIPMENT_SLOTS] = getGlobalBoolean(L, "classicEquipmentSlots", false);
	boolean[CLASSIC_ATTACK_SPEED] = getGlobalBoolean(L, "classicAttackSpeed", false);
	boolean[SPOOF_ENABLED] = getGlobalBoolean(L, "spoofEnabled", false);
	boolean[SCRIPTS_CONSOLE_LOGS] = getGlobalBoolean(L, "showScriptsLogInConsole", true);
	boolean[ALLOW_BLOCK_SPAWN] = getGlobalBoolean(L, "allowBlockSpawn", true);
	boolean[REMOVE_WEAPON_AMMO] = getGlobalBoolean(L, "removeWeaponAmmunition", true);
	boolean[REMOVE_WEAPON_CHARGES] = getGlobalBoolean(L, "removeWeaponCharges", true);
	boolean[REMOVE_POTION_CHARGES] = getGlobalBoolean(L, "removeChargesFromPotions", true);
	boolean[STOREMODULES] = getGlobalBoolean(L, "gamestoreByModules", true);
	boolean[QUEST_LUA] = getGlobalBoolean(L, "loadQuestLua", true);
	boolean[EXPERT_PVP] = getGlobalBoolean(L, "expertPvp", false);
	boolean[SHOW_PACKETS] = getGlobalBoolean(L, "showPackets", false);
	boolean[ENABLE_LIVE_CASTING] = getGlobalBoolean(L, "enableLiveCasting", false);
	boolean[MAINTENANCE] = getGlobalBoolean(L, "maintenance", false);
	boolean[FORCE_MONSTERTYPE_LOAD] = getGlobalBoolean(L, "forceMonsterTypesOnLoad", true);
	boolean[YELL_ALLOW_PREMIUM] = getGlobalBoolean(L, "yellAlwaysAllowPremium", false);
	boolean[BLESS_RUNE] = getGlobalBoolean(L, "blessRune", true);
	boolean[ANTI_MULTI_CLIENT_ENABLED] = getGlobalBoolean(L, "antiMultiClientEnabled", true);
	boolean[ALLOW_MOUNT_IN_PZ] = getGlobalBoolean(L, "allowMountInPz", false);
	boolean[SHOW_KILLS_DEATHS_ON_LOOK] = getGlobalBoolean(L, "showKillsDeathsOnLook", true);
	boolean[BLOCK_SAME_IP_PVP] = getGlobalBoolean(L, "blockSameIpPvp", true);
	boolean[DISABLE_PUSH_CANCEL_ON_SPELLS] = getGlobalBoolean(L, "disablePushCancelOnSpells", false);
	boolean[PUSH_WHEN_ATTACKING] = getGlobalBoolean(L, "pushWhenAttacking", true);

	string[DEFAULT_PRIORITY] = getGlobalString(L, "defaultPriority", "high");
	string[SERVER_NAME] = getGlobalString(L, "serverName", "");
	string[OWNER_NAME] = getGlobalString(L, "ownerName", "");
	string[OWNER_EMAIL] = getGlobalString(L, "ownerEmail", "");
	string[URL] = getGlobalString(L, "url", "");
	string[LOCATION] = getGlobalString(L, "location", "");
	string[MOTD] = getGlobalString(L, "motd", "");
	string[WORLD_TYPE] = getGlobalString(L, "worldType", "pvp");
	string[STORE_IMAGES_URL] = getGlobalString(L, "storeImagesUrl", "http://os.quelibra.online/images/store/");
	string[DEFAULT_OFFER] = getGlobalString(L, "defaultStoreOffer", "Blessings");
	string[BLOCK_WORD] = getGlobalString(L, "blockWord", "");
	string[MONSTER_URL] = getGlobalString(L, "monsterImageUrl", "AnimatedOutfits/outfit.php?");
	string[ITEM_URL] = getGlobalString(L, "itemImagemUrl", "layouts/tibiacom/images/shop/items/");

	integer[MAX_PLAYERS] = getGlobalNumber(L, "maxPlayers");
	integer[PZ_LOCKED] = getGlobalNumber(L, "pzLocked", 60000);
	integer[DEFAULT_DESPAWNRANGE] = getGlobalNumber(L, "deSpawnRange", 2);
	integer[DEFAULT_DESPAWNRADIUS] = getGlobalNumber(L, "deSpawnRadius", 50);
	integer[RATE_EXPERIENCE] = getGlobalNumber(L, "rateExp", 5);
	integer[RATE_SKILL] = getGlobalNumber(L, "rateSkill", 3);
	integer[RATE_LOOT] = getGlobalNumber(L, "rateLoot", 2);
	integer[RATE_MAGIC] = getGlobalNumber(L, "rateMagic", 3);
	integer[RATE_SPAWN] = getGlobalNumber(L, "rateSpawn", 1);
	integer[HOUSE_PRICE] = getGlobalNumber(L, "housePriceEachSQM", 1000);
	integer[ACTIONS_DELAY_INTERVAL] = getGlobalNumber(L, "timeBetweenActions", 200);
	integer[EX_ACTIONS_DELAY_INTERVAL] = getGlobalNumber(L, "timeBetweenExActions", 1000);
	integer[MAX_MESSAGEBUFFER] = getGlobalNumber(L, "maxMessageBuffer", 4);
	integer[KICK_AFTER_MINUTES] = getGlobalNumber(L, "kickIdlePlayerAfterMinutes", 15);
	integer[PROTECTION_LEVEL] = getGlobalNumber(L, "protectionLevel", 1);
	integer[DEATH_LOSE_PERCENT] = getGlobalNumber(L, "deathLosePercent", -1);
	integer[STATUSQUERY_TIMEOUT] = getGlobalNumber(L, "statusTimeout", 5000);
	integer[FRAG_TIME] = getGlobalNumber(L, "timeToDecreaseFrags", 45 * 24 * 60 * 60);
	integer[WHITE_SKULL_TIME] = getGlobalNumber(L, "whiteSkullTime", 15 * 60 * 1000);
	integer[STAIRHOP_DELAY] = getGlobalNumber(L, "stairJumpExhaustion", 2000);
	integer[MAX_CONTAINER] = getGlobalNumber(L, "maxContainer", 500);
	integer[MAX_ITEM] = getGlobalNumber(L, "maxItem", 10000);
	integer[EXP_FROM_PLAYERS_LEVEL_RANGE] = getGlobalNumber(L, "expFromPlayersLevelRange", 75);
	integer[CHECK_EXPIRED_MARKET_OFFERS_EACH_MINUTES] = getGlobalNumber(L, "checkExpiredMarketOffersEachMinutes", 60);
	integer[MAX_MARKET_OFFERS_AT_A_TIME_PER_PLAYER] = getGlobalNumber(L, "maxMarketOffersAtATimePerPlayer", 100);
	integer[MAX_PACKETS_PER_SECOND] = getGlobalNumber(L, "maxPacketsPerSecond", 25);
	integer[STORE_COINS_PACKET_SIZE] = getGlobalNumber(L, "storeCoinsPacketSize", 25);
	integer[DAY_KILLS_TO_RED] = getGlobalNumber(L, "dayKillsToRedSkull", 3);
	integer[WEEK_KILLS_TO_RED] = getGlobalNumber(L, "weekKillsToRedSkull", 5);
	integer[MONTH_KILLS_TO_RED] = getGlobalNumber(L, "monthKillsToRedSkull", 10);
	integer[RED_SKULL_DURATION] = getGlobalNumber(L, "redSkullDuration", 30);
	integer[BLACK_SKULL_DURATION] = getGlobalNumber(L, "blackSkullDuration", 45);
	integer[ORANGE_SKULL_DURATION] = getGlobalNumber(L, "orangeSkullDuration", 7);
	integer[NETWORK_ATTACK_THRESHOLD] = getGlobalNumber(L, "networkAttackThreshold", 10);
	integer[LIVE_CAST_PORT] = getGlobalNumber(L, "liveCastPort", 7173);
	integer[SERVER_SAVE_NOTIFY_DURATION] = getGlobalNumber(L, "serverSaveNotifyDuration", 5);
	integer[YELL_MINIMUM_LEVEL] = getGlobalNumber(L, "yellMinimumLevel", 2);
	integer[TIME_GMT] = getGlobalNumber(L, "timeGMT", -3 * 60 * 60);
	integer[ANTI_MULTI_CLIENT_LIMIT] = getGlobalNumber(L, "antiMultiClientLimit", 4);
	integer[PVP_PROTECTION_LEVEL] = getGlobalNumber(L, "pvpProtectionLevel", 50);
	integer[MAX_ALLOWED_ON_A_DUMMY] = getGlobalNumber(L, "maxAllowedOnADummy", 5);
	integer[RATE_EXERCISE_TRAINING_SPEED] = getGlobalNumber(L, "rateExerciseTrainingSpeed", 1.0);
	integer[SPOOF_DAILY_MIN_PLAYERS] = getGlobalNumber(L, "spoofDailyMinPlayers", 50);
	integer[SPOOF_DAILY_MAX_PLAYERS] = getGlobalNumber(L, "spoofDailyMaxPlayers", 200);
	integer[SPOOF_NOISE_INTERVAL] = getGlobalNumber(L, "spoofNoiseInterval", 10 * 60 * 1000);
	integer[SPOOF_NOISE] = getGlobalNumber(L, "spoofNoise", 10);
	integer[SPOOF_TIMEZONE] = getGlobalNumber(L, "spoofTimezone", -3);
	integer[SPOOF_INTERVAL] = getGlobalNumber(L, "spoofInterval", 60 * 1000);
	integer[SPOOF_CHANGE_CHANCE] = getGlobalNumber(L, "spoofChangeChance", 100);
	integer[SPOOF_INCREMENT_CHANCE] = getGlobalNumber(L, "spoofIncrementChange", 5);
	// Push mechanics
	integer[PUSH_DELAY] = getGlobalNumber(L, "pushDelay", 1);
	integer[PUSH_DISTANCE_DELAY] = getGlobalNumber(L, "pushDistanceDelay", 1);
	integer[RESET_LEVEL] = getGlobalNumber(L, "resetLevel", 100); // reset system
	integer[RESET_STATBONUS] = getGlobalNumber(L, "resetStatBonus", 5); // reset system
	integer[RESET_DMGBONUS] = getGlobalNumber(L, "resetDmgBonus", 10); // reset system
	integer[RESET_DMGBONUS_NEW] = getGlobalNumber(L, "resetDmgBonus", 5); // reset system
	integer[RESET_NEW_LEVEL] = getGlobalNumber(L, "resetNewLevel", 8); // reset new level
	integer[RESET_STAT_BONUS] = getGlobalNumber(L, "resetStatBonus", 2);
	
	integer[RESET_SORCERER_MAGLEVEL] = getGlobalNumber(L, "resetSorcererMagLevel", 10);
	integer[RESET_DRUID_MAGLEVEL] = getGlobalNumber(L, "resetDruidMagLevel", 10);
	integer[RESET_PALADIN_MAGLEVEL] = getGlobalNumber(L, "resetPaladinMagLevel", 3);
	integer[RESET_PALADIN_DISTANCE] = getGlobalNumber(L, "resetPaladinDistance", 10);
	integer[RESET_PALADIN_SHIELD] = getGlobalNumber(L, "resetPaladinShield", 20);
	integer[RESET_KNIGHT_MAGLEVEL] = getGlobalNumber(L, "resetKnightMagLevel", 2);
	integer[RESET_KNIGHT_FIST] = getGlobalNumber(L, "resetKnightFist", 10);
	integer[RESET_KNIGHT_CLUB] = getGlobalNumber(L, "resetKnightClub", 10);
	integer[RESET_KNIGHT_SWORD] = getGlobalNumber(L, "resetKnightSword", 10);
	integer[RESET_KNIGHT_AXE] = getGlobalNumber(L, "resetKnightAxe", 10);
	integer[RESET_KNIGHT_SHIELD] = getGlobalNumber(L, "resetKnightShield", 20); 

	integer[MAX_CRITICAL_CHANCE] = getGlobalNumber(L, "maxCriticalChance", 50);
	integer[CRITICAL_SKILL_DIVISOR] = getGlobalNumber(L, "criticalSkillDivisor", 5);
	integer[STORAGEVALUE_EMOTE] = getGlobalNumber(L, "emoteStorage", 90001);
	integer[STORAGEVALUE_HIDDEN] = getGlobalNumber(L, "hiddenStorage", 90002);

	floating[RATE_MONSTER_HEALTH] = getGlobalFloat(L, "rateMonsterHealth", 1.0);
	floating[RATE_MONSTER_ATTACK] = getGlobalFloat(L, "rateMonsterAttack", 1.0);
	floating[RATE_MONSTER_DEFENSE] = getGlobalFloat(L, "rateMonsterDefense", 1.0);
	floating[RATE_HEALTH_REGEN] = getGlobalFloat(L, "rateHealthRegen", 1.0);
	floating[RATE_HEALTH_REGEN_SPEED] = getGlobalFloat(L, "rateHealthRegenSpeed", 1.0);
	floating[RATE_MANA_REGEN] = getGlobalFloat(L, "rateManaRegen", 1.0);
	floating[RATE_MANA_REGEN_SPEED] = getGlobalFloat(L, "rateManaRegenSpeed", 1.0);
	floating[RATE_SOUL_REGEN] = getGlobalFloat(L, "rateSoulRegen", 1.0);
	floating[RATE_SOUL_REGEN_SPEED] = getGlobalFloat(L, "rateSoulRegenSpeed", 1.0);
	floating[RATE_ATTACK_SPEED] = getGlobalFloat(L, "rateAttackSpeed", 1.0);
	floating[CRITICAL_HEAL_PERCENT_KNIGHT] = getGlobalFloat(L, "criticalHealPercentKnight", 15.0);
	floating[CRITICAL_HEAL_PERCENT_PALADIN] = getGlobalFloat(L, "criticalHealPercentPaladin", 12.0);
	floating[CRITICAL_HEAL_PERCENT_MAGE] = getGlobalFloat(L, "criticalHealPercentMage", 10.0);
	floating[CRITICAL_HEAL_PERCENT_DRUID] = getGlobalFloat(L, "criticalHealPercentDruid", 10.0);
	floating[CRITICAL_HEAL_PERCENT_GOD] = getGlobalFloat(L, "criticalHealPercentGod", 5.0);
	floating[CRITICAL_MULTIPLIER_KNIGHT] = getGlobalFloat(L, "criticalMultiplierKnight", 1.5f);
	floating[CRITICAL_MULTIPLIER_PALADIN] = getGlobalFloat(L, "criticalMultiplierPaladin", 1.4f);
	floating[CRITICAL_MULTIPLIER_MAGE] = getGlobalFloat(L, "criticalMultiplierMage", 1.3f);
	floating[CRITICAL_MULTIPLIER_DRUID] = getGlobalFloat(L, "criticalMultiplierDruid", 1.3f);
	


	doubling[RATE_MONSTER_SPEED] = getGlobalDouble(L, "rateMonsterSpeed", 1.95);

	expStages = loadXMLStages();
	if (expStages.empty()) {
		expStages = loadLuaStages(L);
	} else {
		std::cout << "[Warning - ConfigManager::load] XML stages are deprecated, consider moving to config.lua." << std::endl;
	}
	expStages.shrink_to_fit();

	skillStages = loadXMLSkillStages();
	if (skillStages.empty()) {
		skillStages = loadLuaSkillStages(L);
	} else {
		std::cout << "[Warning - ConfigManager::load] XML skill stages are deprecated, consider moving to config.lua." << std::endl;
	}
	skillStages.shrink_to_fit();

	magicLevelStages = loadXMLMagicLevelStages();
	if (magicLevelStages.empty()) {
		magicLevelStages = loadLuaMagicLevelStages(L);
	} else {
		std::cout << "[Warning - ConfigManager::load] XML magic level stages are deprecated, consider moving to config.lua." << std::endl;
	}
	magicLevelStages.shrink_to_fit();

	loaded = true;
	lua_close(L);
	return true;
}

bool ConfigManager::reload()
{
	bool result = load();
	if (transformToSHA1(getString(ConfigManager::MOTD)) != g_game.getMotdHash()) {
		g_game.incrementMotdNum();
	}
	return result;
}

static std::string dummyStr;

const std::string& ConfigManager::getString(string_config_t what) const
{
	if (what >= LAST_STRING_CONFIG) {
		console::print(CONSOLEMESSAGE_TYPE_WARNING, "[Warning - ConfigManager::getString] Accessing invalid index: " + std::to_string(what));
		return dummyStr;
	}
	return string[what];
}

int32_t ConfigManager::getNumber(integer_config_t what) const
{
	if (what >= LAST_INTEGER_CONFIG) {
		console::print(CONSOLEMESSAGE_TYPE_WARNING, "[Warning - ConfigManager::getNumber] Accessing invalid index: " + std::to_string(what));
		return 0;
	}
	return integer[what];
}

static ConfigManager::ProxyInfo dummyInfo;
std::pair<bool, const ConfigManager::ProxyInfo&> ConfigManager::getProxyInfo(uint16_t proxyId) {
	auto it = proxyList.find(proxyId);
	if (it == proxyList.end()) {
		return {false, dummyInfo};
	}

	return {true, it->second};
}

bool ConfigManager::getBoolean(boolean_config_t what) const
{
	if (what >= LAST_BOOLEAN_CONFIG) {
		console::print(CONSOLEMESSAGE_TYPE_WARNING, "[Warning - ConfigManager::getBoolean] Accessing invalid index: " + std::to_string(what));
		return false;
	}
	return boolean[what];
}

float ConfigManager::getFloat(floating_config_t what) const
{
	if (what >= LAST_FLOATING_CONFIG) {
		console::print(CONSOLEMESSAGE_TYPE_WARNING, "[Warning - ConfigManager::getFLoat] Accessing invalid index: " + std::to_string(what));
		return 0;
	}
	return floating[what];
}

double ConfigManager::getDouble(doubling_config_t what) const
{
	if (what >= LAST_DOUBLING_CONFIG) {
		console::print(CONSOLEMESSAGE_TYPE_WARNING, "[Warning - ConfigManager::getDouble] Accessing invalid index: " + std::to_string(what));
		return 0;
	}
	return doubling[what];
}

void ConfigManager::setString(string_config_t what, const std::string& value)
{
	if (what >= LAST_STRING_CONFIG) {
		console::print(CONSOLEMESSAGE_TYPE_WARNING, "[Warning - ConfigManager::setString] Accessing invalid index: " + std::to_string(what));
		return;
	}
	string[what] = value;
}

void ConfigManager::setNumber(integer_config_t what, int32_t value)
{
	if (what >= LAST_INTEGER_CONFIG) {
		console::print(CONSOLEMESSAGE_TYPE_WARNING, "[Warning - ConfigManager::setNumber] Accessing invalid index: " + std::to_string(what));
		return;
	}
	integer[what] = value;
}

float ConfigManager::getExperienceStage(uint32_t level) const
{
	auto it = std::find_if(expStages.begin(), expStages.end(), [level](auto&& stage) {
		auto&& [minLevel, maxLevel, _] = stage;
		return level >= minLevel && level <= maxLevel;
	});

	if (it == expStages.end()) {
		return getNumber(ConfigManager::RATE_EXPERIENCE);
	}

	auto&& [minLevel, maxLevel, multiplier] = *it;
	return multiplier;
}

float ConfigManager::getSkillStage(uint32_t skill) const
{
	auto it = std::find_if(skillStages.begin(), skillStages.end(), [skill](auto&& stage) {
		auto&& [minSkill, maxSkill, _] = stage;
		return skill >= minSkill && skill <= maxSkill;
	});

	if (it == skillStages.end()) {
		return getNumber(ConfigManager::RATE_SKILL);
	}

	auto&& [minSkill, maxSkill, multiplier] = *it;
	return multiplier;
}

float ConfigManager::getMagicLevelStage(uint32_t magicLevel) const
{
	auto it = std::find_if(magicLevelStages.begin(), magicLevelStages.end(), [magicLevel](auto&& stage) {
		auto&& [minMagic, maxMagic, _] = stage;
		return magicLevel >= minMagic && magicLevel <= maxMagic;
	});

	if (it == magicLevelStages.end()) {
		return getNumber(ConfigManager::RATE_MAGIC);
	}

	auto&& [minMagic, maxMagic, multiplier] = *it;
	return multiplier;
}
