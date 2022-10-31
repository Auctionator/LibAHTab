local lib = LibStub:NewLibrary("LibAHTab-1-0", 1)

if not lib or lib.internalState then return end

local MIN_TAB_WIDTH = 70
local TAB_PADDING = 20

function lib:DoesIDExist(tabID)
  return not lib.internalState or lib.internalState[usedIDs] ~= nil
end

function lib:CreateTab(tabID, buttonFrameName, attachedFrame, displayText)
  if not AuctionHouseFrame then
    error("Wait for the AH to open before creating your tab")
  end

  if not lib.internalState then
    lib.internalState = {
      Tabs = {},
      usedIDs = {},
      selectedTab = nil,
    }
    lib.rootFrame = CreateFrame("Frame", nil, AuctionHouseFrame)
    lib.rootFrame:SetSize(10, 10)
    lib.rootFrame:SetPoint("TOPLEFT", AuctionHouseFrame.Tabs[#AuctionHouseFrame.Tabs], "TOPRIGHT")
  end

  if lib:DoesIDExist(tabID) then
    error("The tab id already exists")
  end

  local newTab = CreateFrame("Button", buttonFrameName, lib.rootFrame, "AuctionHouseFrameDisplayModeTabTemplate")
  table.insert(lib.internalState.Tabs, newTab)

  newTab:SetText(displayText)

  lib.internalState.usedIDs[tabID] = newTab

  PanelTemplates_TabResize(newTab, TAB_PADDING, nil, MIN_TAB_WIDTH)

  if #lib.internalState.Tabs > 1 then
    newTab:SetPoint("TOPLEFT", lib.internalState.Tabs[#lib.internalState.Tabs - 1], "TOPRIGHT")
  else
    newTab:SetPoint("TOPLEFT", lib.rootFrame, "TOPLEFT")
  end

  PanelTemplates_DeselectTab(newTab)

  newTab.frameRef = attachedFrame

  attachedFrame:Hide()

  newTab:SetScript("OnClick", function()
    print("click \"" ..  displayText .. "\"")
  end)
end
