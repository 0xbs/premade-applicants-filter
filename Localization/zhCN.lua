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

if GetLocale() ~= "zhCN" then return end

L["button.ok"] = "确定"
L["error.syntax"] = "|cffff0000过滤语法错误|r\n\n表示过滤语法不正确，例如缺少过滤条件、变量或运算符号，或是写成 'tanks=1' 格式而不是 'tanks==1'。\n\n详细错误信息：\n|cffaaaaaa%s|r"
L["error.semantic"] = "|cffff0000过滤语法的语义错误|r\n\n表示过滤语法正确，但是很可能变量名错误，例如写成 tansk 而不是 tanks。\n\n详细错误信息：\n|cffaaaaaa%s|r"
