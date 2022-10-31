# LibAHTab

Workaround for Auction House Tabs causing taint. This applies to WoW retail, after version 10.0.0.

```lua
local LibAHTab = LibStub("LibAHTab-1-0")
local frame = CreateFrame("Frame")
local UNIQUE_TAB_ID = "My id"

frame:RegisterEvent("PLAYER_INTERACTION_MANAGER_FRAME_SHOW")

frame:SetScript("OnEvent", function(_, eventName, panelType)
  if eventName == "PLAYER_INTERACTION_MANAGER_FRAME_SHOW" and panelType == Enum.PlayerInteractionType.Auctioneer then
    local attachedFrame = CreateFrame("Frame")
    attachedFrame:SetScript("OnShow", function()
      -- do something when the tab is selected
    end)
    LibAHTab:CreateTab(UNIQUE_TAB_ID, "LibAHTabButton_Mine", attachedFrame, "Tab text")
  end
end)

-- API
LibAHTab:CreateTab(UNIQUE_TAB_ID, tabButtonFrameName, attachedFrame, "Tab Button Text")
LibAHTab:DoesIDExist(UNIQUE_TAB_ID)
LibAHTab:SetSelected(UNIQUE_TAB_ID)
```
