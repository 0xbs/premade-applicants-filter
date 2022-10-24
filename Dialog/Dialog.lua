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

C.FONTSIZE_TEXTBOX = 12

function PAF.Dialog_SetUpUsePAFCheckbox()
    local button = CreateFrame("CheckButton", "UsePAFButton", LFGListFrame.ApplicationViewer, "UICheckButtonTemplate")
    button:SetSize(26, 26)
    button:SetHitRectInsets(-2, -30, -2, -2)
    button.text:SetText("PAF")
    button.text:SetFontObject("GameFontHighlight")
    button.text:SetWidth(30)
    button:SetPoint("LEFT", LFGListFrame.ApplicationViewer.RefreshButton, "LEFT", -62, 0)
    button:SetPoint("TOP", LFGListFrame.ApplicationViewer.RefreshButton, "TOP", 0, -3)
    button:SetScript("OnClick", PAF.Dialog_UsePAF_OnClick)
    button:SetScript("OnEnter", function (self)
        GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
        GameTooltip:SetText(L["dialog.usepaf.tooltip"])
    end)
    button:SetScript("OnLeave", function () GameTooltip:Hide() end)
    PAF.UsePAFButton = button
end

function PAF.Dialog_OnLoad()
    local dialog = PremadeApplicantsFilterDialog -- keep that

    dialog:SetBorder("ButtonFrameTemplateNoPortraitMinimizable") -- ButtonFrameTemplateNoPortrait exists, but is broken at the moment
    dialog:SetPortraitShown(false);
    dialog:SetTitle("Premade Applicants Filter")
    dialog.TitleContainer:SetScript("OnMouseDown", PAF.Dialog_OnMouseDown)
    dialog.TitleContainer:SetScript("OnMouseUp", PAF.Dialog_OnMouseUp)
    dialog.Explanation:SetText(L["dialog.explanation"])
    dialog.InfoButton:EnableMouse(true)
    dialog.InfoButton:SetScript("OnEnter", PAF.Dialog_InfoButton_OnEnter)
    dialog.InfoButton:SetScript("OnLeave", PAF.Dialog_InfoButton_OnLeave)

    PAF.Dialog_SetUpUsePAFCheckbox()

    local fontFile, _, fontFlags = dialog.Expression.EditBox:GetFont()
    dialog.Expression.EditBox:SetFont(fontFile, C.FONTSIZE_TEXTBOX, fontFlags)
    dialog.Expression.EditBox.Instructions:SetFont(fontFile, C.FONTSIZE_TEXTBOX, fontFlags)
    --dialog.Expression.EditBox:SetScript("OnTextChanged", PAF.Dialog_Expression_OnTextChanged) -- overrides Blizz
end

function PAF.Dialog_OnShow()
    local model = PAF.GetModel()
    PAF.UsePAFButton:SetChecked(model.enabled)
    PremadeApplicantsFilterDialog.Expression.EditBox:SetText(model.expression)
end

function PAF.Dialog_ResetPosition()
    local dialog = PremadeApplicantsFilterDialog
    dialog:ClearAllPoints()
    dialog:SetPoint("TOPLEFT", GroupFinderFrame, "TOPRIGHT")
    dialog:SetWidth(300)
end

function PAF.Dialog_OnMouseDown(self, button)
    PremadeApplicantsFilterDialog:StartMoving()
end

function PAF.Dialog_OnMouseUp(self, button)
    PremadeApplicantsFilterDialog:StopMovingOrSizing()
    if button == "RightButton" then
        PAF.Dialog_ResetPosition()
    end
end

PremadeApplicantsFilter.Dialog_OnLoad = PAF.Dialog_OnLoad
PremadeApplicantsFilter.Dialog_OnShow = PAF.Dialog_OnShow

function PAF.Dialog_ClearFocus()
    local dialog = PremadeApplicantsFilterDialog
    dialog.Expression.EditBox:ClearFocus()
end

function PAF.Dialog_UsePAF_OnClick(self, button, down)
    local checked = self:GetChecked()
    local model = PAF.GetModel()
    model.enabled = checked
    if checked then
        PremadeApplicantsFilterDialog:Show()
    else
        PAF.Dialog_ClearFocus()
        PremadeApplicantsFilterDialog:Hide()
    end
    C_LFGList.RefreshApplicants();
end

function PAF.Dialog_Expression_OnTextChanged(self, userInput)
    -- we cannot set the OnTextChange directly, since the InputScrollFrameTemplate
    -- needs that for hiding/showing the gray instructions text
    if self == PremadeApplicantsFilterDialog.Expression.EditBox then
        local model = PAF.GetModel()
        model.expression = self:GetText() or ""
    end
end

function PAF.Dialog_Toggle()
    local dialog = PremadeApplicantsFilterDialog
    local model = PAF.GetModel()
    if PVEFrame:IsVisible() and LFGListFrame.activePanel == LFGListFrame.ApplicationViewer
            and LFGListFrame.ApplicationViewer:IsVisible() and model then
        PAF.UsePAFButton:SetChecked(model.enabled)
        if model.enabled then
            dialog:Show()
        end
    else
        dialog:Hide()
    end
end

hooksecurefunc("InputScrollFrame_OnTextChanged", PAF.Dialog_Expression_OnTextChanged)
hooksecurefunc("LFGListFrame_SetActivePanel", PAF.Dialog_Toggle)
hooksecurefunc("LFGListApplicationViewer_OnShow", PAF.Dialog_Toggle)
hooksecurefunc("GroupFinderFrame_ShowGroupFrame", PAF.Dialog_Toggle)
hooksecurefunc("PVEFrame_ShowFrame", PAF.Dialog_Toggle)
PVEFrame:SetScript("OnShow", PAF.Dialog_Toggle)
PVEFrame:SetScript("OnHide", PAF.Dialog_Toggle)
