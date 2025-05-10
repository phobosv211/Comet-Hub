local supportedgames = {
    [16541340872] = true
}
local placeID = game.PlaceId

if supportedgames[placeID] then
    if placeID == "16541340872" then
        loadstring(game:HttpGet("https://api.luarmor.net/files/v3/loaders/e264f71507c2d0fed57d142e3971ed58.lua"))() -- clark county
    else
        return
    end
else
    warn("ERROR: This game is not supported by Comet Hub")
end
