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

#ifndef FS_PUGICAST_H_07810DF7954D411EB14A16C3ED2A7548
#define FS_PUGICAST_H_07810DF7954D411EB14A16C3ED2A7548

namespace pugi {
	template<class T> T cast(const char* str);

	template<> inline float cast(const char* str) { return std::strtof(str, nullptr); }
	template<> inline double cast(const char* str) { return std::strtod(str, nullptr); }
	template<> inline long cast(const char* str) { return std::strtol(str, nullptr, 0); }
	template<> inline long long cast(const char* str) { return std::strtoll(str, nullptr, 0); }
	template<> inline unsigned long cast(const char* str) { return std::strtoul(str, nullptr, 0); }
	template<> inline unsigned long long cast(const char* str) { return std::strtoull(str, nullptr, 0); }

	template<> inline char cast(const char* str) { return static_cast<char>(cast<long>(str)); }
	template<> inline signed char cast(const char* str) { return static_cast<signed char>(cast<long>(str)); }
	template<> inline short cast(const char* str) { return static_cast<short>(cast<long>(str)); }
	template<> inline int cast(const char* str) { return static_cast<int>(cast<long>(str)); }
	template<> inline unsigned char cast(const char* str) { return static_cast<unsigned char>(cast<unsigned long>(str)); }
	template<> inline unsigned short cast(const char* str) { return static_cast<unsigned short>(cast<unsigned long>(str)); }
	template<> inline unsigned int cast(const char* str) { return static_cast<unsigned int>(cast<unsigned long>(str)); }
}

#endif
