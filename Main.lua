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

C.DPS_CLASS_TYPE = {
    ["DEATHKNIGHT"] = { range = false, melee = true },
    ["DEMONHUNTER"] = { range = false, melee = true },
    ["DRUID"]       = { range = true,  melee = true },
    ["HUNTER"]      = { range = true,  melee = true },
    ["PALADIN"]     = { range = false, melee = true },
    ["PRIEST"]      = { range = true,  melee = false },
    ["MAGE"]        = { range = true,  melee = false },
    ["MONK"]        = { range = false, melee = true },
    ["ROGUE"]       = { range = false, melee = true },
    ["SHAMAN"]      = { range = true,  melee = true },
    ["WARLOCK"]     = { range = true,  melee = false },
    ["WARRIOR"]     = { range = false, melee = true },
}

function PAF.DoFilterSearchResults(applicants)
    local model = PremadeGroupsFilterState
    local exp = model.expression
    if not model or not model.enabled then return false end
    if not applicants or #applicants == 0 then return false end

    for idx = #applicants, 1, -1 do
        local applicantDoesPass = true
        local applicantID = applicants[idx]
        local applicantInfo = C_LFGList.GetApplicantInfo(applicantID);
        -- Fields in applicantInfo:
        -- applicationStatus, pendingApplicationStatus, numMembers, isNew, comment, displayOrderID
        if applicantInfo.pendingApplicationStatus or applicantInfo.applicationStatus == "applied" then
            local env = {}
            env.members = applicantInfo.numMembers

            for memberIdx = 1, applicantInfo.numMembers do
                local name, class, localizedClass, level, itemLevel, honorLevel, tank, healer, damage,
                assignedRole, relationship = C_LFGList.GetApplicantMemberInfo(applicantID, memberIdx)

                env.level = level
                env.ilvl = itemLevel
                env.myilvl = select(2, GetAverageItemLevel())
                env.hlvl = honorLevel
                env.relationship = relationship
                env.friend = relationship == "friend"
                env.guild = relationship == "guild"
                env.tank = tank
                env.healer = healer
                env.heal = healer
                env.damage = damage
                env.dps = damage
                env[class:lower()] = true
                env.range = C.DPS_CLASS_TYPE[class].range
                env.melee = C.DPS_CLASS_TYPE[class].melee
                PAF.PutRaiderIOMetrics(env, name)
                PAF.PutPremadeRegionInfo(env, name)

                -- check each applicant member individually
                applicantDoesPass = applicantDoesPass and PAF.DoesPassThroughFilter(env, exp)
            end
        end

        if not applicantDoesPass then
            table.remove(applicants, idx)
        end
    end
end

hooksecurefunc("LFGListUtil_SortApplicants", PAF.DoFilterSearchResults)
