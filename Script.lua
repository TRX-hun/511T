-- [[ TRX TIME TRACKER ]] --
local DataStoreService = game:GetService("DataStoreService")
local PointsStore = DataStoreService:GetDataStore("PlayerPointsV1")
local Players = game:GetService("Players")

local loginTimes = {}

-- وظيفة حفظ الوقت
local function saveTime(player)
    if loginTimes[player.UserId] then
        local duration = os.time() - loginTimes[player.UserId]
        local success, currentPoints = pcall(function() return PointsStore:GetAsync(tostring(player.UserId)) or 0 end)
        if success then
            PointsStore:SetAsync(tostring(player.UserId), currentPoints + duration)
        end
    end
end

Players.PlayerAdded:Connect(function(player)
    loginTimes[player.UserId] = os.time()
    
    -- إنشاء واجهة بسيطة لكل لاعب
    local gui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
    local label = Instance.new("TextLabel", gui)
    label.Size = UDim2.new(0, 200, 0, 50)
    label.Position = UDim2.new(0.5, -100, 0, 10)
    label.Text = "TRX SYSTEM: Tracking..."
end)

Players.PlayerRemoving:Connect(function(player)
    saveTime(player)
    loginTimes[player.UserId] = nil
end)
