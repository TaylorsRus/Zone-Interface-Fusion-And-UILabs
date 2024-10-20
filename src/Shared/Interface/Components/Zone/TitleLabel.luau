local Fusion = require(game:GetService("ReplicatedStorage").Packages.Fusion)

type UsedAs<T> = Fusion.UsedAs<T>

return function(Scope: Fusion.Scope, Props: {
    Text: UsedAs<string>,
    Position: UsedAs<UDim2>,
    TextTransparency: UsedAs<number>,
}): TextLabel

    return Scope:New("TextLabel")({
        Name = "TitleLabel",
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        BackgroundTransparency = 1,
        BorderColor3 = Color3.fromRGB(0, 0, 0),
        BorderSizePixel = 0,
        FontFace = Font.new(
            "rbxassetid://11322590111",
            Enum.FontWeight.SemiBold,
            Enum.FontStyle.Normal
        ),
        Position = Props.Position,
        Size = UDim2.fromScale(1, 0.25),
        Text = Props.Text,
        TextColor3 = Color3.fromRGB(255, 255, 255),
        TextScaled = true,
        TextTransparency = Props.TextTransparency,
        TextSize = 14,
        TextWrapped = true,
    })
end
