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

function PAF.PutPremadeRegionInfo(env, playerName)
    env.region = nil
    env.oce = false
    env.la = false
    env.chi = false
    env.mex = false
    env.bzl = false
    if playerName and PremadeRegions then
        local region = PremadeRegions.GetRegion(playerName)
        if region then
            env.region = region
            env[region] = true
        end
    end
end
