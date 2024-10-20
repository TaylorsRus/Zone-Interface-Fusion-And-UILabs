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

--CONTENT REMOVED FOR PRIVACY
