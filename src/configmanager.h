/**
 * The Forgotten Server - a free and open-source MMORPG server emulator
 * Copyright (C) 2019  Mark Samman <mark.samman@gmail.com>
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

#ifndef FS_CONFIGMANAGER_H_6BDD23BD0B8344F4B7C40E8BE6AF6F39
#define FS_CONFIGMANAGER_H_6BDD23BD0B8344F4B7C40E8BE6AF6F39

#include <utility>
#include <vector>

using ExperienceStages = std::vector<std::tuple<uint32_t, uint32_t, float>>;

class ConfigManager
{
	public:
		ConfigManager();

		enum boolean_config_t {
			ALLOW_CHANGEOUTFIT,
			ONE_PLAYER_ON_ACCOUNT,
			AIMBOT_HOTKEY_ENABLED,
			REMOVE_RUNE_CHARGES,
			REMOVE_WEAPON_AMMO,
			REMOVE_WEAPON_CHARGES,
			REMOVE_POTION_CHARGES,
			PZLOCK_SKULL_ATTACKER,
			EXPERIENCE_FROM_PLAYERS,
			FREE_PREMIUM,
			REPLACE_KICK_ON_LOGIN,
			ALLOW_CLONES,
			ALLOW_WALKTHROUGH,
			BIND_ONLY_GLOBAL_ADDRESS,
			OPTIMIZE_DATABASE,
			EMOTE_SPELLS,
			STAMINA_SYSTEM,
			WARN_UNSAFE_SCRIPTS,
			CONVERT_UNSAFE_SCRIPTS,
			CLASSIC_EQUIPMENT_SLOTS,
			CLASSIC_ATTACK_SPEED,
			SCRIPTS_CONSOLE_LOGS,
			SERVER_SAVE_NOTIFY_MESSAGE,
			SERVER_SAVE_CLEAN_MAP,
			SERVER_SAVE_CLOSE,
			SERVER_SAVE_SHUTDOWN,
			ONLINE_OFFLINE_CHARLIST,
			YELL_ALLOW_PREMIUM,
			FORCE_MONSTERTYPE_LOAD,
			DEFAULT_WORLD_LIGHT,
			HOUSE_OWNED_BY_ACCOUNT,
			LUA_ITEM_DESC,
			CLEAN_PROTECTION_ZONES,
			HOUSE_DOOR_SHOW_PRICE,
			ONLY_INVITED_CAN_MOVE_HOUSE_ITEMS,
			REMOVE_ON_DESPAWN,
			PLAYER_CONSOLE_LOGS,

			LAST_BOOLEAN_CONFIG /* this must be the last one */
		};

		enum string_config_t {
			IP_STRING,
			MAP_NAME,
			HOUSE_RENT_PERIOD,
			SERVER_NAME,
			OWNER_NAME,
			OWNER_EMAIL,
			URL,
			LOCATION,
			MOTD,
			WORLD_TYPE,
			MYSQL_HOST,
			MYSQL_USER,
			MYSQL_PASS,
			MYSQL_DB,
			MYSQL_SOCK,
			DEFAULT_PRIORITY,
			MAP_AUTHOR,
			CONFIG_FILE,

			LAST_STRING_CONFIG /* this must be the last one */
		};

		enum integer_config_t {
			IP,
			SQL_PORT,
			MAX_PLAYERS,
			PZ_LOCKED,
			DEFAULT_DESPAWNRANGE,
			DEFAULT_DESPAWNRADIUS,
			DEFAULT_WALKTOSPAWNRADIUS,
			RATE_EXPERIENCE,
			RATE_SKILL,
			RATE_LOOT,
			RATE_MAGIC,
			RATE_SPAWN,
			HOUSE_PRICE,
			KILLS_TO_RED,
			KILLS_TO_BLACK,
			MAX_MESSAGEBUFFER,
			ACTIONS_DELAY_INTERVAL,
			EX_ACTIONS_DELAY_INTERVAL,
			KICK_AFTER_MINUTES,
			PROTECTION_LEVEL,
			DEATH_LOSE_PERCENT,
			STATUSQUERY_TIMEOUT,
			FRAG_TIME,
			WHITE_SKULL_TIME,
			GAME_PORT,
			LOGIN_PORT,
			STATUS_PORT,
			STAIRHOP_DELAY,
			EXP_FROM_PLAYERS_LEVEL_RANGE,
			MAX_PACKETS_PER_SECOND,
			SERVER_SAVE_NOTIFY_DURATION,
			YELL_MINIMUM_LEVEL,
			VIP_FREE_LIMIT,
			VIP_PREMIUM_LIMIT,
			DEPOT_FREE_LIMIT,
			DEPOT_PREMIUM_LIMIT,

			LAST_INTEGER_CONFIG /* this must be the last one */
		};

		bool load();
		bool reload();

		const std::string& getString(string_config_t what) const;
		int32_t getNumber(integer_config_t what) const;
		bool getBoolean(boolean_config_t what) const;
		float getExperienceStage(uint32_t level) const;

		bool setString(string_config_t what, const std::string& value);
		bool setNumber(integer_config_t what, int32_t value);
		bool setBoolean(boolean_config_t what, bool value);

	private:
		std::string string[LAST_STRING_CONFIG] = {};
		int32_t integer[LAST_INTEGER_CONFIG] = {};
		bool boolean[LAST_BOOLEAN_CONFIG] = {};

		ExperienceStages expStages = {};

		bool loaded = false;
};

#endif
