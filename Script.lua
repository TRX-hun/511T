local Players = game:GetService("Players")

-- جدول لتخزين وقت دخول كل لاعب
local joinTimes = {}

Players.PlayerAdded:Connect(function(player)
	-- تسجيل وقت الدخول عند دخول اللاعب
	joinTimes[player.UserId] = os.time()
	print(player.Name .. " دخل في: " .. os.date("%X", joinTimes[player.UserId]))
end)

Players.PlayerRemoving:Connect(function(player)
	local joinTime = joinTimes[player.UserId]
	if joinTime then
		local duration = os.time() - joinTime -- حساب المدة بالثواني
		
		-- تحويل الثواني إلى ساعات ودقائق وثواني
		local hours = math.floor(duration / 3600)
		local minutes = math.floor((duration % 3600) / 60)
		local seconds = duration % 60
		
		print(player.Name .. " قضى وقت: " .. hours .. " ساعة، " .. minutes .. " دقيقة، " .. seconds .. " ثانية")
		
		-- هنا يمكنك إرسال هذه البيانات إلى واجهة المستخدم (GUI) الخاصة بك
		joinTimes[player.UserId] = nil -- مسح البيانات بعد خروج اللاعب
	end
end)
