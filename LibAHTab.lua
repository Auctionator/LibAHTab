local lib = LibStub:NewLibrary("LibAHTab-1-0", 1)

if not lib or lib.internalState then return end

function lib:DoesIDExist(tabID)
end

function lib:AddTab(tabID, buttonFrameName, attachedFrame, displayText)
  if not AuctionHouseFrame then
    error("Wait for the AH to open before creating your tab")
  end

  if not lib.internalState then
    lib.internalState = {
      Tabs = {},
      selectedTab = nil,
    }
  end

  if lib.internalState.usedKeys[tabID] then
    error("The tab id already exists")
  end

  local newTab = CreateFrame("Frame", frameName, 
  table.insert(lib.internalState.Tabs, CreateFrame("Button", buttonFrameName, attachedFrame, displayText))
end
