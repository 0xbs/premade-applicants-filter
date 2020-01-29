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

if GetLocale() ~= "deDE" then return end

L["button.ok"] = "OK"
L["error.syntax"] = "|cffff0000Syntaxfehler im Filterausdruck|r\n\nDas bedeutet, dass dein Filterausdruck nicht korrekt aufgebaut ist, z.B. fehlt eine schließende Klammer oder du hast 'tanks=1' statt 'tanks==1' geschrieben.\n\nTechnische Fehlermeldung:\n|cffaaaaaa%s|r"
L["error.semantic"] = "|cffff0000Semantischer Fehler im Filterausdruck|r\n\nDas bedeutet, dass dein Filterausdruck syntaktisch korrekt ist, aber du dich vermutlich beim Namen einer Variable vertippt hast, z.B. tansk statt tanks.\n\nTechnische Fehlermeldung:\n|cffaaaaaa%s|r"
