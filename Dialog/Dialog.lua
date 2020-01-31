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

-------------------------------------------------------------------------------
-- OnShow functions
-------------------------------------------------------------------------------

function PAF.Dialog_LoadFromModel(dialog)
    local model = PAF.GetModel()
    PAF.UsePAFButton:SetChecked(model.enabled)
    PAF.previousSearchExpression = model.expression
    dialog.Expression.EditBox:SetText(model.expression)
end

function PAF.Dialog_UpdatePosition()
    local dialog = PremadeApplicantsFilterDialog
    dialog:SetPoint("TOPLEFT", GroupFinderFrame, "TOPRIGHT")
    dialog:SetPoint("BOTTOMLEFT", GroupFinderFrame, "BOTTOMRIGHT")
    dialog:SetWidth(300)
end

function PAF.Dialog_OnShow(dialog)
    PAF.Dialog_LoadFromModel(dialog)
    PAF.Dialog_UpdatePosition(dialog)
end

-------------------------------------------------------------------------------
-- OnLoad functions
-------------------------------------------------------------------------------

function PAF.Dialog_SetUpUsePAFCheckbox()
    local button = CreateFrame("CheckButton", "UsePAFButton", LFGListFrame.SearchPanel, "UICheckButtonTemplate")
    button:SetSize(26, 26)
    button:SetHitRectInsets(-2, -30, -2, -2)
    button.text:SetText("PAF")
    button.text:SetFontObject("GameFontHighlight")
    button.text:SetWidth(30)
    button:SetPoint("LEFT", LFGListFrame.SearchPanel.RefreshButton, "LEFT", -62, 0)
    button:SetPoint("TOP", LFGListFrame.SearchPanel.RefreshButton, "TOP", 0, -3)
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
    dialog:SetScript("OnShow", PAF.Dialog_OnShow)

    dialog.InsetBg:SetPoint("TOPLEFT", 4, -62)
    dialog.InsetBg:SetPoint("BOTTOMRIGHT", -6, 26)
    dialog.Title:SetText("Premade Applicants Filter")
    dialog.RefreshButton:SetScript("OnClick", PAF.Dialog_RefreshButton_OnClick)
    dialog.Advanced.Explanation:SetText(L["dialog.explanation"])
    dialog.Advanced.InfoButton:EnableMouse(true)
    dialog.Advanced.InfoButton:SetScript("OnEnter", PAF.Dialog_InfoButton_OnEnter)
    dialog.Advanced.InfoButton:SetScript("OnLeave", PAF.Dialog_InfoButton_OnLeave)

    PAF.Dialog_SetUpUsePAFCheckbox()

    local font = dialog.SimpleExplanation:GetFont()
    dialog.Expression.EditBox:SetFont(font, C.FONTSIZE_TEXTBOX)
    dialog.Expression.EditBox.Instructions:SetFont(font, C.FONTSIZE_TEXTBOX)
    --dialog.Expression.EditBox:SetScript("OnTextChanged", PAF.Dialog_Expression_OnTextChanged) -- overrides Blizz
end

PremadeApplicantsFilter.Dialog_OnLoad = PAF.Dialog_OnLoad

-------------------------------------------------------------------------------
-- Interaction functions
-------------------------------------------------------------------------------

function PAF.Dialog_ClearFocus()
    local dialog = PremadeApplicantsFilterDialog
    dialog.Expression.EditBox:ClearFocus()
end

function PAF.Dialog_OnModelUpdate()
    local exp = PAF.GetExpressionFromModel()
    if PAF.Empty(exp) or exp == "true" then exp = "" end
    exp = exp:gsub("^true and ", "")
    PremadeApplicantsFilterDialog.Expression.EditBox.Instructions:SetText(exp)
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
    LFGListApplicationViewer_UpdateResultList(LFGListFrame.ApplicationViewer)
end

function PAF.Dialog_Expression_OnTextChanged(self, userInput)
    -- we cannot set the OnTextChange directly, since the InputScrollFrameTemplate
    -- needs that for hiding/showing the gray instructions text
    if self == PremadeApplicantsFilterDialog.Expression.EditBox then
        local model = PAF.GetModel()
        model.expression = self:GetText() or ""
        PAF.Dialog_OnModelUpdate()
    end
end

function PAF.Dialog_RefreshButton_OnClick(self, button, down)
    PAF.Dialog_ClearFocus()
    PAF.Dialog_Expression_OnTextChanged(PremadeApplicantsFilterDialog.Expression.EditBox)
    LFGListApplicationViewer_UpdateResultList(LFGListFrame.ApplicationViewer)
end

function PAF.Dialog_Toggle()
    local dialog = PremadeApplicantsFilterDialog
    local model = PAF.GetModel()
    if PVEFrame:IsVisible() and LFGListFrame.activePanel == LFGListFrame.SearchPanel
            and LFGListFrame.SearchPanel:IsVisible() and model then
        PAF.UsePAFButton:SetChecked(model.enabled)
        if model.enabled then
            dialog:Show()
        end
    else
        dialog:Hide()
    end
end

local buttonHooksInitialized = false
function PAF.OnLFGListFrameSetActivePanel(self, panel)
    PAF.Dialog_Toggle()
    if not buttonHooksInitialized and panel == self.SearchPanel then
        buttonHooksInitialized = true
        local buttons = self.SearchPanel.ScrollFrame.buttons
        for i = 1, #buttons do
            buttons[i]:HookScript("OnEnter", PAF.OnLFGListSearchEntryOnEnter)
        end
    end
end

hooksecurefunc("LFGListFrame_SetActivePanel", PAF.OnLFGListFrameSetActivePanel)
hooksecurefunc("GroupFinderFrame_ShowGroupFrame", PAF.Dialog_Toggle)
hooksecurefunc("PVEFrame_ShowFrame", PAF.Dialog_Toggle)
hooksecurefunc("InputScrollFrame_OnTextChanged", PAF.Dialog_Expression_OnTextChanged)
PVEFrame:SetScript("OnShow", PAF.Dialog_Toggle)
PVEFrame:SetScript("OnHide", PAF.Dialog_Toggle)
