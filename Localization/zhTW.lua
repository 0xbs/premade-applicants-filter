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

if GetLocale() ~= "zhTW" then return end

L["error.syntax"] = "|cffff0000過濾語法錯誤|r\n\n表示過濾語法不正確，例如缺少過濾條件、變數或運算符號，或是寫成 'tanks=1' 而不是 'tanks==1'。\n\n詳細錯誤訊息：\n|cffaaaaaa%s|r"
L["error.semantic"] = "|cffff0000過濾語法的語意錯誤|r\n\n表示過濾語法正確，但是很可能變數寫錯字，例如寫成 tansk 而不是 tanks。\n\n詳細錯誤訊息：\n|cffaaaaaa%s|r"
