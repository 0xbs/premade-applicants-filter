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

L["button.ok"] = "OK"
L["error.syntax"] = "|cffff0000Syntax error in filter expression|r\n\nThis means your filter expression is not built in the right way, e.g. there is a paranthesis missing or you wrote 'tanks=1' instead of 'tanks==1'.\n\nDetailed error message:\n|cffaaaaaa%s|r"
L["error.semantic"] = "|cffff0000Semantic error in filter expression|r\n\nThis means your filter expression has correct syntax, but you most likely mispelled the name of a variable, e.g. tansk instead of tanks.\n\nDetailed error message:\n|cffaaaaaa%s|r"

L["dialog.usepaf.tooltip"] = "PAF"
L["dialog.explanation"] = "Enter a filter expression to show only matching applicants:"
L["dialog.tooltip.title"] = "Filter Expressions"
L["dialog.tooltip.examples"] = "Examples"
L["dialog.tooltip.variable"] = "Variable"
L["dialog.tooltip.description"] = "Description"
L["dialog.tooltip.level"] = "applicant level"
L["dialog.tooltip.ilvl"] = "maximum item level"
L["dialog.tooltip.hlvl"] = "honor level"
L["dialog.tooltip.friend"] = "if applicant is in your friend list"
L["dialog.tooltip.guild"] = "if applicant is in your guild"
L["dialog.tooltip.tank"] = "if applicant would like to play tank"
L["dialog.tooltip.heal"] = "if applicant would like to play heal"
L["dialog.tooltip.dps"] = "if applicant would like to play damage dealer"
L["dialog.tooltip.range"] = "if applicant's class can be a ranged class"
L["dialog.tooltip.melee"] = "if applicant's class can be a melee class"
