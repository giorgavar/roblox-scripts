-- Universal Player ESP Script
-- Works with most games, uses Roblox Highlight

local ESP_COLOR = Color3.fromRGB(255, 0, 0) -- Red ESP
local LOCAL_PLAYER = game:GetService("Players").LocalPlayer
local RUN_SERVICE = game:GetService("RunService")

local function createHighlight(player)
    if player == LOCAL_PLAYER then return end
    local character = player.Character
    if not character then return end
    if character:FindFirstChild("Highlight") then return end

    local highlight = Instance.new("Highlight")
    highlight.Name = "Highlight"
    highlight.FillColor = ESP_COLOR
    highlight.OutlineColor = Color3.fromRGB(0, 0, 0)
    highlight.FillTransparency = 0.5
    highlight.OutlineTransparency = 0
    highlight.Adornee = character
    highlight.Parent = character
end

for _, player in pairs(game:GetService("Players"):GetPlayers()) do
    player.CharacterAdded:Connect(function()
        wait(1) 
        createHighlight(player)
    end)
    createHighlight(player)
end

game:GetService("Players").PlayerAdded:Connect(function(player)
    player.CharacterAdded:Connect(function()
        wait(1)
        createHighlight(player)
    end)
end)

RUN_SERVICE.RenderStepped:Connect(function()
    for _, player in pairs(game:GetService("Players"):GetPlayers()) do
        if player ~= LOCAL_PLAYER and player.Character then
            createHighlight(player)
        end
    end
end)
