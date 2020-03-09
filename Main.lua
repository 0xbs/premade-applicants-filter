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

function PAF.GetModel()
    return PremadeApplicantsFilterState
end

function PAF.DoFilterSearchResults(applicants)
    local model = PAF.GetModel()
    local exp = model.expression
    if not model or not model.enabled then return false end
    if not applicants or #applicants == 0 then return false end
    exp = PAF.TrimWhitespace(exp)
    if not exp or exp == "" then return false end -- skip trivial expression

    for idx = #applicants, 1, -1 do
        local applicantID = applicants[idx]
        local applicantInfo = C_LFGList.GetApplicantInfo(applicantID);
        -- Fields in applicantInfo:
        -- applicationStatus, pendingApplicationStatus, numMembers, isNew, comment, displayOrderID
        if applicantInfo.pendingApplicationStatus or applicantInfo.applicationStatus == "applied" then

            local memberEnvs = {}
            for memberIdx = 1, applicantInfo.numMembers do
                local name, class, localizedClass, level, itemLevel, honorLevel, tank, healer, damage,
                assignedRole, relationship = C_LFGList.GetApplicantMemberInfo(applicantID, memberIdx)

                local env = {}
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
                env.range = C.DPS_CLASS_TYPE[class:upper()].range
                env.melee = C.DPS_CLASS_TYPE[class:upper()].melee
                for someClass, _ in pairs(C.DPS_CLASS_TYPE) do
                    env[someClass:lower()] = someClass == class:upper()
                end
                PAF.PutRaiderIOMetrics(env, name)
                PAF.PutPremadeRegionInfo(env, name)

                memberEnvs[memberIdx] = env
            end

            local applicantEnv = {}
            applicantEnv.members = applicantInfo.numMembers
            applicantEnv.some = function (subexp)
                for _, subenv in pairs(memberEnvs) do
                    if PAF.DoesPassThroughFilter(subenv, subexp) then
                        return true
                    end
                end
                return false
            end
            applicantEnv.all = function (subexp)
                local total = true
                for _, subenv in pairs(memberEnvs) do
                    local result = PAF.DoesPassThroughFilter(subenv, subexp)
                    total = total and result
                end
                return total
            end
            applicantEnv.every = function (subexp) return env.all(subexp) end
            applicantEnv.exists = function (subexp) return env.some(subexp) end
            applicantEnv.none = function (subexp) return not env.some(subexp) end
            if not PAF.DoesPassThroughFilter(applicantEnv, exp) then
                table.remove(applicants, idx)
            end

        end
    end
end

hooksecurefunc("LFGListUtil_SortApplicants", PAF.DoFilterSearchResults)
