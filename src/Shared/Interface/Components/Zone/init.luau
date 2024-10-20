local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Fusion = require(ReplicatedStorage.Packages.Fusion)

local Children = Fusion.Children

type UsedAs<T> = Fusion.UsedAs<T>

return function(Scope: Fusion.Scope, Props: {
    TextTransparency: UsedAs<number>,
    TitleText: UsedAs<string>,
    TitlePosition: UsedAs<UDim2>,
    DescriptionText: UsedAs<string>,
    LineSize: UsedAs<UDim2>,
}): Frame

    local TitleLabel = require(script.TitleLabel)(Scope, {
        Text = Props.TitleText ,
        Position = Props.TitlePosition,
        TextTransparency = Props.TextTransparency
    })
    local DescriptionLabel = require(script.DescriptionLabel)(Scope, {
        Text = Props.DescriptionText,
        TextTransparency = Props.TextTransparency
    })
    local LineFrame = require(script.LineFrame)(Scope, {Size = Props.LineSize})

    return Scope:New("Frame")({
        Name = "ZoneGui",
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        BackgroundTransparency = 1,
        BorderColor3 = Color3.fromRGB(0, 0, 0),
        BorderSizePixel = 0,
        Size = UDim2.fromScale(1, 1),
        ZIndex = 0,

        [Children] = {
            Scope:New("Frame")({
                Name = "ContainerFrame",
                BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                BackgroundTransparency = 1,
                BorderColor3 = Color3.fromRGB(0, 0, 0),
                BorderSizePixel = 0,
                Interactable = true,
                Active = true,
                AnchorPoint = Vector2.new(0.5, 0),
                Position = UDim2.fromScale(0.5, 0.0721),
                Size = UDim2.fromScale(0.4, 0.2),

                [Children] = {TitleLabel, DescriptionLabel, LineFrame}
            }),
        },
    })
end
