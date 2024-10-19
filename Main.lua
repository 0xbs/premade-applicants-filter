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

C.DPS_CLASS_TYPE = {
    ["DEATHKNIGHT"] = { range = false, melee = true,  armor = "plate"   },
    ["DEMONHUNTER"] = { range = false, melee = true,  armor = "leather" },
    ["DRUID"]       = { range = true,  melee = true,  armor = "leather" },
    ["EVOKER"]      = { range = true,  melee = false, armor = "mail"    },
    ["HUNTER"]      = { range = true,  melee = true,  armor = "mail"    },
    ["PALADIN"]     = { range = false, melee = true,  armor = "plate"   },
    ["PRIEST"]      = { range = true,  melee = false, armor = "cloth"   },
    ["MAGE"]        = { range = true,  melee = false, armor = "cloth"   },
    ["MONK"]        = { range = false, melee = true,  armor = "leather" },
    ["ROGUE"]       = { range = false, melee = true,  armor = "leather" },
    ["SHAMAN"]      = { range = true,  melee = true,  armor = "mail"    },
    ["WARLOCK"]     = { range = true,  melee = false, armor = "cloth"   },
    ["WARRIOR"]     = { range = false, melee = true,  armor = "plate"   },
}

-- Translates tier enum values into normalized values - check via /dump PVPUtil.GetTierName(1)
C.TIER_MAP = {
    [0] = 0, -- Unranked
    [1] = 1, -- Combatant I
    [2] = 3, -- Challenger I
    [3] = 5, -- Rival I
    [4] = 7, -- Duelist
    [5] = 8, -- Elite
    [6] = 2, -- Combatant II
    [7] = 4, -- Challenger II
    [8] = 6, -- Rival II
}

function PAF.GetModel()
    return PremadeApplicantsFilterState
end

function PAF.GetAverageMpRating(applicantID, applicantInfo, activeEntryActivityID)
    local ratingSum = 0
    for memberIdx = 1, applicantInfo.numMembers do
        local dungeonScore = select(12, C_LFGList.GetApplicantMemberInfo(applicantID, memberIdx))
        ratingSum = ratingSum + (dungeonScore or 0)
    end
    return ratingSum / applicantInfo.numMembers
end

function PAF.GetAveragePvpRating(applicantID, applicantInfo, activeEntryActivityID)
    local ratingSum = 0
    for memberIdx = 1, applicantInfo.numMembers do
        local pvpRatingForEntry = C_LFGList.GetApplicantPvpRatingInfoForListing(applicantID, memberIdx, activeEntryActivityID)
        ratingSum = ratingSum + (pvpRatingForEntry and pvpRatingForEntry.rating or 0)
    end
    return ratingSum / applicantInfo.numMembers
end

function PAF.GetSortingFunc(activityID, activityInfo)
    return function(applicantID1, applicantID2)
        local applicantInfo1 = C_LFGList.GetApplicantInfo(applicantID1)
        local applicantInfo2 = C_LFGList.GetApplicantInfo(applicantID2)

        -- sort by status first
        if applicantInfo1.applicationStatus ~= applicantInfo2.applicationStatus then
            return applicantInfo1.applicationStatus < applicantInfo2.applicationStatus
        end

        -- sort by rating if rated activity
        if activityInfo.isMythicPlusActivity then
            local rating1 = PAF.GetAverageMpRating(applicantID1, applicantInfo1, activityID)
            local rating2 = PAF.GetAverageMpRating(applicantID2, applicantInfo2, activityID)
            return rating1 > rating2
        elseif activityInfo.isRatedPvpActivity then
            local rating1 = PAF.GetAveragePvpRating(applicantID1, applicantInfo1, activityID)
            local rating2 = PAF.GetAveragePvpRating(applicantID2, applicantInfo2, activityID)
            return rating1 > rating2
        end

        -- sort new items to the bottom
        if applicantInfo1.isNew ~= applicantInfo2.isNew then
            return applicantInfo2.isNew
        end

        -- sort by display order
        return applicantInfo1.displayOrderID < applicantInfo2.displayOrderID
    end
end

function PAF.DoFilterSearchResults(applicants)
    local model = PAF.GetModel()
    local exp = model.expression
    if not model or not model.enabled then return false end
    if not applicants or #applicants == 0 then return false end
    exp = PAF.TrimWhitespace(exp)
    if not exp or exp == "" then return false end -- skip trivial expression

    local activeEntryInfo = C_LFGList.GetActiveEntryInfo()
    if not activeEntryInfo then return end
    local activityID = activeEntryInfo.activityID
    local activityInfo = C_LFGList.GetActivityInfoTable(activityID)

    for idx = #applicants, 1, -1 do
        local applicantID = applicants[idx]
        local applicantInfo = C_LFGList.GetApplicantInfo(applicantID);
        -- Fields in applicantInfo:
        -- applicationStatus, pendingApplicationStatus, numMembers, isNew, comment, displayOrderID
        if applicantInfo.pendingApplicationStatus or applicantInfo.applicationStatus == "applied" then

            local memberEnvs = {}
            for memberIdx = 1, applicantInfo.numMembers do
                local name, class, localizedClass, level, itemLevel, honorLevel, tank, healer, damage,
                assignedRole, relationship, dungeonScore, pvpItemLevel = C_LFGList.GetApplicantMemberInfo(applicantID, memberIdx)
                local bestDungeonScoreForEntry = C_LFGList.GetApplicantDungeonScoreForListing(applicantID, memberIdx, activityID)
                local pvpRatingForEntry = C_LFGList.GetApplicantPvpRatingInfoForListing(applicantID, memberIdx, activityID)

                local env = {}
                env.level = level
                env.ilvl = itemLevel
                env.myilvl = select(2, GetAverageItemLevel())
                env.pvpilvl = pvpItemLevel or 0
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
                    env[someClass:lower()] = class:upper() == someClass
                end
                env.plate = C.DPS_CLASS_TYPE[class:upper()].armor == "plate"
                env.mail = C.DPS_CLASS_TYPE[class:upper()].armor == "mail"
                env.leather = C.DPS_CLASS_TYPE[class:upper()].armor == "leather"
                env.cloth = C.DPS_CLASS_TYPE[class:upper()].armor == "cloth"
                env.hasbr = env.druid or env.paladin or env.warlock or env.deathknight
                env.hasbl = env.shaman or env.evoker or env.hunter or env.mage
                env.mprating = dungeonScore or 0
                env.mpmaprating = 0
                env.mpmapname   = ""
                env.mpmapmaxkey = 0
                env.mpmapintime = false
                if bestDungeonScoreForEntry then
                    env.mpmaprating = bestDungeonScoreForEntry.mapScore
                    env.mpmapname   = bestDungeonScoreForEntry.mapName
                    env.mpmapmaxkey = bestDungeonScoreForEntry.bestRunLevel
                    env.mpmapintime = bestDungeonScoreForEntry.finishedSuccess
                end
                env.pvpactivityname = ""
                env.pvprating = 0
                env.pvptierx = 0
                env.pvptier = 0
                env.pvptiername = ""
                if pvpRatingForEntry then
                    env.pvpactivityname = pvpRatingForEntry.activityName
                    env.pvprating       = pvpRatingForEntry.rating
                    env.pvptierx        = pvpRatingForEntry.tier
                    env.pvptier         = C.TIER_MAP[pvpRatingForEntry.tier]
                    env.pvptiername     = PVPUtil.GetTierName(pvpRatingForEntry.tier)
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
            applicantEnv.every = function (subexp) return applicantEnv.all(subexp) end
            applicantEnv.exists = function (subexp) return applicantEnv.some(subexp) end
            applicantEnv.none = function (subexp) return not applicantEnv.some(subexp) end
            if not PAF.DoesPassThroughFilter(applicantEnv, exp) then
                table.remove(applicants, idx)
            end

        end
    end

    table.sort(applicants, PAF.GetSortingFunc(activityID, activityInfo))
end

hooksecurefunc("LFGListUtil_SortApplicants", PAF.DoFilterSearchResults)
