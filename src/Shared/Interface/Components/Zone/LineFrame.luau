local Fusion = require(game:GetService("ReplicatedStorage").Packages.Fusion)

type UsedAs<T> = Fusion.UsedAs<T>

return function(Scope: Fusion.Scope, Props: {
    Size: UsedAs<UDim2>
}): TextLabel

    return Scope:New("Frame")({
        Name = "LineFrame",
        AnchorPoint = Vector2.new(0.5, 0.5),
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        BorderColor3 = Color3.fromRGB(0, 0, 0),
        BorderSizePixel = 0,
        Position = UDim2.fromScale(0.5, 0.35),
        Size = Props.Size,
    })
end
