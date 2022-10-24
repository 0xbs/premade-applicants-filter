-------------------------------------------------------------------------------
-- Premade Applicants Filter
-------------------------------------------------------------------------------
-- Copyright (C) 2022 Elotheon-Arthas-EU
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

if GetLocale() ~= "frFR" then return end

L["error.syntax"] = "|cffff0000Erreur de syntaxe dans le filtre d'expression|r\n\nCela indique que vous avez fait une erreur dans l'expression avancée, ex: il manque une paranthèse ou vous avez écrit 'tanks=1' au lieu de 'tanks==1'.\n\nMessage d'erreur détaillé:\n|cffaaaaaa%s|r"
L["error.semantic"] = "|cffff0000Erreur sémantique dans le filtre d'expression|r\n\nCela indique que votre syntaxe est bonne mais que vous avez mal écrit le nom d'une variable, ex: tansk au lieu de tanks.\n\nMessage d'erreur détaillé:\n|cffaaaaaa%s|r"
