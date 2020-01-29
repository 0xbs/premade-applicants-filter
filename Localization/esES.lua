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

if GetLocale() ~= "esES" then return end

L["button.ok"] = "OK"
L["error.syntax"] = "|cffff0000Error en la sintaxis de la expresión avanzada|r\n\nEsto significa que no se ha construido de la manera correcta, por ejemplo, se te olvido poner un paréntesis o escribiste 'tanks=1' en vez de 'tanks==1'.\n\nError detallado:\n|cffaaaaaa%s|r"
L["error.semantic"] = "|cffff0000Error Semántico en la expresión|r\n\nEsto signuifica que la sintaxis es correcta, pero lo mas seguro es que hayas escrito las variables mal, por ejemplo, tansk en vez de tanks.\n\nError detallado:\n|cffaaaaaa%s|r"
