-------------------------------------------------------------------------------
-- Premade Applicants Filter
-------------------------------------------------------------------------------
-- Copyright (C) 2020 Elotheon-Arthas-EU
--
-- This program is free software: you can redistribute it and/or modify it
-- under the terms of the GNU General Public License as published by the Free
-- Software Foundation, version 3.
--
-- This program is distributed in the hope that it will be useful, but WITHOUT
-- ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
-- FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
-- more details.
--
-- You should have received a copy of the GNU General Public License along with
-- this program. If not, see <https://www.gnu.org/licenses/>.
-------------------------------------------------------------------------------

local PAF = select(2, ...)
local L = PAF.L
local C = PAF.C

if GetLocale() ~= "koKR" then return end

L["button.ok"] = "OK"
L["error.syntax"] = "|cffff0000필터 표현에 구문 오류|r\n\n이것은 당신의 필터 표현이 올바르게 만들어 지지 않은 걸 의미합니다, 예. 괄호를 빠뜨리거나 'tanks==1' 대신 'tanks=1'이라고 쓴 경우입니다.\n\n자세한 오류 메시지:\n|cffaaaaaa%s|r"
L["error.semantic"] = "|cffff0000필터 표현에 의미 오류|r\n\n이것은 당신의 필터 표현이 구문은 맞지만, 변수 이름의 철자가 틀린 것 같습니다, 예. tanks 대신 tansk라고 쓴 경우입니다.\n\n자세한 오류 메시지:\n|cffaaaaaa%s|r"
