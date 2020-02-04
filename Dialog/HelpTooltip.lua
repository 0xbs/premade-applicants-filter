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

function PAF.GameTooltip_AddWhite(left)
    GameTooltip:AddLine(left, 255, 255, 255)
end

function PAF.GameTooltip_AddDoubleWhite(left, right)
    GameTooltip:AddDoubleLine(left, right, 255, 255, 255, 255, 255, 255)
end

function PAF.Dialog_InfoButton_OnEnter(self, motion)
    local AddDoubleWhiteUsingKey = function (key) PAF.GameTooltip_AddDoubleWhite(key, L["dialog.tooltip." .. key]) end

    GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
    GameTooltip:SetText(L["dialog.tooltip.title"])
    GameTooltip:AddLine(" ")
    GameTooltip:AddLine(L["dialog.tooltip.examples"])
    PAF.GameTooltip_AddWhite("friend or (ilvl > 400 and heal)")
    PAF.GameTooltip_AddWhite("not dps and rio > 1000")
    GameTooltip:AddLine(" ")
    GameTooltip:AddDoubleLine(L["dialog.tooltip.variable"], L["dialog.tooltip.description"])
    AddDoubleWhiteUsingKey("level")
    AddDoubleWhiteUsingKey("ilvl")
    AddDoubleWhiteUsingKey("hlvl")
    AddDoubleWhiteUsingKey("friend")
    AddDoubleWhiteUsingKey("guild")
    AddDoubleWhiteUsingKey("tank")
    AddDoubleWhiteUsingKey("heal")
    AddDoubleWhiteUsingKey("dps")
    AddDoubleWhiteUsingKey("range")
    AddDoubleWhiteUsingKey("melee")
    GameTooltip:AddLine(" ")
    GameTooltip:AddDoubleLine(L["dialog.tooltip.variable.rio"], L["dialog.tooltip.description"])
    PAF.GameTooltip_AddDoubleWhite("hasrio/norio", L["dialog.tooltip.hasrio"])
    AddDoubleWhiteUsingKey("rio")
    AddDoubleWhiteUsingKey("riomain")
    AddDoubleWhiteUsingKey("rioprev")
    AddDoubleWhiteUsingKey("riokey10plus")
    AddDoubleWhiteUsingKey("rioheroicprogress")
    GameTooltip:AddLine(" ")
    PAF.GameTooltip_AddWhite(L["dialog.tooltip.more"])
    GameTooltip:Show()
end

function PAF.Dialog_InfoButton_OnLeave(self, motion)
    GameTooltip:Hide()
end
