local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Fusion = require(ReplicatedStorage.Packages.Fusion)

local Components = ReplicatedStorage.Interface.Components

local Peek = Fusion.peek

local Controls = {}

local TITLE_LABEL_POSITION_ON = UDim2.fromScale(0, 0.05)
local TITLE_LABEL_POSITION_OFF = UDim2.fromScale(0, 0.15)

local LINE_FRAME_SIZE_ON = UDim2.fromScale(0.7, 0.01)
local LINE_FRAME_SIZE_OFF = UDim2.fromScale(0, 0.01)

local TYPEWRITE_DELAY = .05

local function Story(StoryProps: {
    scope: Fusion.Scope, target: Instance, controls: {
        Enabled: Fusion.UsedAs<boolean>,
        TitleText: Fusion.UsedAs<string>,
        DescriptionText: Fusion.UsedAs<string>,
    }
})
    local Scope = StoryProps.scope
    local Target = StoryProps.target
    local Controls = StoryProps.controls

    local Enabled = Controls.Enabled
    local TitleText = Controls.TitleText
    local DescriptionText = Controls.DescriptionText

    local TextTransparency = Scope:Value(1)
    local TitlePosition = Scope:Value(TITLE_LABEL_POSITION_OFF)
    local LineSize = Scope:Value(LINE_FRAME_SIZE_OFF)

    local TextTransparencyTween = Scope:Tween(TextTransparency, TweenInfo.new(.5))
    local TitlePositionSpring = Scope:Spring(TitlePosition, 40, 1)
    local LineSizeTween = Scope:Tween(LineSize, TweenInfo.new(.4))

    local EnabledObserver = Scope:Observer(Enabled)
    local DescriptionTextObserver = Scope:Observer(DescriptionText)

    local Component = require(Components.Zone)(Scope, {
        TextTransparency = TextTransparencyTween,
        TitleText = TitleText,
        TitlePosition = TitlePositionSpring,
        DescriptionText = DescriptionText,
        LineSize = LineSizeTween,
    })
    Component.Parent = Target

    EnabledObserver:onChange(function()
        local Enabled = Peek(Enabled)
        local TextTransparencyDisabled = nil
        if not Enabled then
            local TextTransparencyTweenObserver = Scope:Observer(TextTransparency)
            TextTransparencyDisabled = TextTransparencyTweenObserver:onChange(function()
                local Value = Peek(TextTransparencyTween)
                if Value ~= 1 then return end
                TitlePosition:set(TITLE_LABEL_POSITION_OFF)
            end)
            TextTransparencyDisabled()
        else
            TitlePosition:set(TITLE_LABEL_POSITION_ON)
        end

        TextTransparency:set(Enabled and 0 or 1)
        LineSize:set(Enabled and LINE_FRAME_SIZE_ON or LINE_FRAME_SIZE_OFF)
    end)

    DescriptionTextObserver:onChange(function()
        local WholeText = Peek(DescriptionText)
        local CurrentText = ""

        for Grapheme = 1, #WholeText do
            task.wait(TYPEWRITE_DELAY)
            CurrentText = CurrentText..WholeText[Grapheme]
        end
    end)
end

return {
	fusion = Fusion,
	controls = Controls,
	story = Story,
}
