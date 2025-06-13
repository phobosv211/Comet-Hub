-- not made by Comet Hub
-- all credits to original owner

return function(message, options)
	options = options or {}
	local textColor = options.textColor or Color3.fromRGB(0, 255, 0)
	local colorText = options.colorText ~= false
	local iconColor = options.iconColor or Color3.fromRGB(0, 0, 0)
	local colorIcon = options.colorIcon or false
	local iconType = options.iconType or "info"
	local showIcon = options.showIcon ~= false

	local uniqueTag = tostring(math.random(1, 1e9))
	print(message .. uniqueTag)

	local iconPaths = {
		info = "rbxasset://textures/DevConsole/Info.png",
		warning = "rbxasset://textures/DevConsole/Warning.png",
		error = "rbxasset://textures/DevConsole/Error.png",
		success = "rbxasset://textures/Tutorials/Tick.png",
	}
	local selectedIcon = iconPaths[iconType:lower()] or iconType
	if not selectedIcon:find("rbxasset://") then selectedIcon = "rbxasset://" .. selectedIcon end
	if not selectedIcon:find("%.png$") and not selectedIcon:find("%.jpg$") and not selectedIcon:find("%.jpeg$") then
		selectedIcon = selectedIcon .. ".png"
	end

	task.spawn(function()
		local found = false
		while not found do
			pcall(function()
				local coreGui = game:GetService("CoreGui")
				local dev = coreGui:FindFirstChild("DevConsoleMaster")
				if not dev then return end
				local ui = dev:FindFirstChild("DevConsoleWindow", true)
				local view = ui and ui:FindFirstChild("MainView", true)
				local log = view and view:FindFirstChild("ClientLog")
				if not log then return end

				local latestMatch, latestIndex = nil, 0
				for _, entry in pairs(log:GetChildren()) do
					local msgLabel = entry:FindFirstChild("msg")
					if msgLabel and msgLabel.Text:find(uniqueTag) then
						local idx = tonumber(entry.Name) or 0
						if idx > latestIndex then
							latestIndex = idx
							latestMatch = entry
						end
					end
				end

				if latestMatch then
					local msgLabel = latestMatch:FindFirstChild("msg")
					if msgLabel then
						if colorText then msgLabel.TextColor3 = textColor end
						msgLabel.Text = msgLabel.Text:gsub(uniqueTag, "")
					end
					local img = latestMatch:FindFirstChild("image")
					if showIcon and img then
						img.Image = selectedIcon
						if colorIcon then img.ImageColor3 = iconColor end
					end
					found = true
				end
			end)
			if not found then task.wait(0.01) end
		end
	end)
end

