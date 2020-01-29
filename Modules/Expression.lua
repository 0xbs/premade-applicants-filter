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

StaticPopupDialogs["PAF_ERRORPOPUP"] = {
    text = "%s",
    button1 = L["button.ok"],
    timeout = 0,
    whileDead = true,
    hideOnEscape = true,
    preferredIndex = 3,
}

function PAF.HandleSyntaxError(error)
    StaticPopup_Show("PAF_ERRORPOPUP", string.format(L["error.syntax"], error))
end

function PAF.HandleSemanticError(error)
    StaticPopup_Show("PAF_ERRORPOPUP", string.format(L["error.semantic"], error))
end

PAF.filterMetaTable = {
    __mode = "k",
    __index = function(table, key)
        local func, error = loadstring("return " .. key)
        if error then
            PAF.HandleSyntaxError(error)
            return nil
        end
        table[key] = func
        return func
    end,
    tonumber = tonumber
}

PAF.filter = setmetatable({}, PAF.filterMetaTable)

function PAF.DoesPassThroughFilter(env, exp)
    --local exp = "mythic and tansk < 0 and members==4"  -- raises semantic error
    --local exp = "and and tanks==0 and members==4"      -- raises syntax error
    --local exp = "mythic and tanks==0 and members==4"   -- correct statement
    local filter = PAF.filter[exp]
    if filter then
        setfenv(filter, env)
        local hasFilterError, filterResult = pcall(filter)
        if hasFilterError then
            return filterResult
        else
            PAF.HandleSemanticError(filterResult)
            return true
        end
    end
    return true
end
