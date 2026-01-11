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

PremadeApplicantsFilter = {}
PremadeApplicantsFilterState = PremadeApplicantsFilterState or {
    version = 1,
    enabled = true,
    expression = ""
}

local PAFAddonName = select(1, ...)
local PAF = select(2, ...)

PremadeApplicantsFilter.Debug = PAF

PAF.L = {}
PAF.C = {}

local L = PAF.L
local C = PAF.C

C.ROLE_PREFIX = {
    ["DAMAGER"] = "dps",
    ["HEALER"] = "heal",
    ["TANK"] = "tank",
}

C.ROLE_SUFFIX = {
    ["DAMAGER"] = "dps",
    ["HEALER"] = "heals",
    ["TANK"] = "tanks",
}

function PAF.OnAddonLoaded(name)
    if name == PAFAddonName then
        PAF.InitSpecializations()
    end
end

function PAF.OnEvent(self, event, ...)
    if event == "ADDON_LOADED" then PAF.OnAddonLoaded(...) end
end

local frame = CreateFrame("Frame", "PremadeApplicantsFilterEventFrame")
frame:RegisterEvent("ADDON_LOADED")
frame:SetScript("OnEvent", PAF.OnEvent)
