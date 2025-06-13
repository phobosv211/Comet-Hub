-- not made by Comet Hub
-- all credits to original owner

getgenv().cprint=function()
    local message="the script is working!" -- text to print
    local textColor,colorText=Color3.fromRGB(0,255,0),true -- text color and if enabled
    local iconColor,colorIcon=Color3.fromRGB(0,0,0),false -- icon color and if enabled
    local iconType,showIcon="info",true -- icon type and if shown
    
    local uniqueTag=""..tostring(math.random(1,1e9))
    print(message..""..uniqueTag)
    
    local iconPaths={
        ["info"]="rbxasset://textures/DevConsole/Info.png",
        ["warning"]="rbxasset://textures/DevConsole/Warning.png",
        ["error"]="rbxasset://textures/DevConsole/Error.png",
        ["success"]="rbxasset://textures/Tutorials/Tick.png",
    } -- you can add more icon paths here
    
    
    local selectedIcon=iconPaths[iconType:lower()] or iconType
    
    if not selectedIcon:find("rbxasset://") then
        selectedIcon="rbxasset://"..selectedIcon
    end
    
    
    if not selectedIcon:find("%.png$") and not selectedIcon:find("%.jpg$") and not selectedIcon:find("%.jpeg$") then
        selectedIcon=selectedIcon..".png" -- adds .png extension if missing
    end
    -- do not change anything below this line
    
    task.spawn(function()
        local found = false
        
        while not found do
            pcall(function()
                local coreGui=game:GetService("CoreGui")
                if not coreGui:FindFirstChild("DevConsoleMaster") then return end
                
                local devConsole=coreGui.DevConsoleMaster.DevConsoleWindow.DevConsoleUI
                if not devConsole:FindFirstChild("MainView") then return end
                
                local clientLog=devConsole.MainView.ClientLog
                local latestMatch=nil
                local latestIndex=0
                
                
                for _,entry in pairs(clientLog:GetChildren()) do
                    local msgLabel=entry:FindFirstChild("msg")
                    if msgLabel and msgLabel.Text:find(uniqueTag) then
                        local index=tonumber(entry.Name) or 0
                        if index>latestIndex then
                            latestIndex=index
                            latestMatch=entry
                        end
                    end
                end
                
                
                if latestMatch then
                    local msgLabel=latestMatch:FindFirstChild("msg")
                    if msgLabel then
                        if colorText then
                            msgLabel.TextColor3=textColor
                        end
                        msgLabel.Text=msgLabel.Text:gsub(uniqueTag,"")
                    end
                    
                    if showIcon and latestMatch:FindFirstChild("image") then
                        latestMatch.image.Image=selectedIcon
                        if colorIcon then
                            latestMatch.image.ImageColor3=iconColor
                        end
                    end
                    found = true
                end
            end)
            
            if not found then
                task.wait(0.01)
            end
        end
    end)
end
