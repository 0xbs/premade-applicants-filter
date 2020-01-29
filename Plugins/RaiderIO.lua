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

--- Fetches Raider.IO metrics if installed and provides them in the filter environment
--- @generic V
--- @param env table<string, V> environment to be prepared
--- @param playerName string name of the player
function PAF.PutRaiderIOMetrics(env, playerName)
    env.hasrio            = false
    env.norio             = true
    env.rio               = 0
    env.rioprev           = 0
    env.riomain           = 0
    env.riomainprev       = 0
    env.riokey5plus       = 0
    env.riokey10plus      = 0
    env.riokey15plus      = 0
    env.riokey20plus      = 0
    env.riokeymax         = 0
    env.rionormalprogress = 0
    env.rioheroicprogress = 0
    env.riomythicprogress = 0
    env.riomainprogress   = 0
    env.rionormalkills    = {}
    env.rioheroickills    = {}
    env.riomythickills    = {}
    env.rioraidbosscount  = 0
    setmetatable(env.rionormalkills, { __index = function() return 0 end })
    setmetatable(env.rioheroickills, { __index = function() return 0 end })
    setmetatable(env.riomythickills, { __index = function() return 0 end })
    if playerName and RaiderIO and RaiderIO.HasPlayerProfile(playerName) then
        local result = RaiderIO.GetPlayerProfile(RaiderIO.ProfileOutput.DATA, playerName)
        if result and type(result) == "table" then
            for _, data in pairs(result) do
                if data and data.dataType == RaiderIO.DataProvider.MYTHICPLUS and data.profile then
                    env.hasrio       = true
                    env.norio        = false
                    env.rio          = data.profile.mplusCurrent.score
                    env.rioprev      = data.profile.mplusPrevious.score
                    env.riomain      = data.profile.mplusMainCurrent.score
                    env.riomainprev  = data.profile.mplusMainPrevious.score
                    env.riokey5plus  = data.profile.keystoneFivePlus
                    env.riokey10plus = data.profile.keystoneTenPlus
                    env.riokey15plus = data.profile.keystoneFifteenPlus
                    env.riokey20plus = data.profile.keystoneTwentyPlus
                    env.riokeymax    = data.profile.maxDungeonLevel
                end
                if data and data.dataType == RaiderIO.DataProvider.RAIDING and data.profile then
                    if data.profile.currentRaid then
                        env.rioraidbosscount = data.profile.currentRaid.bossCount
                    end
                    if data.profile.mainProgress and type(data.profile.mainProgress) == "table" then
                        for _, mainProgress in pairs(data.profile.mainProgress) do
                            env.riomainprogress = math.max(env.riomainprogress, mainProgress.progressCount)
                        end
                    end
                    if data.profile.progress and type(data.profile.progress) == "table" then
                        for _, progress in pairs(data.profile.progress) do
                            if progress.difficulty == 1 then
                                env.rionormalprogress = progress.progressCount
                                env.rionormalkills = progress.killsPerBoss
                            elseif progress.difficulty == 2 then
                                env.rioheroicprogress = progress.progressCount
                                env.rioheroickills = progress.killsPerBoss
                            elseif progress.difficulty == 3 then
                                env.riomythicprogress = progress.progressCount
                                env.riomythickills = progress.killsPerBoss
                            end
                        end
                    end
                end
            end
        end
    end
end
