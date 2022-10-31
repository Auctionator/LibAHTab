local lib = LibStub:NewLibrary("LibAHTab-1-0", 1)

if not lib or lib.internalState then return end

local MIN_TAB_WIDTH = 70
local TAB_PADDING = 20

function lib:DoesIDExist(tabID)
  return lib.internalState and lib.internalState.usedIDs[tabID] ~= nil
end

function lib:CreateTab(tabID, attachedFrame, displayText)
  if not AuctionHouseFrame then
    error("Wait for the AH to open before creating your tab")
  end
  if type(tabID) ~= "string" then
    error("tabID should be a string")
  end

  if not lib.internalState then
    lib.internalState = {
      Tabs = {},
      usedIDs = {},
      selectedTab = nil,
    }
    lib.internalState.rootFrame = CreateFrame("Frame", nil, AuctionHouseFrame)
    lib.internalState.rootFrame:SetSize(10, 10)
    lib.internalState.rootFrame:SetPoint("TOPLEFT", AuctionHouseFrame.Tabs[#AuctionHouseFrame.Tabs], "TOPRIGHT")

    hooksecurefunc(AuctionHouseFrame, "SetDisplayMode", function(self, mode)
      if mode ~= nil and #mode > 0 then
        for _, tab in ipairs(lib.internalState.Tabs) do
          tab.frameRef:Hide()
          PanelTemplates_DeselectTab(tab)
        end
      end
    end)
  end

  if lib:DoesIDExist(tabID) then
    error("The tab id already exists")
  end

  local newTab = CreateFrame("Button", buttonFrameName, lib.internalState.rootFrame, "AuctionHouseFrameDisplayModeTabTemplate")
  table.insert(lib.internalState.Tabs, newTab)

  newTab:SetText(displayText)

  lib.internalState.usedIDs[tabID] = newTab

  PanelTemplates_TabResize(newTab, TAB_PADDING, nil, MIN_TAB_WIDTH)

  if #lib.internalState.Tabs > 1 then
    newTab:SetPoint("TOPLEFT", lib.internalState.Tabs[#lib.internalState.Tabs - 1], "TOPRIGHT")
  else
    newTab:SetPoint("TOPLEFT", lib.internalState.rootFrame, "TOPLEFT")
  end

  PanelTemplates_DeselectTab(newTab)

  newTab.frameRef = attachedFrame

  attachedFrame:Hide()

  newTab:SetScript("OnClick", function()
    lib:SetSelected(tabID)
  end)
end

function lib:GetTabButton(tabID)
  return lib.internalState.usedIDs[tabID]
end

function lib:SetSelected(tabID)
  if lib.internalState == nil or not lib:DoesIDExist(tabID) then
    error("Tab doesn't exist")
  end

  AuctionHouseFrame:SetDisplayMode({})
  AuctionHouseFrame.displayMode = nil

  for _, tab in ipairs(lib.internalState.Tabs) do
    tab.frameRef:Hide()
    PanelTemplates_DeselectTab(tab)
  end

  for _, tab in ipairs(AuctionHouseFrame.Tabs) do
    PanelTemplates_DeselectTab(tab)
  end

  local selectedTab = lib:GetTabButton(tabID)
  PanelTemplates_SelectTab(selectedTab)

  selectedTab.frameRef:Show()
end
