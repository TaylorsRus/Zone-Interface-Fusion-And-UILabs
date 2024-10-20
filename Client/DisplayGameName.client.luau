local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")
local Lighting = game:GetService("Lighting")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Packages = ReplicatedStorage.Packages
local Stories = ReplicatedStorage.Interface.Stories
local Sounds = ReplicatedStorage.Sounds.Zone

local ZoneStorage = ReplicatedStorage.ZoneStorage

local Fusion = require(Packages.Fusion)
local ZoneStory = require(Stories["Zone.story"])

local Player = Players.LocalPlayer
local Scope = Fusion:scoped()

local Enabled = Scope:Value(false)
local TitleText = Scope:Value("")
local DescriptionText = Scope:Value("")
local Cooldown = false

local POPUP_DURATION = 5
local COOLDOWN_DURATION = 3

local ScreenGui = Instance.new("ScreenGui") -- To do, global UI handler?
ScreenGui.IgnoreGuiInset = true
ScreenGui.Parent = Player.PlayerGui

ZoneStory.story({
    scope = Scope,
    target = ScreenGui,
    controls = {
        Enabled = Enabled,
        TitleText = TitleText,
        DescriptionText = DescriptionText
    }
})

for _,Zone: BasePart in ZoneStorage:GetChildren() do
    if not Zone:IsA("BasePart") then continue end
    local Name = Zone.Name
    local Description = Zone:GetAttribute("Description") or "N/A"

    Zone.Touched:Connect(function()
        if Cooldown then return end; Cooldown = true

        local Sound: Sound = Sounds:FindFirstChild(Name)
        if Sound then
            Sound:Play()
        end

        TitleText:set(Name)
        DescriptionText:set(Description)
        Enabled:set(true)

        task.delay(POPUP_DURATION, function()
            Enabled:set(false)

            task.wait(COOLDOWN_DURATION)
            Cooldown = false
        end)
    end)
    Zone.Parent = Workspace.Zones
end
