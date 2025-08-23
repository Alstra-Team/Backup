local Library = {}

local TweenService: TweenService = game:GetService("TweenService")
local UserInputService: UserInputService = game:GetService("UserInputService")

GetIcon = function(i)
	if type(i) == 'string' and not i:find('rbxassetid://') then
		return "rbxassetid://".. i
	elseif type(i) == 'number' then
		return "rbxassetid://".. i
	else
		return i
	end
end

tw = function(info)
	return TweenService:Create(info.v, TweenInfo.new(info.t, Enum.EasingStyle[info.s], Enum.EasingDirection[info.d]), info.g)
end

lak = function(a)
	local Dragging = nil
	local DragInput = nil
	local DragStart = nil
	local StartPosition = nil

	local function Update(input)
		local Delta = input.Position - DragStart
		local pos = UDim2.new(StartPosition.X.Scale, StartPosition.X.Offset + Delta.X, StartPosition.Y.Scale, StartPosition.Y.Offset + Delta.Y)
		local Tween = game:GetService("TweenService"):Create(a, TweenInfo.new(0.3), {Position = pos})
		Tween:Play()
	end

	a.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			Dragging = true
			DragStart = input.Position
			StartPosition = a.Position

			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					Dragging = false
				end
			end)
		end
	end)

	a.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
			DragInput = input
		end
	end)

	game:GetService("UserInputService").InputChanged:Connect(function(input)
		if input == DragInput and Dragging then
			Update(input)
		end
	end)
end

click = function(p)
	local Click = Instance.new("TextButton")

	Click.Name = "Click"
	Click.Parent = p
	Click.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Click.BackgroundTransparency = 1.000
	Click.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Click.BorderSizePixel = 0
	Click.Size = UDim2.new(1, 0, 1, 0)
	Click.Font = Enum.Font.SourceSans
	Click.Text = ""
	Click.TextColor3 = Color3.fromRGB(0, 0, 0)
	Click.TextSize = 14.000
	Click.ZIndex = p.ZIndex + 2

	return Click
end

EffectClick = function(c, p)
	local Mouse = game.Players.LocalPlayer:GetMouse()

	local relativeX = Mouse.X - c.AbsolutePosition.X
	local relativeY = Mouse.Y - c.AbsolutePosition.Y

	if relativeX < 0 or relativeY < 0 or relativeX > c.AbsoluteSize.X or relativeY > c.AbsoluteSize.Y then
		return
	end

	local ClickButtonCircle = Instance.new("Frame")
	ClickButtonCircle.Parent = p
	ClickButtonCircle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	ClickButtonCircle.BackgroundTransparency = 0.5
	ClickButtonCircle.BorderSizePixel = 0
	ClickButtonCircle.AnchorPoint = Vector2.new(0.5, 0.5)
	ClickButtonCircle.Position = UDim2.new(0, relativeX, 0, relativeY)
	ClickButtonCircle.Size = UDim2.new(0, 0, 0, 0)
	ClickButtonCircle.ZIndex = p.ZIndex

	local UICorner = Instance.new("UICorner")
	UICorner.CornerRadius = UDim.new(1, 0)
	UICorner.Parent = ClickButtonCircle

	local tweenInfo = TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

	local goal = {
		Size = UDim2.new(0, c.AbsoluteSize.X * 1.5, 0, c.AbsoluteSize.X * 1.5),
		BackgroundTransparency = 1
	}

	local expandTween = TweenService:Create(ClickButtonCircle, tweenInfo, goal)

	expandTween.Completed:Connect(function()
		ClickButtonCircle:Destroy()
	end)

	expandTween:Play()
end

Canvas_Y = function(uilist, sc, n)
	uilist:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
		sc.CanvasSize = UDim2.new(0, 0, 0, uilist.AbsoluteContentSize.Y + n)
	end)
end

Canvas_X = function(uilist, sc, n)
	uilist:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
		sc.CanvasSize = UDim2.new(0, uilist.AbsoluteContentSize.X + n, 0, 0)
	end)
end

Tog = function(p, frame, bn, i)
	local CloseUI = Instance.new("TextButton")
	local UICorner_1z = Instance.new("UICorner")
	local Icon_1 = Instance.new("Frame")
	local ImageLabel = Instance.new("ImageLabel")


	CloseUI.Name = "CloseUI"
	CloseUI.Parent = p
	CloseUI.AnchorPoint = Vector2.new(0.5, 0)
	CloseUI.BackgroundColor3 = Color3.fromRGB(15,16,17)
	CloseUI.BorderColor3 = Color3.fromRGB(0,0,0)
	CloseUI.BorderSizePixel = 0
	CloseUI.Position = UDim2.new(0.5, 0, 0, 8)
	CloseUI.Size = UDim2.new(0, 50,0, 50)
	CloseUI.Text = ""

	lak(CloseUI)

	UICorner_1z.Parent = CloseUI
	UICorner_1z.CornerRadius = UDim.new(0,6)

	Icon_1.Name = "Icon"
	Icon_1.Parent = CloseUI
	Icon_1.BackgroundColor3 = Color3.fromRGB(22,22,22)
	Icon_1.BorderColor3 = Color3.fromRGB(0,0,0)
	Icon_1.BorderSizePixel = 0
	Icon_1.Size = UDim2.new(1,0,1, 0)
	Icon_1.BackgroundTransparency = 1

	ImageLabel.Parent = Icon_1
	ImageLabel.AnchorPoint = Vector2.new(0.5, 0.5)
	ImageLabel.BackgroundColor3 = Color3.fromRGB(255,255,255)
	ImageLabel.BackgroundTransparency = 1
	ImageLabel.BorderColor3 = Color3.fromRGB(0,0,0)
	ImageLabel.BorderSizePixel = 0
	ImageLabel.Position = UDim2.new(0.5, 0,0.5, 0)
	ImageLabel.Size = UDim2.new(0, 35,0, 35)
	ImageLabel.Image = i
	ImageLabel.ImageTransparency = 0

	local function closeopenui()
		frame.Visible = not frame.Visible
	end

	local On = true

	CloseUI.MouseButton1Click:Connect(function()
		closeopenui()
		On = not On
	end)

	UserInputService.InputBegan:Connect(function(input, gameProcessed)
		if not gameProcessed and input.KeyCode == bn then
			closeopenui()
			On = not On
		end
	end)
end

Parent = function()
	return not game:GetService("RunService"):IsStudio() and game:GetService("CoreGui") or game:GetService("Players").LocalPlayer.PlayerGui
end

local Quertzy = Instance.new("ScreenGui")
Quertzy.Name = "Quertzy"
Quertzy.Parent = Parent()
Quertzy.ZIndexBehavior = Enum.ZIndexBehavior.Global

local Quertzy2 = Instance.new("ScreenGui")
Quertzy2.Name = "Quertzy"
Quertzy2.ZIndexBehavior = Enum.ZIndexBehavior.Global
Quertzy2.ResetOnSpawn = false
Quertzy2.IgnoreGuiInset = true
Quertzy2.Parent = Parent()

function Library.Window(meta)
	local Title = meta.Title
	local Desc = meta.Desc
	local Logo = GetIcon(meta.Logo)
	local Size = meta.Size or UDim2.new(0, 525,0, 400)

	local Background = Instance.new("Frame")
	local UICorner = Instance.new("UICorner")
	local DropShadow = Instance.new("ImageLabel")
	local Main = Instance.new("Frame")
	local Header = Instance.new("Frame")
	local UIPadding = Instance.new("UIPadding")
	local Back = Instance.new("Frame")
	local ReturnIcon = Instance.new("ImageLabel")
	local InsideHeader = Instance.new("Frame")
	local UIListLayout = Instance.new("UIListLayout")
	local TextHeader = Instance.new("Frame")
	local TitleHeader = Instance.new("TextLabel")
	local UIListLayout_2 = Instance.new("UIListLayout")
	local DescHeader = Instance.new("TextLabel")
	local LogoHeader = Instance.new("ImageLabel")
	local Main_Pages = Instance.new("Frame")
	local Tabs = Instance.new("Frame")
	local UICorner_2 = Instance.new("UICorner")
	local UIPadding_2 = Instance.new("UIPadding")
	local Tabs_Inside = Instance.new("Frame")
	local UIPadding_3 = Instance.new("UIPadding")
	local ScrollongTabs = Instance.new("Frame")
	local UIPadding_4 = Instance.new("UIPadding")
	local InsideScrollongTabs = Instance.new("Frame")
	local MainTextInScroll = Instance.new("TextLabel")
	local RealScrollongTabs = Instance.new("Frame")
	local UIPadding_5 = Instance.new("UIPadding")
	local Realscrolling = Instance.new("ScrollingFrame")
	local UIGridLayout = Instance.new("UIGridLayout")
	local UIPadding_6 = Instance.new("UIPadding")
	local Realscrolling2 = Instance.new("ScrollingFrame")
	local UIGridLayout2 = Instance.new("UIGridLayout")
	local UIPadding_7 = Instance.new("UIPadding")
	local RealInside = Instance.new("Frame")
	local Profile = Instance.new("Frame")
	local UICorner_3 = Instance.new("UICorner")
	local UIListLayout_3 = Instance.new("UIListLayout")
	local ThumnailPf = Instance.new("ImageLabel")
	local UICorner_4 = Instance.new("UICorner")
	local UIPadding_7 = Instance.new("UIPadding")
	local TextPf = Instance.new("Frame")
	local TitlePf = Instance.new("TextLabel")
	local UIListLayout_4 = Instance.new("UIListLayout")
	local DescPf = Instance.new("TextLabel")
	local UIListLayout_5 = Instance.new("UIListLayout")
	local DS = Instance.new("Frame")
	local UICorner_5 = Instance.new("UICorner")
	local UIListLayout_6 = Instance.new("UIListLayout")
	local ThumnailDS = Instance.new("ImageLabel")
	local UICorner_6 = Instance.new("UICorner")
	local UIPadding_8 = Instance.new("UIPadding")
	local TextDS = Instance.new("Frame")
	local TitleDS = Instance.new("TextLabel")
	local UIListLayout_7 = Instance.new("UIListLayout")
	local DescDS = Instance.new("TextLabel")
	local UIPadding_9 = Instance.new("UIPadding")
	local UIPadding_10 = Instance.new("UIPadding")

	Background.Name = "Background"
	Background.Parent = Quertzy
	Background.AnchorPoint = Vector2.new(0.5, 0.5)
	Background.BackgroundColor3 = Color3.fromRGB(19, 19, 19)
	Background.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Background.BorderSizePixel = 0
	Background.Position = UDim2.new(0.5, 0, 0.5, 0)
	Background.Size = Size

	lak(Background)
	Tog(Quertzy2, Background, Enum.KeyCode.LeftControl, Logo)

	local resize = Instance.new("TextButton")
	resize.Parent = Background
	resize.AnchorPoint = Vector2.new(1, 1)
	resize.Size = UDim2.new(0, 40, 0, 40)
	resize.Position = UDim2.new(1, 30, 1, 30)
	resize.BackgroundTransparency = 1
	resize.BorderSizePixel = 0
	resize.Text = ''

	resize.MouseEnter:Connect(function()
		UserInputService.MouseIcon = "rbxassetid://84174532888860"
	end)

	resize.MouseLeave:Connect(function()
		UserInputService.MouseIcon = ""
	end)

	local RESIZE_EZ = Instance.new("Frame")
	local UICorner333 = Instance.new("UICorner")
	local RESIZE_ICON = Instance.new("ImageLabel")

	RESIZE_EZ.Name = "RESIZE_EZ"
	RESIZE_EZ.Parent = Background
	RESIZE_EZ.AnchorPoint = Vector2.new(0.5, 0.5)
	RESIZE_EZ.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	RESIZE_EZ.BackgroundTransparency = 1
	RESIZE_EZ.BorderColor3 = Color3.fromRGB(0, 0, 0)
	RESIZE_EZ.BorderSizePixel = 0
	RESIZE_EZ.Position = UDim2.new(0.5, 0, 0.5, 0)
	RESIZE_EZ.Size = UDim2.new(1, 0, 1, 0)
	RESIZE_EZ.ZIndex = 887

	UICorner333.Parent = RESIZE_EZ
	UICorner333.CornerRadius = UDim.new(0, 10)

	RESIZE_ICON.Name = "RESIZE_ICON"
	RESIZE_ICON.Parent = RESIZE_EZ
	RESIZE_ICON.AnchorPoint = Vector2.new(0.5, 0.5)
	RESIZE_ICON.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	RESIZE_ICON.BackgroundTransparency = 1
	RESIZE_ICON.BorderColor3 = Color3.fromRGB(0, 0, 0)
	RESIZE_ICON.BorderSizePixel = 0
	RESIZE_ICON.Position = UDim2.new(0.5, 0, 0.5, 0)
	RESIZE_ICON.Size = UDim2.new(0, 100, 0, 100)
	RESIZE_ICON.Image = "rbxassetid://84174532888860"
	RESIZE_ICON.ImageTransparency = 1
	RESIZE_ICON.ZIndex = 888

	RESIZE_ICON.Visible = false
	RESIZE_EZ.Visible = false

	local function Resize(DragFrame, Frame)
		local resizing = false
		local startSize, startMouse

		local function StartResize(input)
			if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
				resizing = true
				RESIZE_ICON.Visible = true
				RESIZE_EZ.Visible = true
				startSize = Frame.Size
				startMouse = UserInputService:GetMouseLocation()
				tw({
					v = RESIZE_ICON,
					t = 0.2,
					s = "Linear",
					d = "Out",
					g = {ImageTransparency = 0}
				}):Play()
				tw({
					v = RESIZE_EZ,
					t = 0.2,
					s = "Linear",
					d = "Out",
					g = {BackgroundTransparency = 0.2}
				}):Play()
			end
		end

		local function UpdateResize(input)
			if resizing and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
				local currentMouse = UserInputService:GetMouseLocation()
				local mouseDelta = currentMouse - startMouse
				local newSize = UDim2.new(0, startSize.X.Offset + mouseDelta.X, 0, startSize.Y.Offset + mouseDelta.Y)
				newSize = UDim2.new(0, math.max(newSize.X.Offset, 500), 0, math.max(newSize.Y.Offset, 350))
				tw({
					v = Frame,
					t = 0.1,
					s = "Linear",
					d = "Out",
					g = {Size = newSize}
				}):Play()
			end
		end

		local function EndResize(input)
			if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
				resizing = false
				tw({
					v = RESIZE_ICON,
					t = 0.2,
					s = "Linear",
					d = "Out",
					g = {ImageTransparency = 1}
				}):Play()
				tw({
					v = RESIZE_EZ,
					t = 0.2,
					s = "Linear",
					d = "Out",
					g = {BackgroundTransparency = 1}
				}):Play()
				task.spawn(function()
					wait(0.1)
					RESIZE_ICON.Visible = false
					RESIZE_EZ.Visible = false
				end)
			end
		end

		DragFrame.InputBegan:Connect(StartResize)
		UserInputService.InputChanged:Connect(UpdateResize)
		UserInputService.InputEnded:Connect(EndResize)
	end

	Resize(resize, Background)

	UICorner.Parent = Background
	UICorner.CornerRadius = UDim.new(0, 10)

	DropShadow.Name = "DropShadow"
	DropShadow.Parent = Background
	DropShadow.AnchorPoint = Vector2.new(0.5, 0.5)
	DropShadow.BackgroundColor3 = Color3.fromRGB(28, 28, 30)
	DropShadow.BackgroundTransparency = 1
	DropShadow.BorderColor3 = Color3.fromRGB(0, 0, 0)
	DropShadow.BorderSizePixel = 0
	DropShadow.Position = UDim2.new(0.5, 0, 0.5, 0)
	DropShadow.Size = UDim2.new(1, 150, 1, 150)
	DropShadow.ZIndex = 0
	DropShadow.Image = "rbxassetid://8992230677"
	DropShadow.ImageColor3 = Color3.fromRGB(9, 14, 21)
	DropShadow.ImageTransparency = 0.5
	DropShadow.ScaleType = Enum.ScaleType.Slice
	DropShadow.SliceCenter = Rect.new(100, 100, 100, 100)

	Main.Name = "Main"
	Main.Parent = Background
	Main.AnchorPoint = Vector2.new(0.5, 0.5)
	Main.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Main.BackgroundTransparency = 1
	Main.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Main.BorderSizePixel = 0
	Main.Position = UDim2.new(0.5, 0, 0.5, 0)
	Main.Size = UDim2.new(1, 0, 1, 0)

	Header.Name = "Header"
	Header.Parent = Main
	Header.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Header.BackgroundTransparency = 1
	Header.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Header.BorderSizePixel = 0
	Header.Size = UDim2.new(1, 0, 0, 40)

	UIPadding.Parent = Header
	UIPadding.PaddingBottom = UDim.new(0, 5)
	UIPadding.PaddingLeft = UDim.new(0, 1)
	UIPadding.PaddingRight = UDim.new(0, 1)
	UIPadding.PaddingTop = UDim.new(0, 1)

	Back.Name = "Back"
	Back.Parent = Header
	Back.AnchorPoint = Vector2.new(1, 0)
	Back.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Back.BackgroundTransparency = 1
	Back.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Back.BorderSizePixel = 0
	Back.Position = UDim2.new(1, 0, 0, 0)
	Back.Size = UDim2.new(0, 35, 0, 35)
	Back.Visible = false

	ReturnIcon.Name = "ReturnIcon"
	ReturnIcon.Parent = Back
	ReturnIcon.AnchorPoint = Vector2.new(0.5, 0.5)
	ReturnIcon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	ReturnIcon.BackgroundTransparency = 1
	ReturnIcon.BorderColor3 = Color3.fromRGB(0, 0, 0)
	ReturnIcon.BorderSizePixel = 0
	ReturnIcon.Position = UDim2.new(0.5, 0, 0.5, 0)
	ReturnIcon.Size = UDim2.new(0.7, 0, 0.7, 0)
	ReturnIcon.Image = "rbxassetid://117231364055760"
	ReturnIcon.ImageTransparency = 0.5

	InsideHeader.Name = "InsideHeader"
	InsideHeader.Parent = Header
	InsideHeader.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	InsideHeader.BackgroundTransparency = 1
	InsideHeader.BorderColor3 = Color3.fromRGB(0, 0, 0)
	InsideHeader.BorderSizePixel = 0
	InsideHeader.Size = UDim2.new(1, 0, 1, 0)

	UIListLayout.Parent = InsideHeader
	UIListLayout.FillDirection = Enum.FillDirection.Horizontal
	UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
	UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Center
	UIListLayout.Padding = UDim.new(0, 5)

	TextHeader.Name = "TextHeader"
	TextHeader.Parent = InsideHeader
	TextHeader.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	TextHeader.BackgroundTransparency = 1
	TextHeader.BorderColor3 = Color3.fromRGB(0, 0, 0)
	TextHeader.BorderSizePixel = 0
	TextHeader.Position = UDim2.new(0.089463219, 0, 0.0588235296, 0)
	TextHeader.Size = UDim2.new(0, 416, 0, 30)

	TitleHeader.Name = "TitleHeader"
	TitleHeader.Parent = TextHeader
	TitleHeader.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	TitleHeader.BackgroundTransparency = 1
	TitleHeader.BorderColor3 = Color3.fromRGB(0, 0, 0)
	TitleHeader.BorderSizePixel = 0
	TitleHeader.Position = UDim2.new(0, 0, -0.125, 0)
	TitleHeader.Font = Enum.Font.GothamSemibold
	TitleHeader.Text = Title
	TitleHeader.TextColor3 = Color3.fromRGB(255, 255, 255)
	TitleHeader.TextSize = 15
	TitleHeader.TextXAlignment = Enum.TextXAlignment.Left
	TitleHeader.AutomaticSize = Enum.AutomaticSize.XY

	UIListLayout_2.Parent = TextHeader
	UIListLayout_2.SortOrder = Enum.SortOrder.LayoutOrder
	UIListLayout_2.VerticalAlignment = Enum.VerticalAlignment.Center
	UIListLayout_2.Padding = UDim.new(0, 2)

	DescHeader.Name = "DescHeader"
	DescHeader.Parent = TextHeader
	DescHeader.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	DescHeader.BackgroundTransparency = 1
	DescHeader.BorderColor3 = Color3.fromRGB(0, 0, 0)
	DescHeader.BorderSizePixel = 0
	DescHeader.Position = UDim2.new(0, 0, -0.125, 0)
	DescHeader.Font = Enum.Font.GothamMedium
	DescHeader.Text = Desc
	DescHeader.TextColor3 = Color3.fromRGB(255, 255, 255)
	DescHeader.TextSize = 10
	DescHeader.TextTransparency = 0.5
	DescHeader.TextXAlignment = Enum.TextXAlignment.Left
	DescHeader.AutomaticSize = Enum.AutomaticSize.XY

	LogoHeader.Name = "LogoHeader"
	LogoHeader.Parent = InsideHeader
	LogoHeader.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	LogoHeader.BackgroundTransparency = 1
	LogoHeader.BorderColor3 = Color3.fromRGB(0, 0, 0)
	LogoHeader.BorderSizePixel = 0
	LogoHeader.LayoutOrder = -1
	LogoHeader.Size = UDim2.new(0, 40, 0, 40)
	LogoHeader.Image = Logo

	Main_Pages.Name = "Main_Pages"
	Main_Pages.Parent = Main
	Main_Pages.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Main_Pages.BackgroundTransparency = 1
	Main_Pages.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Main_Pages.BorderSizePixel = 0
	Main_Pages.Size = UDim2.new(1, 0, 1, 0)
	Main_Pages.AnchorPoint = Vector2.new(0.5,0.5)
	Main_Pages.Position = UDim2.new(0.5, 0, 0.5, 0)
	Main_Pages.Visible = true

	Tabs.Name = "Tabs"
	Tabs.Parent = Main_Pages
	Tabs.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Tabs.BackgroundTransparency = 1
	Tabs.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Tabs.BorderSizePixel = 0
	Tabs.Size = UDim2.new(1, 0, 1, 0)

	UIPadding_2.Parent = Tabs

   Tabs_Inside.Name = "Tabs_Inside"
	Tabs_Inside.Parent = Tabs
	Tabs_Inside.AnchorPoint = Vector2.new(1, 0)
	Tabs_Inside.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Tabs_Inside.BackgroundTransparency = 1
	Tabs_Inside.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Tabs_Inside.BorderSizePixel = 0
	Tabs_Inside.Position = UDim2.new(1, 0, 0, 0)
	Tabs_Inside.Size = UDim2.new(0.999999999, 0, 1, 0)

	UIPadding_3.Parent = Tabs_Inside

	ScrollongTabs.Name = "ScrollongTabs"
	ScrollongTabs.Parent = Tabs_Inside
	ScrollongTabs.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	ScrollongTabs.BackgroundTransparency = 1
	ScrollongTabs.BorderColor3 = Color3.fromRGB(0, 0, 0)
	ScrollongTabs.BorderSizePixel = 0
	ScrollongTabs.Size = UDim2.new(1, 0, 1, 0)

	UIPadding_4.Parent = ScrollongTabs
	UIPadding_4.PaddingBottom = UDim.new(0, 0)

	InsideScrollongTabs.Name = "InsideScrollongTabs"
	InsideScrollongTabs.Parent = ScrollongTabs
	InsideScrollongTabs.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	InsideScrollongTabs.BackgroundTransparency = 1
	InsideScrollongTabs.BorderColor3 = Color3.fromRGB(0, 0, 0)
	InsideScrollongTabs.BorderSizePixel = 0
	InsideScrollongTabs.LayoutOrder = -5
	InsideScrollongTabs.Position = UDim2.new(0, 0, -1.27536146e-06, 0)
	InsideScrollongTabs.Size = UDim2.new(1, 0, 1, 0)

	MainTextInScroll.Name = "MainTextInScroll"
	MainTextInScroll.Parent = InsideScrollongTabs
	MainTextInScroll.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	MainTextInScroll.BackgroundTransparency = 1
	MainTextInScroll.BorderColor3 = Color3.fromRGB(0, 0, 0)
	MainTextInScroll.BorderSizePixel = 0
	MainTextInScroll.Size = UDim2.new(1, 0, 0, 15)
	MainTextInScroll.Font = Enum.Font.GothamBold
	MainTextInScroll.Text = "Page"
	MainTextInScroll.TextColor3 = Color3.fromRGB(255, 255, 255)
	MainTextInScroll.TextSize = 12
	MainTextInScroll.TextXAlignment = Enum.TextXAlignment.Left

	RealScrollongTabs.Name = "RealScrollongTabs"
	RealScrollongTabs.Parent = InsideScrollongTabs
	RealScrollongTabs.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	RealScrollongTabs.BackgroundTransparency = 1
	RealScrollongTabs.BorderColor3 = Color3.fromRGB(0, 0, 0)
	RealScrollongTabs.BorderSizePixel = 0
	RealScrollongTabs.Size = UDim2.new(1, 0, 1, 0)

	UIPadding_5.Parent = RealScrollongTabs
	UIPadding_5.PaddingTop = UDim.new(0, 20)

	Realscrolling.Name = "Realscrolling"
	Realscrolling.Parent = RealScrollongTabs
	Realscrolling.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Realscrolling.BackgroundTransparency = 1
	Realscrolling.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Realscrolling.BorderSizePixel = 0
	Realscrolling.Selectable = false
	Realscrolling.Size = UDim2.new(1, 0, 1, 0)
	Realscrolling.ScrollBarThickness = 0

	UIGridLayout.Parent = Realscrolling
	UIGridLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
	UIGridLayout.SortOrder = Enum.SortOrder.LayoutOrder
	UIGridLayout.CellPadding = UDim2.new(0, 8, 0, 8)
	UIGridLayout.CellSize = UDim2.new(0.479999989, 0, 0, 50)

	Realscrolling2.Name = "Realscrolling2"
	Realscrolling2.Parent = RealScrollongTabs
	Realscrolling2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Realscrolling2.BackgroundTransparency = 1
	Realscrolling2.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Realscrolling2.BorderSizePixel = 0
	Realscrolling2.Selectable = false
	Realscrolling2.Size = UDim2.new(1, 0, 1, 0)
	Realscrolling2.ScrollBarThickness = 0

	UIGridLayout2.Parent = Realscrolling2
	UIGridLayout2.SortOrder = Enum.SortOrder.LayoutOrder
	UIGridLayout2.CellPadding = UDim2.new(0, 8, 0, 8)
	UIGridLayout2.CellSize = UDim2.new(0.479999989, 0, 0, 50)

	UIPadding_6.Parent = Realscrolling
	UIPadding_6.PaddingTop = UDim.new(0, 1)

	UIPadding_7.Parent = Realscrolling2
	UIPadding_7.PaddingTop = UDim.new(0, 1)

	UIPadding_9.Parent = Main_Pages
	UIPadding_9.PaddingTop = UDim.new(0, 45)

	UIPadding_10.Parent = Main
	UIPadding_10.PaddingBottom = UDim.new(0, 10)
	UIPadding_10.PaddingLeft = UDim.new(0, 10)
	UIPadding_10.PaddingRight = UDim.new(0, 10)
	UIPadding_10.PaddingTop = UDim.new(0, 10)

	local Tabs = {}

	local ClickRE = click(Back)

	ClickRE.MouseButton1Click:Connect(function()
		for _, v in pairs(Background:GetChildren()) do
			if (v.Name == "Dropdown" and v.Visible) or v.Name == "Window" then
				return
			end
		end
		for i, v in pairs(Main:GetChildren()) do
			if string.find(v.Name, "Pages") then
				v.Visible = false
				v.Size = UDim2.new(0, 0,0, 0)
			end
		end
		Main_Pages.Visible = true
		Back.Visible = false
		tw({
			v = Main_Pages,
			t = 0.15,
			s = "Back",
			d = "Out",
			g = {Size = UDim2.new(1, 0,1, 0)}
		}):Play()
	end)

	function Tabs:Tab(meta)

		local Title = meta.Title
		local Desc = meta.Desc
		local Icon = meta.Icon
     local Mode2 = meta.Mode2

		local Addtab = Instance.new("Frame")
		local insideTab = Instance.new("Frame")
		local UIListLayout = Instance.new("UIListLayout")
		local IconTab = Instance.new("ImageLabel")
		local TextTab = Instance.new("Frame")
		local TitleTab = Instance.new("TextLabel")
		local UIListLayout_2 = Instance.new("UIListLayout")
		local DescTab = Instance.new("TextLabel")
		local UIPadding = Instance.new("UIPadding")
		local UICorner = Instance.new("UICorner")

if Mode2 then
    Addtab.Name = "Addtab"
    Addtab.Parent = Realscrolling2
    Addtab.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    Addtab.BorderColor3 = Color3.fromRGB(0, 0, 0)
    Addtab.BorderSizePixel = 0
    Addtab.Size = UDim2.new(0, 100, 0, 100)
else
    Addtab.Name = "Addtab"
    Addtab.Parent = Realscrolling
    Addtab.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    Addtab.BorderColor3 = Color3.fromRGB(0, 0, 0)
    Addtab.BorderSizePixel = 0
    Addtab.Size = UDim2.new(0, 100, 0, 100)
end

		insideTab.Name = "insideTab"
		insideTab.Parent = Addtab
		insideTab.AnchorPoint = Vector2.new(0.5, 0.5)
		insideTab.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		insideTab.BackgroundTransparency = 1
		insideTab.BorderColor3 = Color3.fromRGB(0, 0, 0)
		insideTab.BorderSizePixel = 0
		insideTab.Position = UDim2.new(0.5, 0, 0.5, 0)
		insideTab.Size = UDim2.new(1, 0, 1, 0)

		UIListLayout.Parent = insideTab
		UIListLayout.FillDirection = Enum.FillDirection.Horizontal
		UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
		UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Center
		UIListLayout.Padding = UDim.new(0, 15)

		IconTab.Name = "IconTab"
		IconTab.Parent = insideTab
		IconTab.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		IconTab.BackgroundTransparency = 1
		IconTab.BorderColor3 = Color3.fromRGB(0, 0, 0)
		IconTab.BorderSizePixel = 0
		IconTab.LayoutOrder = -1
		IconTab.Size = UDim2.new(0, 25, 0, 25)
		IconTab.Image = GetIcon(Icon)

      local UIGradient_1 = Instance.new("UIGradient")
      UIGradient_1.Parent = IconTab
      UIGradient_1.Color = ColorSequence.new{ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 255, 127)), ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 61, 29))}

		TextTab.Name = "TextTab"
		TextTab.Parent = insideTab
		TextTab.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		TextTab.BackgroundTransparency = 1
		TextTab.BorderColor3 = Color3.fromRGB(0, 0, 0)
		TextTab.BorderSizePixel = 0
		TextTab.Position = UDim2.new(0.078125, 0, -0.0160778221, 0)
		TextTab.Size = UDim2.new(0, 0, 0, 30)

		TitleTab.Name = "TitleTab"
		TitleTab.Parent = TextTab
		TitleTab.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		TitleTab.BackgroundTransparency = 1
		TitleTab.BorderColor3 = Color3.fromRGB(0, 0, 0)
		TitleTab.BorderSizePixel = 0
		TitleTab.Position = UDim2.new(0, 0, -0.125, 0)
		TitleTab.Font = Enum.Font.GothamSemibold
		TitleTab.Text = Title
		TitleTab.TextColor3 = Color3.fromRGB(255, 255, 255)
		TitleTab.TextSize = 13
		TitleTab.TextXAlignment = Enum.TextXAlignment.Left
		TitleTab.AutomaticSize = Enum.AutomaticSize.XY

		UIListLayout_2.Parent = TextTab
		UIListLayout_2.SortOrder = Enum.SortOrder.LayoutOrder
		UIListLayout_2.VerticalAlignment = Enum.VerticalAlignment.Center
		UIListLayout_2.Padding = UDim.new(0, 2)

		DescTab.Name = "DescTab"
		DescTab.Parent = TextTab
		DescTab.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		DescTab.BackgroundTransparency = 1
		DescTab.BorderColor3 = Color3.fromRGB(0, 0, 0)
		DescTab.BorderSizePixel = 0
		DescTab.Position = UDim2.new(0, 0, -0.125, 0)
		DescTab.Font = Enum.Font.GothamMedium
		DescTab.Text = Desc
		DescTab.TextColor3 = Color3.fromRGB(255, 255, 255)
		DescTab.TextSize = 10
		DescTab.TextTransparency = 0.5
		DescTab.TextXAlignment = Enum.TextXAlignment.Left
		DescTab.AutomaticSize = Enum.AutomaticSize.XY

		UIPadding.Parent = insideTab
		UIPadding.PaddingLeft = UDim.new(0, 15)

		UICorner.Parent = Addtab

		local Pages = Instance.new("Frame")
		local UIPadding3 = Instance.new("UIPadding")
		local InsidePage = Instance.new("Frame")
		local UIPadding2 = Instance.new("UIPadding")
		local UIListLayout1 = Instance.new("UIListLayout")
		local Left = Instance.new("ScrollingFrame")
		local UIListLayout4 = Instance.new("UIListLayout")
		local UIPadding4 = Instance.new("UIPadding")
		local Right = Instance.new("ScrollingFrame")
		local UIListLayout5 = Instance.new("UIListLayout")
		local UIPadding6 = Instance.new("UIPadding")

		Pages.Name = "Pages"
		Pages.Parent = Main
		Pages.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Pages.BackgroundTransparency = 1
		Pages.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Pages.BorderSizePixel = 0
		Pages.Size = UDim2.new(1, 0, 1, 0)
		Pages.AnchorPoint = Vector2.new(0.5,0.5)
		Pages.Position = UDim2.new(0.5, 0, 0.5, 0)
		Pages.Visible = false

		UIPadding3.Parent = Pages
		UIPadding3.PaddingTop = UDim.new(0, 45)

		InsidePage.Name = "InsidePage"
		InsidePage.Parent = Pages
		InsidePage.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		InsidePage.BackgroundTransparency = 1
		InsidePage.BorderColor3 = Color3.fromRGB(0, 0, 0)
		InsidePage.BorderSizePixel = 0
		InsidePage.Size = UDim2.new(1, 0, 1, 0)

		UIPadding2.Name = "UIPadding2"
		UIPadding2.Parent = InsidePage

		UIListLayout1.Name = "UIListLayout1"
		UIListLayout1.Parent = InsidePage
		UIListLayout1.FillDirection = Enum.FillDirection.Horizontal
		UIListLayout1.HorizontalAlignment = Enum.HorizontalAlignment.Center
		UIListLayout1.SortOrder = Enum.SortOrder.LayoutOrder
		UIListLayout1.Padding = UDim.new(0, 5)

		Left.Name = "Left"
		Left.Parent = InsidePage
		Left.Active = true
		Left.AnchorPoint = Vector2.new(0.5, 0.5)
		Left.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Left.BackgroundTransparency = 1
		Left.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Left.BorderSizePixel = 0
		Left.Size = UDim2.new(0.5, 0, 1, 0)
		Left.ScrollBarThickness = 0

		UIListLayout4.Name = "UIListLayout4"
		UIListLayout4.Parent = Left
		UIListLayout4.HorizontalAlignment = Enum.HorizontalAlignment.Center
		UIListLayout4.SortOrder = Enum.SortOrder.LayoutOrder
		UIListLayout4.Padding = UDim.new(0, 10)

		UIPadding4.Name = "UIPadding4"
		UIPadding4.Parent = Left
		UIPadding4.PaddingTop = UDim.new(0, 1)

		Right.Name = "Right"
		Right.Parent = InsidePage
		Right.Active = true
		Right.AnchorPoint = Vector2.new(0.5, 0.5)
		Right.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Right.BackgroundTransparency = 1
		Right.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Right.BorderSizePixel = 0
		Right.Size = UDim2.new(0.5, 0, 1, 0)
		Right.ScrollBarThickness = 0

		UIListLayout5.Name = "UIListLayout5"
		UIListLayout5.Parent = Right
		UIListLayout5.HorizontalAlignment = Enum.HorizontalAlignment.Center
		UIListLayout5.SortOrder = Enum.SortOrder.LayoutOrder
		UIListLayout5.Padding = UDim.new(0, 10)

		UIPadding6.Name = "UIPadding6"
		UIPadding6.Parent = Right
		UIPadding6.PaddingTop = UDim.new(0, 1)

		Canvas_Y(UIListLayout5, Right, 20)
		Canvas_Y(UIListLayout4, Left, 20)

		local function GetSide(side)
			if not side then
				return Left
			end
			local sideLower = string.lower(tostring(side))
			if sideLower == "r" or sideLower == "right" or side == 2 then
				return Right
			elseif sideLower == "l" or sideLower == "left" or side == 1 then
				return Left
			else
				return Left
			end
		end

		local ClickTAB = click(Addtab)

		ClickTAB.MouseButton1Click:Connect(function()
			for i, v in pairs(Main:GetChildren()) do
				if string.find(v.Name, "Pages") then
					v.Visible = false
					v.Size = UDim2.new(0, 0,0, 0)
				end
			end
			Pages.Visible = true
			Back.Size = UDim2.new(0, 0, 0, 0)
			Back.Visible = true
			tw({
				v = Back,
				t = 0.1,
				s = "Linear",
				d = "Out",
				g = {Size = UDim2.new(0, 35,0, 35)}
			}):Play()
			tw({
				v = Pages,
				t = 0.15,
				s = "Back",
				d = "Out",
				g = {Size = UDim2.new(1, 0,1, 0)}
			}):Play()
		end)

		local Section = {}

		function Section:Section(meta)

			local Title = meta.Title
			local Side = meta.Side

			local Section = Instance.new("Frame")
			local UIListLayout = Instance.new("UIListLayout")
			local LineZ = Instance.new("Frame")
			local TitleSection = Instance.new("TextLabel")
			local UIPadding = Instance.new("UIPadding")
			local Line = Instance.new("Frame")
			local UICorner = Instance.new("UICorner")
			local LineColor = Instance.new("Frame")

			Section.Name = "Section"
			Section.Parent = GetSide(Side)
			Section.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
			Section.BorderColor3 = Color3.fromRGB(20, 20, 20)
			Section.BorderSizePixel = 0
			Section.Size = UDim2.new(0.980000019, 0, 0, 150)

			UIListLayout.Parent = Section
			UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
			UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
			UIListLayout.Padding = UDim.new(0, 3)

			TitleSection.Name = "Title"
			TitleSection.Parent = Section
			TitleSection.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			TitleSection.BackgroundTransparency = 1
			TitleSection.BorderColor3 = Color3.fromRGB(0, 0, 0)
			TitleSection.BorderSizePixel = 0
			TitleSection.LayoutOrder = -3
			TitleSection.Position = UDim2.new(0.0500000492, 0, 0, 0)
			TitleSection.AutomaticSize = Enum.AutomaticSize.XY
			TitleSection.Font = Enum.Font.GothamSemibold
			TitleSection.Text = Title
			TitleSection.TextColor3 = Color3.fromRGB(255, 255, 255)
			TitleSection.TextSize = 12

			UIPadding.Parent = Section
			UIPadding.PaddingTop = UDim.new(0, 10)

			Line.Name = "Line"
			Line.Parent = Section
			Line.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
			Line.BackgroundTransparency = 0.949999988079071
			Line.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Line.BorderSizePixel = 0
			Line.LayoutOrder = -2
			Line.Position = UDim2.new(-0.209090903, 0, 0.215053767, 0)
			Line.Size = UDim2.new(1, 0, 0, 1)

			UICorner.Parent = Section
			UICorner.CornerRadius = UDim.new(0, 5)

			LineColor.Name = "LineColor"
			LineColor.Parent = Section
			LineColor.BackgroundColor3 = Color3.fromRGB(134, 211, 255)
			LineColor.BorderColor3 = Color3.fromRGB(0, 0, 0)
			LineColor.BorderSizePixel = 0
			LineColor.LayoutOrder = -3
			LineColor.Position = UDim2.new(-0.209090903, 0, 0.215053767, 0)
			LineColor.Size = UDim2.new(0, TitleSection.TextBounds.X - 10, 0, 2)
			UIListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
			Section.Size = UDim2.new(0.980000019, 0, 0, UIListLayout.AbsoluteContentSize.Y + 15)

          local UIGradient_1 = Instance.new("UIGradient")
          UIGradient_1.Parent = LineColor
			 UIGradient_1.Color = ColorSequence.new{ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 255, 127)), ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 57, 28))}
			end)

			local Class = {}

			function Class:Button(meta)

				local Title = meta.Title
				local Callback = meta.Callback

				local Button = Instance.new("Frame")
				local UICorner = Instance.new("UICorner")
				local TextLabel = Instance.new("TextLabel")

				Button.Name = "Button"
				Button.Parent = Section
				Button.BackgroundColor3 = Color3.fromRGB(134, 211, 255)
				Button.BorderColor3 = Color3.fromRGB(0, 0, 0)
				Button.BorderSizePixel = 0
				Button.Size = UDim2.new(0.97, 0, 0, 30)
				Button.ClipsDescendants = true

            local UIGradient_1 = Instance.new("UIGradient")
            UIGradient_1.Parent = Button
            UIGradient_1.Color = ColorSequence.new{ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 255, 127)), ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 61, 29))}

				UICorner.Parent = Button
				UICorner.CornerRadius = UDim.new(0, 10)

				TextLabel.Parent = Button
				TextLabel.AnchorPoint = Vector2.new(0.5, 0.5)
				TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				TextLabel.BackgroundTransparency = 1
				TextLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
				TextLabel.BorderSizePixel = 0
				TextLabel.Position = UDim2.new(0.5, 0, 0.5, 0)
				TextLabel.Font = Enum.Font.GothamSemibold
				TextLabel.Text = Title
				TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
				TextLabel.TextSize = 12
				TextLabel.AutomaticSize = Enum.AutomaticSize.XY

				local ClickButton = click(Button)

				ClickButton.MouseButton1Click:Connect(function()
					for _, v in pairs(Background:GetChildren()) do
						if (v.Name == "Dropdown" and v.Visible) or v.Name == "Window" then
							return
						end
					end
					EffectClick(ClickButton, Button)
					Callback()
				end)
			end

			function Class:ButtomImage(meta)

				local Title = meta.Title
				local Icon = meta.Icon
				local Callback = meta.Callback

				local Toggle = Instance.new("Frame")
				local UICorner = Instance.new("UICorner")
				local InsideToggle = Instance.new("Frame")
				local UIPadding = Instance.new("UIPadding")
				local UIListLayout = Instance.new("UIListLayout")
				local TitleTOgle = Instance.new("TextLabel")
				local ImageLabel = Instance.new("ImageLabel")
				local clickbutton = click(Toggle)

				Toggle.Name = "Toggle"
				Toggle.Parent = Section
				Toggle.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
				Toggle.BorderColor3 = Color3.fromRGB(0, 0, 0)
				Toggle.BorderSizePixel = 0
				Toggle.Size = UDim2.new(0.97, 0, 0, 40)
				Toggle.ClipsDescendants = true

				UICorner.Parent = Toggle
				UICorner.CornerRadius = UDim.new(0, 10)

				InsideToggle.Name = "InsideToggle"
				InsideToggle.Parent = Toggle
				InsideToggle.AnchorPoint = Vector2.new(0.5, 0.5)
				InsideToggle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				InsideToggle.BackgroundTransparency = 1
				InsideToggle.BorderColor3 = Color3.fromRGB(0, 0, 0)
				InsideToggle.BorderSizePixel = 0
				InsideToggle.Position = UDim2.new(0.5, 0, 0.5, 0)
				InsideToggle.Size = UDim2.new(1, 0, 1, 0)

				UIPadding.Parent = InsideToggle
				UIPadding.PaddingLeft = UDim.new(0, 6)

				UIListLayout.Parent = InsideToggle
				UIListLayout.FillDirection = Enum.FillDirection.Horizontal
				UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
				UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Center
				UIListLayout.Padding = UDim.new(0, 10)

				TitleTOgle.Name = "TitleTOgle"
				TitleTOgle.Parent = InsideToggle
				TitleTOgle.AnchorPoint = Vector2.new(0.5, 0.5)
				TitleTOgle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				TitleTOgle.BackgroundTransparency = 1
				TitleTOgle.BorderColor3 = Color3.fromRGB(0, 0, 0)
				TitleTOgle.BorderSizePixel = 0
				TitleTOgle.LayoutOrder = -4
				TitleTOgle.Position = UDim2.new(0.499830812, 0, 0.5, 0)
				TitleTOgle.Size = UDim2.new(0.650434852, 0, 0.300000012, 0)
				TitleTOgle.Font = Enum.Font.GothamSemibold
				TitleTOgle.Text = Title
				TitleTOgle.TextColor3 = Color3.fromRGB(255, 255, 255)
				TitleTOgle.TextSize = 12
				TitleTOgle.TextXAlignment = Enum.TextXAlignment.Left

				ImageLabel.Parent = InsideToggle
				ImageLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				ImageLabel.BackgroundTransparency = 1
				ImageLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
				ImageLabel.BorderSizePixel = 0
				ImageLabel.LayoutOrder = -5
				ImageLabel.Size = UDim2.new(0, 30, 0, 30)
				ImageLabel.Image = GetIcon(Icon)

				local GG = Instance.new("Frame")
				local UIPadding = Instance.new("UIPadding")
				local TRUEE = Instance.new("ImageLabel")

				GG.Name = "GG"
				GG.Parent = Toggle
				GG.AnchorPoint = Vector2.new(0.5, 0.5)
				GG.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				GG.BackgroundTransparency = 1
				GG.BorderColor3 = Color3.fromRGB(0, 0, 0)
				GG.BorderSizePixel = 0
				GG.Position = UDim2.new(0.5, 0, 0.5, 0)
				GG.Size = UDim2.new(1, 0, 1, 0)

				UIPadding.Parent = GG
				UIPadding.PaddingBottom = UDim.new(0, 1)
				UIPadding.PaddingLeft = UDim.new(0, 1)
				UIPadding.PaddingRight = UDim.new(0, 1)
				UIPadding.PaddingTop = UDim.new(0, 1)

				TRUEE.Name = "TRUEE"
				TRUEE.Parent = GG
				TRUEE.AnchorPoint = Vector2.new(1, 0.5)
				TRUEE.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				TRUEE.BackgroundTransparency = 1
				TRUEE.BorderColor3 = Color3.fromRGB(0, 0, 0)
				TRUEE.BorderSizePixel = 0
				TRUEE.Position = UDim2.new(0.949999988, 0, 0.5, 0)
				TRUEE.Size = UDim2.new(0, 20, 0, 20)
				TRUEE.Image = "rbxassetid://108028847031522"
				clickbutton.MouseButton1Click:Connect(function()
					for _, v in pairs(Background:GetChildren()) do
						if (v.Name == "Dropdown" and v.Visible) or v.Name == "Window" then
							return
						end
					end
					Callback()
					EffectClick(clickbutton, Toggle)
				end)
			end

			function Class:ToggleImage(meta)

				local Title = meta.Title
				local Icon = meta.Icon
				local Value = meta.Value
				local Callback = meta.Callback

				local Toggle = Instance.new("Frame")
				local UICorner = Instance.new("UICorner")
				local InsideToggle = Instance.new("Frame")
				local UIPadding = Instance.new("UIPadding")
				local UIListLayout = Instance.new("UIListLayout")
				local TitleTOgle = Instance.new("TextLabel")
				local ImageLabel = Instance.new("ImageLabel")
				local ClickToggle = click(Toggle)

				Toggle.Name = "Toggle"
				Toggle.Parent = Section
				Toggle.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
				Toggle.BorderColor3 = Color3.fromRGB(0, 0, 0)
				Toggle.BorderSizePixel = 0
				Toggle.Size = UDim2.new(0.97, 0, 0, 40)
				Toggle.ClipsDescendants = true

				UICorner.Parent = Toggle
				UICorner.CornerRadius = UDim.new(0, 10)

				InsideToggle.Name = "InsideToggle"
				InsideToggle.Parent = Toggle
				InsideToggle.AnchorPoint = Vector2.new(0.5, 0.5)
				InsideToggle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				InsideToggle.BackgroundTransparency = 1
				InsideToggle.BorderColor3 = Color3.fromRGB(0, 0, 0)
				InsideToggle.BorderSizePixel = 0
				InsideToggle.Position = UDim2.new(0.5, 0, 0.5, 0)
				InsideToggle.Size = UDim2.new(1, 0, 1, 0)

				UIPadding.Parent = InsideToggle
				UIPadding.PaddingLeft = UDim.new(0, 6)


				local GG = Instance.new("Frame")
				local UIPaddingz = Instance.new("UIPadding")
				local noColor = Instance.new("Frame")
				local UICorner_2 = Instance.new("UICorner")
				local Color = Instance.new("Frame")
				local UICorner_3 = Instance.new("UICorner")
				local TRUEE = Instance.new("ImageLabel")

				GG.Name = "GG"
				GG.Parent = Toggle
				GG.AnchorPoint = Vector2.new(0.5, 0.5)
				GG.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				GG.BackgroundTransparency = 1
				GG.BorderColor3 = Color3.fromRGB(0, 0, 0)
				GG.BorderSizePixel = 0
				GG.Position = UDim2.new(0.5, 0, 0.5, 0)
				GG.Size = UDim2.new(1, 0, 1, 0)

				UIPaddingz.Parent = GG
				UIPaddingz.PaddingBottom = UDim.new(0, 1)
				UIPaddingz.PaddingLeft = UDim.new(0, 1)
				UIPaddingz.PaddingRight = UDim.new(0, 1)
				UIPaddingz.PaddingTop = UDim.new(0, 1)

				noColor.Name = "noColor"
				noColor.Parent = GG
				noColor.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
				noColor.BorderColor3 = Color3.fromRGB(0, 0, 0)
				noColor.BorderSizePixel = 0
				noColor.AnchorPoint = Vector2.new(1,0.5)
				noColor.Position = UDim2.new(0.95,0,0.5,0)
				noColor.Size = UDim2.new(0, 25, 0, 25)

				UICorner_2.Parent = noColor

				Color.Name = "Color"
				Color.Parent = noColor
				Color.AnchorPoint = Vector2.new(0.5, 0.5)
				Color.BackgroundColor3 = Color3.fromRGB(134, 211, 255)
				Color.BorderColor3 = Color3.fromRGB(0, 0, 0)
				Color.BorderSizePixel = 0
				Color.Position = UDim2.new(0.5, 0, 0.5, 0)
				Color.Size = UDim2.new(1, 0, 1, 0)
				Color.BackgroundTransparency = 1

            local UIGradient_1 = Instance.new("UIGradient")
            UIGradient_1.Parent = Color
            UIGradient_1.Color = ColorSequence.new{ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 255, 127)), ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 61, 29))}

				UICorner_3.Parent = Color

				TRUEE.Name = "TRUEE"
				TRUEE.Parent = Color
				TRUEE.AnchorPoint = Vector2.new(0.5, 0.5)
				TRUEE.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				TRUEE.BackgroundTransparency = 1
				TRUEE.BorderColor3 = Color3.fromRGB(0, 0, 0)
				TRUEE.BorderSizePixel = 0
				TRUEE.Position = UDim2.new(0.5, 0, 0.5, 0)
				TRUEE.Size = UDim2.new(0.4, 0, 0.4, 0)
				TRUEE.Image = "rbxassetid://99035215947422"
				TRUEE.ImageColor3 = Color3.fromRGB(24, 24, 24)
				TRUEE.Size = UDim2.new(0, 0, 0, 0)

				UIListLayout.Parent = InsideToggle
				UIListLayout.FillDirection = Enum.FillDirection.Horizontal
				UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
				UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Center
				UIListLayout.Padding = UDim.new(0, 10)

				TitleTOgle.Name = "TitleTOgle"
				TitleTOgle.Parent = InsideToggle
				TitleTOgle.AnchorPoint = Vector2.new(0.5, 0.5)
				TitleTOgle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				TitleTOgle.BorderColor3 = Color3.fromRGB(0, 0, 0)
            TitleTOgle.BackgroundTransparency = 1
				TitleTOgle.BorderSizePixel = 0
				TitleTOgle.LayoutOrder = -4
				TitleTOgle.Position = UDim2.new(0.469273478, 0, 0.5, 0)
				TitleTOgle.Size = UDim2.new(0.632973492, 0, 0.300000012, 0)
				TitleTOgle.Font = Enum.Font.GothamSemibold
				TitleTOgle.Text = Title
				TitleTOgle.TextColor3 = Color3.fromRGB(255, 255, 255)
				TitleTOgle.TextSize = 12
				TitleTOgle.TextXAlignment = Enum.TextXAlignment.Left

				ImageLabel.Parent = InsideToggle
				ImageLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				ImageLabel.BackgroundTransparency = 1
				ImageLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
				ImageLabel.BorderSizePixel = 0
				ImageLabel.LayoutOrder = -5
				ImageLabel.Size = UDim2.new(0, 30, 0, 30)
				ImageLabel.Image = GetIcon(Icon)

				local function Togglex(Value)
					if not Value then 
						Callback(Value)
						tw({
							v = Color,
							t = 0.5,
							s = "Back",
							d = "Out",
							g = {BackgroundTransparency = 1}
						}):Play()
						tw({
							v = TRUEE,
							t = 0.2,
							s = "Back",
							d = "Out",
							g = {Size = UDim2.new(0, 0,0, 0)}
						}):Play()
					elseif Value then 
						Callback(Value)
						tw({
							v = Color,
							t = 0.5,
							s = "Back",
							d = "Out",
							g = {BackgroundTransparency = 0}
						}):Play()
						tw({
							v = TRUEE,
							t = 0.1,
							s = "Bounce",
							d = "Out",
							g = {Size = UDim2.new(0.8, 0,0.8, 0)}
						}):Play()
						delay(0.05, function()
							tw({
								v = TRUEE,
								t = 0.2,
								s = "Bounce",
								d = "Out",
								g = {Size = UDim2.new(0.4, 0,0.4, 0)}
							}):Play()
						end)
					end
				end

				ClickToggle.MouseButton1Click:Connect(function()
					for _, v in pairs(Background:GetChildren()) do
						if (v.Name == "Dropdown" and v.Visible) or v.Name == "Window" then
							return
						end
					end
					Value = not Value
					Togglex(Value)
					EffectClick(ClickToggle, Toggle)
				end)

				Togglex(Value)
			end

			function Class:Toggle(meta)
				local Title = meta.Title
				local Value = meta.Value
				local Callback = meta.Callback

				local Toggle = Instance.new("Frame")
				local UICorner2 = Instance.new("UICorner")
				local InsideToggle = Instance.new("Frame")
				local UIPadding = Instance.new("UIPadding")

				local UIListLayout = Instance.new("UIListLayout")
				local TitleTOgle = Instance.new("TextLabel")
				local ClickToggle = click(Toggle)

				Toggle.Name = "Toggle"
				Toggle.Parent = Section
				Toggle.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
				Toggle.BorderColor3 = Color3.fromRGB(0, 0, 0)
				Toggle.BorderSizePixel = 0
				Toggle.Size = UDim2.new(0.97, 0, 0, 40)
				Toggle.ClipsDescendants = true

				UICorner2.Parent = Toggle
				UICorner2.CornerRadius = UDim.new(0, 10)

				InsideToggle.Name = "InsideToggle"
				InsideToggle.Parent = Toggle
				InsideToggle.AnchorPoint = Vector2.new(0.5, 0.5)
				InsideToggle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				InsideToggle.BackgroundTransparency = 1
				InsideToggle.BorderColor3 = Color3.fromRGB(0, 0, 0)
				InsideToggle.BorderSizePixel = 0
				InsideToggle.Position = UDim2.new(0.5, 0, 0.5, 0)
				InsideToggle.Size = UDim2.new(1, 0, 1, 0)

				UIPadding.Parent = InsideToggle
				UIPadding.PaddingLeft = UDim.new(0, 15)

				local GG = Instance.new("Frame")
				local UIPaddingz = Instance.new("UIPadding")
				local noColor = Instance.new("Frame")
				local UICorner_2 = Instance.new("UICorner")
				local Color = Instance.new("Frame")
				local UICorner_3 = Instance.new("UICorner")
				local TRUEE = Instance.new("ImageLabel")

				GG.Name = "GG"
				GG.Parent = Toggle
				GG.AnchorPoint = Vector2.new(0.5, 0.5)
				GG.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				GG.BackgroundTransparency = 1
				GG.BorderColor3 = Color3.fromRGB(0, 0, 0)
				GG.BorderSizePixel = 0
				GG.Position = UDim2.new(0.5, 0, 0.5, 0)
				GG.Size = UDim2.new(1, 0, 1, 0)

				UIPaddingz.Parent = GG
				UIPaddingz.PaddingBottom = UDim.new(0, 1)
				UIPaddingz.PaddingLeft = UDim.new(0, 1)
				UIPaddingz.PaddingRight = UDim.new(0, 1)
				UIPaddingz.PaddingTop = UDim.new(0, 1)

				noColor.Name = "noColor"
				noColor.Parent = GG
				noColor.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
				noColor.BorderColor3 = Color3.fromRGB(0, 0, 0)
				noColor.BorderSizePixel = 0
				noColor.AnchorPoint = Vector2.new(1,0.5)
				noColor.Position = UDim2.new(0.95,0,0.5,0)
				noColor.Size = UDim2.new(0, 25, 0, 25)

				UICorner_2.Parent = noColor

				Color.Name = "Color"
				Color.Parent = noColor
				Color.AnchorPoint = Vector2.new(0.5, 0.5)
				Color.BackgroundColor3 = Color3.fromRGB(134, 211, 255)
				Color.BorderColor3 = Color3.fromRGB(0, 0, 0)
				Color.BorderSizePixel = 0
				Color.Position = UDim2.new(0.5, 0, 0.5, 0)
				Color.Size = UDim2.new(1, 0, 1, 0)
				Color.BackgroundTransparency = 1

            local UIGradient_1 = Instance.new("UIGradient")
            UIGradient_1.Parent = Color
            UIGradient_1.Color = ColorSequence.new{ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 255, 127)), ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 61, 29))}

				UICorner_3.Parent = Color

				TRUEE.Name = "TRUEE"
				TRUEE.Parent = Color
				TRUEE.AnchorPoint = Vector2.new(0.5, 0.5)
				TRUEE.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				TRUEE.BackgroundTransparency = 1
				TRUEE.BorderColor3 = Color3.fromRGB(0, 0, 0)
				TRUEE.BorderSizePixel = 0
				TRUEE.Position = UDim2.new(0.5, 0, 0.5, 0)
				TRUEE.Size = UDim2.new(0.4, 0, 0.4, 0)
				TRUEE.Image = "rbxassetid://99035215947422"
				TRUEE.ImageColor3 = Color3.fromRGB(24, 24, 24)
				TRUEE.Size = UDim2.new(0, 0, 0, 0)

				UIListLayout.Parent = InsideToggle
				UIListLayout.FillDirection = Enum.FillDirection.Horizontal
				UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
				UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Center
				UIListLayout.Padding = UDim.new(0, 10)

				TitleTOgle.Name = "TitleTOgle"
				TitleTOgle.Parent = InsideToggle
				TitleTOgle.AnchorPoint = Vector2.new(0.5, 0.5)
				TitleTOgle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				TitleTOgle.BorderColor3 = Color3.fromRGB(0, 0, 0)
      		TitleTOgle.BackgroundTransparency = 1
				TitleTOgle.BorderSizePixel = 0
				TitleTOgle.LayoutOrder = -4
				TitleTOgle.Position = UDim2.new(0.469273478, 0, 0.5, 0)
				TitleTOgle.Size = UDim2.new(0.632973492, 0, 0.300000012, 0)
				TitleTOgle.Font = Enum.Font.GothamSemibold
				TitleTOgle.Text = Title
				TitleTOgle.TextColor3 = Color3.fromRGB(255, 255, 255)
				TitleTOgle.TextSize = 12
				TitleTOgle.TextXAlignment = Enum.TextXAlignment.Left

				local function Togglex(Value)
					if not Value then 
						Callback(Value)
						tw({
							v = Color,
							t = 0.5,
							s = "Back",
							d = "Out",
							g = {BackgroundTransparency = 1}
						}):Play()
						tw({
							v = TRUEE,
							t = 0.2,
							s = "Back",
							d = "Out",
							g = {Size = UDim2.new(0, 0,0, 0)}
						}):Play()
					elseif Value then 
						Callback(Value)
						tw({
							v = Color,
							t = 0.5,
							s = "Back",
							d = "Out",
							g = {BackgroundTransparency = 0}
						}):Play()
						tw({
							v = TRUEE,
							t = 0.1,
							s = "Bounce",
							d = "Out",
							g = {Size = UDim2.new(0.8, 0,0.8, 0)}
						}):Play()
						delay(0.05, function()
							tw({
								v = TRUEE,
								t = 0.2,
								s = "Bounce",
								d = "Out",
								g = {Size = UDim2.new(0.4, 0,0.4, 0)}
							}):Play()
						end)
					end
				end

				ClickToggle.MouseButton1Click:Connect(function()
					for _, v in pairs(Background:GetChildren()) do
						if (v.Name == "Dropdown" and v.Visible) or v.Name == "Window" then
							return
						end
					end
					Value = not Value
					Togglex(Value)
					EffectClick(ClickToggle, Toggle)
				end)

				Togglex(Value)
			end

			local function Autoside(x)
				if x.Parent.Parent.Name == "Left" then
					return 1
				elseif x.Parent.Parent.Name == "Right" then
					return 0
				end
			end

			function Class:Dropdown(info)

				local Title = info.Title
				local List = info.List or {}
				local Value = info.Value
				local Multi = info.Multi or false
				local Callback = info.Callback

				local Toggle = Instance.new("Frame")
				local UICorner = Instance.new("UICorner")
				local InsideToggle = Instance.new("Frame")
				local UIPadding = Instance.new("UIPadding")
				local UIListLayout = Instance.new("UIListLayout")
				local TitleTOgle = Instance.new("TextLabel")
				local DescTOgle = Instance.new("TextLabel")
				local GG = Instance.new("Frame")
				local UIPadding_2 = Instance.new("UIPadding")
				local TRUEE = Instance.new("ImageLabel")
				local clickopendropdown = click(Toggle)

				Toggle.Name = "Toggle"
				Toggle.Parent = Section
				Toggle.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
				Toggle.BorderColor3 = Color3.fromRGB(0, 0, 0)
				Toggle.BorderSizePixel = 0
				Toggle.Size = UDim2.new(0.97, 0, 0, 45)

				UICorner.Parent = Toggle
				UICorner.CornerRadius = UDim.new(0, 10)

				InsideToggle.Name = "InsideToggle"
				InsideToggle.Parent = Toggle
				InsideToggle.AnchorPoint = Vector2.new(0.5, 0.5)
				InsideToggle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				InsideToggle.BackgroundTransparency = 1
				InsideToggle.BorderColor3 = Color3.fromRGB(0, 0, 0)
				InsideToggle.BorderSizePixel = 0
				InsideToggle.Position = UDim2.new(0.5, 0, 0.5, 0)
				InsideToggle.Size = UDim2.new(1, 0, 1, 0)

				UIPadding.Parent = InsideToggle
				UIPadding.PaddingLeft = UDim.new(0, 12)

				UIListLayout.Parent = InsideToggle
				UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
				UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Center
				UIListLayout.Padding = UDim.new(0, 1)

				TitleTOgle.Name = "TitleTOgle"
				TitleTOgle.Parent = InsideToggle
				TitleTOgle.AnchorPoint = Vector2.new(0.5, 0.5)
				TitleTOgle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				TitleTOgle.BackgroundTransparency = 1
				TitleTOgle.BorderColor3 = Color3.fromRGB(0, 0, 0)
				TitleTOgle.BorderSizePixel = 0
				TitleTOgle.LayoutOrder = -4
				TitleTOgle.Position = UDim2.new(0.499830812, 0, 0.5, 0)
				TitleTOgle.Size = UDim2.new(0.650434852, 0, 0.300000012, 0)
				TitleTOgle.Font = Enum.Font.GothamSemibold
				TitleTOgle.Text = Title
				TitleTOgle.TextColor3 = Color3.fromRGB(255, 255, 255)
				TitleTOgle.TextSize = 12
				TitleTOgle.TextXAlignment = Enum.TextXAlignment.Left

				DescTOgle.Name = "DescTOgle"
				DescTOgle.Parent = InsideToggle
				DescTOgle.AnchorPoint = Vector2.new(0.5, 0.5)
				DescTOgle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				DescTOgle.BackgroundTransparency = 1
				DescTOgle.BorderColor3 = Color3.fromRGB(0, 0, 0)
				DescTOgle.BorderSizePixel = 0
				DescTOgle.LayoutOrder = -4
				DescTOgle.Position = UDim2.new(0.381251812, 0, 0.661111116, 0)
				DescTOgle.Size = UDim2.new(0.762503624, 0, 0.300000012, 0)
				DescTOgle.Font = Enum.Font.GothamMedium
				DescTOgle.TextTruncate = Enum.TextTruncate.AtEnd
				local function Update()
					if type(Value) == "table" then
						DescTOgle.Text = table.concat(Value, ", ")
					else
						DescTOgle.Text = tostring(Value)
					end
				end
				Update()
				DescTOgle.TextColor3 = Color3.fromRGB(134, 211, 255)
				DescTOgle.TextSize = 10
				DescTOgle.TextXAlignment = Enum.TextXAlignment.Left

             local UIGradient_1 = Instance.new("UIGradient")
             UIGradient_1.Parent = DescTOgle
             UIGradient_1.Color = ColorSequence.new{ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 255, 127)), ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 61, 29))}

				GG.Name = "GG"
				GG.Parent = Toggle
				GG.AnchorPoint = Vector2.new(0.5, 0.5)
				GG.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				GG.BackgroundTransparency = 1
				GG.BorderColor3 = Color3.fromRGB(0, 0, 0)
				GG.BorderSizePixel = 0
				GG.Position = UDim2.new(0.5, 0, 0.5, 0)
				GG.Size = UDim2.new(1, 0, 1, 0)

				UIPadding_2.Parent = GG
				UIPadding_2.PaddingBottom = UDim.new(0, 1)
				UIPadding_2.PaddingLeft = UDim.new(0, 1)
				UIPadding_2.PaddingRight = UDim.new(0, 1)
				UIPadding_2.PaddingTop = UDim.new(0, 1)

				TRUEE.Name = "TRUEE"
				TRUEE.Parent = GG
				TRUEE.AnchorPoint = Vector2.new(1, 0.5)
				TRUEE.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				TRUEE.BackgroundTransparency = 1
				TRUEE.BorderColor3 = Color3.fromRGB(0, 0, 0)
				TRUEE.BorderSizePixel = 0
				TRUEE.Position = UDim2.new(0.949999988, 0, 0.5, 0)
				TRUEE.Size = UDim2.new(0, 20, 0, 20)
				TRUEE.Image = "rbxassetid://129573215183311"

				local Dropdown = Instance.new("Frame")
				local DropShadow = Instance.new("ImageLabel")
				local UICorner = Instance.new("UICorner")
				local UIPadding = Instance.new("UIPadding")
				local SizeScrolling = Instance.new("Frame")
				local UIPadding_2 = Instance.new("UIPadding")
				local ScrollingFrame = Instance.new("ScrollingFrame")
				local UIListLayoutzz = Instance.new("UIListLayout")
				local SizeSearch = Instance.new("Frame")
				local UIPadding_3 = Instance.new("UIPadding")
				local Search = Instance.new("Frame")
				local UICorner_2 = Instance.new("UICorner")
				local TextBox = Instance.new("TextBox")

				local StartAutoSide = Autoside(Toggle)

				Dropdown.Name = "Dropdown"
				Dropdown.Parent = Background
				Dropdown.AnchorPoint = Vector2.new(StartAutoSide, 0.5)
				Dropdown.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
				Dropdown.BorderColor3 = Color3.fromRGB(0, 0, 0)
				Dropdown.BorderSizePixel = 0
				Dropdown.Position = UDim2.new(StartAutoSide, 0, 0.5, 0)
				Dropdown.Size = UDim2.new(0.5, 0, 1, 0)
				Dropdown.ZIndex = 3
				Dropdown.Visible = false

				local SK = Instance.new("UIStroke", Dropdown)
				SK.Color = Color3.fromRGB(25, 25, 25)
				SK.Thickness = 1

				DropShadow.Name = "DropShadow"
				DropShadow.Parent = Dropdown
				DropShadow.AnchorPoint = Vector2.new(0.5, 0.5)
				DropShadow.BackgroundColor3 = Color3.fromRGB(28, 28, 30)
				DropShadow.BackgroundTransparency = 1
				DropShadow.BorderColor3 = Color3.fromRGB(0, 0, 0)
				DropShadow.BorderSizePixel = 0
				DropShadow.Position = UDim2.new(0.5, 0, 0.5, 0)
				DropShadow.Size = UDim2.new(1, 120, 1, 120)
				DropShadow.ZIndex = 2
				DropShadow.Image = "rbxassetid://8992230677"
				DropShadow.ImageColor3 = Color3.fromRGB(18, 18, 18)
				DropShadow.ImageTransparency = 0.5
				DropShadow.ScaleType = Enum.ScaleType.Slice
				DropShadow.SliceCenter = Rect.new(100, 100, 100, 100)

				UICorner.Parent = Dropdown

				UIPadding.Parent = Dropdown
				UIPadding.PaddingBottom = UDim.new(0, 1)
				UIPadding.PaddingLeft = UDim.new(0, 1)
				UIPadding.PaddingRight = UDim.new(0, 1)
				UIPadding.PaddingTop = UDim.new(0, 1)

				SizeScrolling.Name = "SizeScrolling"
				SizeScrolling.Parent = Dropdown
				SizeScrolling.AnchorPoint = Vector2.new(0.5, 0.5)
				SizeScrolling.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				SizeScrolling.BackgroundTransparency = 1
				SizeScrolling.BorderColor3 = Color3.fromRGB(0, 0, 0)
				SizeScrolling.BorderSizePixel = 0
				SizeScrolling.Position = UDim2.new(0.5, 0, 0.49856323, 0)
				SizeScrolling.Size = UDim2.new(1, 0, 1.00287342, 0)
				SizeScrolling.ZIndex = 3

				UIPadding_2.Parent = SizeScrolling
				UIPadding_2.PaddingBottom = UDim.new(0, 1)
				UIPadding_2.PaddingLeft = UDim.new(0, 1)
				UIPadding_2.PaddingRight = UDim.new(0, 1)
				UIPadding_2.PaddingTop = UDim.new(0, 45)

				ScrollingFrame.Parent = SizeScrolling
				ScrollingFrame.Active = true
				ScrollingFrame.AnchorPoint = Vector2.new(0.5, 0)
				ScrollingFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				ScrollingFrame.BackgroundTransparency = 1
				ScrollingFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
				ScrollingFrame.BorderSizePixel = 0
				ScrollingFrame.Position = UDim2.new(0.5, 0, 0, 0)
				ScrollingFrame.Size = UDim2.new(0.899999976, 0, 1, 0)
				ScrollingFrame.ZIndex = 3
				ScrollingFrame.ScrollBarThickness = 0

				Canvas_Y(UIListLayoutzz, ScrollingFrame, 20)

				UIListLayoutzz.Parent = ScrollingFrame
				UIListLayoutzz.SortOrder = Enum.SortOrder.LayoutOrder
				UIListLayoutzz.Padding = UDim.new(0, 5)

				SizeSearch.Name = "SizeSearch"
				SizeSearch.Parent = Dropdown
				SizeSearch.AnchorPoint = Vector2.new(0.5, 0.5)
				SizeSearch.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				SizeSearch.BackgroundTransparency = 1
				SizeSearch.BorderColor3 = Color3.fromRGB(0, 0, 0)
				SizeSearch.BorderSizePixel = 0
				SizeSearch.Position = UDim2.new(0.5, 0, 0.5, 0)
				SizeSearch.Size = UDim2.new(1, 0, 1, 0)
				SizeSearch.ZIndex = 3

				UIPadding_3.Parent = SizeSearch
				UIPadding_3.PaddingBottom = UDim.new(0, 1)
				UIPadding_3.PaddingLeft = UDim.new(0, 1)
				UIPadding_3.PaddingRight = UDim.new(0, 1)
				UIPadding_3.PaddingTop = UDim.new(0, 10)

				Search.Name = "Search"
				Search.Parent = SizeSearch
				Search.AnchorPoint = Vector2.new(0.5, 0)
				Search.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
				Search.BackgroundTransparency = 0.5
				Search.BorderColor3 = Color3.fromRGB(0, 0, 0)
				Search.BorderSizePixel = 0
				Search.Position = UDim2.new(0.5, 0, 0, 0)
				Search.Size = UDim2.new(0.920000017, 0, 0, 25)
				Search.ZIndex = 3

				local SK2 = Instance.new("UIStroke", Search)
				SK2.Color = Color3.fromRGB(255, 255, 255)
				SK2.Thickness = 1
				SK2.Transparency = 0.8

				UICorner_2.Parent = Search
				UICorner_2.CornerRadius = UDim.new(1, 0)

				TextBox.Parent = Search
				TextBox.AnchorPoint = Vector2.new(0.5, 0.5)
				TextBox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				TextBox.BackgroundTransparency = 1
				TextBox.BorderColor3 = Color3.fromRGB(0, 0, 0)
				TextBox.BorderSizePixel = 0
				TextBox.Position = UDim2.new(0.5, 0, 0.5, 0)
				TextBox.Size = UDim2.new(1, 0, 1, 0)
				TextBox.ZIndex = 3
				TextBox.Font = Enum.Font.GothamMedium
				TextBox.PlaceholderText = "Search"
				TextBox.Text = ""
				TextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
				TextBox.TextSize = 14

				local isOpen = false
				UserInputService.InputBegan:Connect(function(A)
					if A.UserInputType == Enum.UserInputType.MouseButton1 or A.UserInputType == Enum.UserInputType.Touch then
						local mouse = game:GetService("Players").LocalPlayer:GetMouse()
						local mx, my = mouse.X, mouse.Y

						local DBP, DBS = Dropdown.AbsolutePosition, Dropdown.AbsoluteSize
						local TBP, TBS = TextBox.AbsolutePosition, TextBox.AbsoluteSize
						local SBP, SBS = Search.AbsolutePosition, Search.AbsoluteSize

						local function inside(pos, size)
							return mx >= pos.X and mx <= pos.X + size.X and my >= pos.Y and my <= pos.Y + size.Y
						end

						if not inside(DBP, DBS)
							and not inside(TBP, TBS)
							and not inside(SBP, SBS) then
							isOpen = false
							Dropdown.Size = UDim2.new(0, 0, 1, 0)
							Dropdown.Visible = false
						end
					end
				end)

				clickopendropdown.MouseButton1Click:Connect(function()
					for _, v in pairs(Background:GetChildren()) do
						if (v.Name == "Dropdown" and v.Visible) or v.Name == "Window" then
							return
						end
					end
					isOpen = not isOpen
					if isOpen then
						Dropdown.Visible = true
						tw({
							v = Dropdown,
							t = 0.3,
							s = "Back",
							d = "Out",
							g = {Size = UDim2.new(0.5, 0, 1, 0)}
						}):Play()
					else
						tw({
							v = Dropdown,
							t = 0.3,
							s = "Back",
							d = "Out",
							g = {Size = UDim2.new(0, 0, 1, 0)}
						}):Play()
						delay(0.15, function()
							Dropdown.Visible = false
						end)
					end
					tw({
						v = TRUEE,
						t = 0.15,
						s = "Bounce",
						d = "Out",
						g = {Size = UDim2.new(0, 40,0, 40)}
					}):Play()
					delay(0.06, function()
						tw({
							v = TRUEE,
							t = 0.15,
							s = "Bounce",
							d = "Out",
							g = {Size = UDim2.new(0, 20,0, 20)}
						}):Play()
					end)
				end)

				TextBox.Changed:Connect(function()
					local SearchT = string.lower(TextBox.Text)
					for i, v in pairs(ScrollingFrame:GetChildren()) do
						if v:IsA("Frame") then
							local labelText = string.lower(v.Real.Title.Text)
							if string.find(labelText, SearchT, 1, true) then
								v.Visible = true
							else
								v.Visible = false
							end
						end
					end
				end)

				local itemslist = {}
				local selectedItem

				function itemslist:Clear(a)
					local function shouldClear(v)
						if a == nil then
							return true
						elseif type(a) == "string" then
							return v.Real:FindFirstChild("Title") and v.Real.Title.Text == a
						elseif type(a) == "table" then
							for _, name in ipairs(a) do
								if v.Real:FindFirstChild("Title") and v.Real.Title.Text == name then
									return true
								end
							end
						end
						return false
					end

					for _, v in ipairs(ScrollingFrame:GetChildren()) do
						if v:IsA("Frame") and shouldClear(v) then
							if selectedItem and v.Real:FindFirstChild("Title") and v.Real.Title.Text == selectedItem then
								selectedItem = nil
								DescTOgle.Text = "N/A"
							end
							v:Destroy()
						end
					end

					if selectedItem == a or DescTOgle.Text == a then
						selectedItem = nil
						DescTOgle.Text = "N/A"
					end

					if a == nil then
						selectedItem = nil
						DescTOgle.Text = "N/A"
					end
				end

				local selectedValues = {}

				local function isValueInTable(val, tbl)
					if type(tbl) ~= "table" then
						return false
					end

					for _, v in pairs(tbl) do
						if v == val then
							return true
						end
					end
					return false
				end

				function itemslist:AddList(text)
					local Items_1 = Instance.new("Frame")
					local Real_1 = Instance.new("Frame")
					local Title_1 = Instance.new("TextLabel")
					local Line_1 = Instance.new("Frame")
					local UICorner_2 = Instance.new("UICorner")
					local UIListLayout_2 = Instance.new("UIListLayout")
					local ClickList = click(Items_1)

					Items_1.Name = "Items"
					Items_1.Parent = ScrollingFrame
					Items_1.BackgroundColor3 = Color3.fromRGB(255,255,255)
					Items_1.BackgroundTransparency = 1
					Items_1.BorderColor3 = Color3.fromRGB(0,0,0)
					Items_1.BorderSizePixel = 0
					Items_1.Size = UDim2.new(1, 0,0, 30)
					Items_1.ZIndex = 3

					Real_1.Name = "Real"
					Real_1.Parent = Items_1
					Real_1.AnchorPoint = Vector2.new(0.5, 0.5)
					Real_1.BackgroundColor3 = Color3.fromRGB(255,255,255)
					Real_1.BackgroundTransparency = 1
					Real_1.BorderColor3 = Color3.fromRGB(0,0,0)
					Real_1.BorderSizePixel = 0
					Real_1.Position = UDim2.new(0.5, 0,0.5, 0)
					Real_1.Size = UDim2.new(1, 0,1, 0)
					Real_1.ZIndex = 3

					Title_1.Name = "Title"
					Title_1.Parent = Real_1
					Title_1.AnchorPoint = Vector2.new(0.5, 0.5)
					Title_1.BackgroundColor3 = Color3.fromRGB(255,255,255)
					Title_1.BackgroundTransparency = 1
					Title_1.BorderColor3 = Color3.fromRGB(0,0,0)
					Title_1.BorderSizePixel = 0
					Title_1.LayoutOrder = -1
					Title_1.Position = UDim2.new(0.57476455, 0,0.5, 0)
					Title_1.Size = UDim2.new(0.660639942, 0,1, 0)
					Title_1.ZIndex = 3
					Title_1.Font = Enum.Font.GothamSemibold
					Title_1.Text = text
					Title_1.TextColor3 = Color3.fromRGB(255,255,255)
					Title_1.TextSize = 14
					Title_1.TextXAlignment = Enum.TextXAlignment.Left
					Title_1.TextTransparency = 0.5

					Line_1.Name = "Line"
					Line_1.Parent = Real_1
					Line_1.AnchorPoint = Vector2.new(0, 0.5)
					Line_1.BackgroundColor3 = Color3.fromRGB(134, 211, 255)
					Line_1.BorderColor3 = Color3.fromRGB(0,0,0)
					Line_1.BorderSizePixel = 0
					Line_1.LayoutOrder = -3
					Line_1.Position = UDim2.new(0, 0,0.5, 0)
					Line_1.Size = UDim2.new(0, 5,1, 0)
					Line_1.ZIndex = 3
					Line_1.BackgroundTransparency = 1

               local UIGradient_1 = Instance.new("UIGradient")
               UIGradient_1.Parent = Line_1
               UIGradient_1.Color = ColorSequence.new{ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 255, 127)), ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 61, 29))}

					UICorner_2.Parent = Line_1
					UICorner_2.CornerRadius = UDim.new(1,0)

					UIListLayout_2.Parent = Real_1
					UIListLayout_2.Padding = UDim.new(0,10)
					UIListLayout_2.FillDirection = Enum.FillDirection.Horizontal
					UIListLayout_2.SortOrder = Enum.SortOrder.LayoutOrder
					UIListLayout_2.VerticalAlignment = Enum.VerticalAlignment.Center

					ClickList.MouseButton1Click:Connect(function()
						Update()
						if Multi then
							if selectedValues[text] then
								selectedValues[text] = nil
								tw({
									v = Title_1,
									t = 0.15,
									s = "Exponential",
									d = "Out",
									g = {TextTransparency = 0.5}
								}):Play()
								tw({
									v = Line_1,
									t = 0.15,
									s = "Exponential",
									d = "Out",
									g = {BackgroundTransparency = 1}
								}):Play()
								tw({
									v = Items_1,
									t = 0.15,
									s = "Exponential",
									d = "Out",
									g = {BackgroundTransparency = 1}
								}):Play()
							else
								selectedValues[text] = true
								tw({
									v = Title_1,
									t = 0.15,
									s = "Exponential",
									d = "Out",
									g = {TextTransparency = 0}
								}):Play()
								tw({
									v = Line_1,
									t = 0.15,
									s = "Exponential",
									d = "Out",
									g = {BackgroundTransparency = 0}
								}):Play()
								tw({
									v = Items_1,
									t = 0.15,
									s = "Exponential",
									d = "Out",
									g = {BackgroundTransparency = 0.9}
								}):Play()
							end
							local selectedList = {}
							for i, v in pairs(selectedValues) do
								table.insert(selectedList, i)
							end
							if #selectedList > 0 then
								Value = selectedList
								Update()
							else
								DescTOgle.Text = "N/A"
							end
							pcall(Callback, selectedList)
						else
							for i,v in pairs(ScrollingFrame:GetChildren()) do
								if v:IsA("Frame") then
									tw({
										v = v.Real.Title,
										t = 0.15,
										s = "Exponential",
										d = "Out",
										g = {TextTransparency = 0.5}
									}):Play()
									tw({
										v = v.Real.Line,
										t = 0.15,
										s = "Exponential",
										d = "Out",
										g = {BackgroundTransparency = 1}
									}):Play()
									tw({
										v = v,
										t = 0.15,
										s = "Exponential",
										d = "Out",
										g = {BackgroundTransparency = 1}
									}):Play()
								end
							end

							tw({
								v = Title_1,
								t = 0.15,
								s = "Exponential",
								d = "Out",
								g = {TextTransparency = 0}
							}):Play()
							tw({
								v = Line_1,
								t = 0.15,
								s = "Exponential",
								d = "Out",
								g = {BackgroundTransparency = 0}
							}):Play()
							tw({
								v = Items_1,
								t = 0.15,
								s = "Exponential",
								d = "Out",
								g = {BackgroundTransparency = 0.9}
							}):Play()
							tw({
								v = Dropdown,
								t = 0.3,
								s = "Bounce",
								d = "Out",
								g = {Size = UDim2.new(0.5, 0,1, 0)}
							}):Play()
							isOpen = false
							Value = text
							DescTOgle.Text = text
							pcall(function()
								Callback(DescTOgle.Text)
							end)
						end
					end)

					delay(0,function()
						if Multi then
							if isValueInTable(text, Value) then
								tw({
									v = Title_1,
									t = 0.15,
									s = "Exponential",
									d = "Out",
									g = {TextTransparency = 0}
								}):Play()
								tw({
									v = Line_1,
									t = 0.15,
									s = "Exponential",
									d = "Out",
									g = {BackgroundTransparency = 0}
								}):Play()
								tw({
									v = Items_1,
									t = 0.15,
									s = "Exponential",
									d = "Out",
									g = {BackgroundTransparency = 0.9}
								}):Play()
								selectedValues[text] = true
								local selectedList = {}
								for i, v in pairs(selectedValues) do
									table.insert(selectedList, i)
								end
								if #selectedList > 0 then
									Update()
								else
									DescTOgle.Text = "N/A"
								end
								pcall(Callback, selectedList)
							end
						else
							if text == Value then
								tw({
									v = Title_1,
									t = 0.15,
									s = "Exponential",
									d = "Out",
									g = {TextTransparency = 0}
								}):Play()
								tw({
									v = Line_1,
									t = 0.15,
									s = "Exponential",
									d = "Out",
									g = {BackgroundTransparency = 0}
								}):Play()
								tw({
									v = Items_1,
									t = 0.15,
									s = "Exponential",
									d = "Out",
									g = {BackgroundTransparency = 0.9}
								}):Play()
								Value = text
								DescTOgle.Text = text
								Callback(DescTOgle.Text)
							end
						end
					end)
				end

				for _, name in ipairs(List) do
					itemslist:AddList(name)
				end

				return itemslist
			end

			function Class:Slider(info)

				local Title = info.Title
				local Min = info.Min or 0
				local Max = info.Max or 100
				local Rounding = info.Rounding or 0
				local Value = info.Value or Min
				local Callback = info.CallBack or function() end

				local Toggle = Instance.new("Frame")
				local UICorner = Instance.new("UICorner")
				local InsideToggle = Instance.new("Frame")
				local UIPadding = Instance.new("UIPadding")
				local TitleTOgle = Instance.new("TextLabel")
				local UIListLayout = Instance.new("UIListLayout")
				local Nocolor = Instance.new("Frame")
				local color = Instance.new("Frame")
				local UICorner_2 = Instance.new("UICorner")
				local Cirecle = Instance.new("Frame")
				local UICorner_3 = Instance.new("UICorner")
				local UICorner_4 = Instance.new("UICorner")
				local GG = Instance.new("Frame")
				local UIPadding_2 = Instance.new("UIPadding")
				local Box = Instance.new("Frame")
				local UICorner_5 = Instance.new("UICorner")
				local TextBox = Instance.new("TextBox")
				local Slide = click(Toggle)

				Toggle.Name = "Toggle"
				Toggle.Parent = Section
				Toggle.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
				Toggle.BorderColor3 = Color3.fromRGB(0, 0, 0)
				Toggle.BorderSizePixel = 0
				Toggle.Size = UDim2.new(0.97, 0, 0, 45)

				UICorner.Parent = Toggle
				UICorner.CornerRadius = UDim.new(0, 10)

				InsideToggle.Name = "InsideToggle"
				InsideToggle.Parent = Toggle
				InsideToggle.AnchorPoint = Vector2.new(0.5, 0.5)
				InsideToggle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				InsideToggle.BackgroundTransparency = 1
				InsideToggle.BorderColor3 = Color3.fromRGB(0, 0, 0)
				InsideToggle.BorderSizePixel = 0
				InsideToggle.Position = UDim2.new(0.5, 0, 0.5, 0)
				InsideToggle.Size = UDim2.new(1, 0, 1, 0)

				UIPadding.Parent = InsideToggle
				UIPadding.PaddingLeft = UDim.new(0, 12)

				TitleTOgle.Name = "TitleTOgle"
				TitleTOgle.Parent = InsideToggle
				TitleTOgle.AnchorPoint = Vector2.new(0.5, 0.5)
				TitleTOgle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				TitleTOgle.BackgroundTransparency = 1
				TitleTOgle.BorderColor3 = Color3.fromRGB(0, 0, 0)
				TitleTOgle.BorderSizePixel = 0
				TitleTOgle.LayoutOrder = -4
				TitleTOgle.Position = UDim2.new(0.325217485, 0, 0.53125, 0)
				TitleTOgle.Size = UDim2.new(0.649999976, 0, 0, 0)
				TitleTOgle.Font = Enum.Font.GothamSemibold
				TitleTOgle.Text = Title
				TitleTOgle.TextColor3 = Color3.fromRGB(255, 255, 255)
				TitleTOgle.TextSize = 12
				TitleTOgle.TextXAlignment = Enum.TextXAlignment.Left
				TitleTOgle.AutomaticSize = Enum.AutomaticSize.XY

				UIListLayout.Parent = InsideToggle
				UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
				UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Center
				UIListLayout.Padding = UDim.new(0, 5)

				Nocolor.Name = "Nocolor"
				Nocolor.Parent = InsideToggle
				Nocolor.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
				Nocolor.BorderColor3 = Color3.fromRGB(0, 0, 0)
				Nocolor.BorderSizePixel = 0
				Nocolor.Position = UDim2.new(0.0471943393, 0, 0.686046541, 0)
				Nocolor.Size = UDim2.new(0.949999988, 0, 0, 6)

				color.Name = "color"
				color.Parent = Nocolor
				color.AnchorPoint = Vector2.new(0, 0.5)
				color.BackgroundColor3 = Color3.fromRGB(134, 211, 255)
				color.BorderColor3 = Color3.fromRGB(0, 0, 0)
				color.BorderSizePixel = 0
				color.Position = UDim2.new(0, 0, 0.5, 0)
				color.Size = UDim2.new(0, 100, 1, 0)

            local UIGradient_1 = Instance.new("UIGradient")
            UIGradient_1.Parent = color
            UIGradient_1.Color = ColorSequence.new{ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 255, 127)), ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 61, 29))}

				UICorner_2.Parent = color
				UICorner_2.CornerRadius = UDim.new(1, 0)

				Cirecle.Name = "Cirecle"
				Cirecle.Parent = color
				Cirecle.AnchorPoint = Vector2.new(1, 0.5)
				Cirecle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				Cirecle.BorderColor3 = Color3.fromRGB(0, 0, 0)
				Cirecle.BorderSizePixel = 0
				Cirecle.Position = UDim2.new(1, 0, 0.5, 0)
				Cirecle.Size = UDim2.new(0, 10, 0, 10)

				UICorner_3.Parent = Cirecle
				UICorner_3.CornerRadius = UDim.new(1, 0)

				UICorner_4.Parent = Nocolor
				UICorner_4.CornerRadius = UDim.new(1, 0)

				GG.Name = "GG"
				GG.Parent = Toggle
				GG.AnchorPoint = Vector2.new(0.5, 0.5)
				GG.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				GG.BackgroundTransparency = 1
				GG.BorderColor3 = Color3.fromRGB(0, 0, 0)
				GG.BorderSizePixel = 0
				GG.Position = UDim2.new(0.5, 0, 0.5, 0)
				GG.Size = UDim2.new(1, 0, 1, 0)

				UIPadding_2.Parent = GG
				UIPadding_2.PaddingBottom = UDim.new(0, 1)
				UIPadding_2.PaddingLeft = UDim.new(0, 1)
				UIPadding_2.PaddingRight = UDim.new(0, 1)
				UIPadding_2.PaddingTop = UDim.new(0, 1)

				Box.Name = "Box"
				Box.Parent = GG
				Box.AnchorPoint = Vector2.new(1, 0)
				Box.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
				Box.BorderColor3 = Color3.fromRGB(0, 0, 0)
				Box.BorderSizePixel = 0
				Box.Position = UDim2.new(0.956435382, 0, 0.232558146, 0)
				Box.Size = UDim2.new(0, 28, 0, 12)

				UICorner_5.Parent = Box
				UICorner_5.CornerRadius = UDim.new(0, 10)

				TextBox.Parent = Box
				TextBox.AnchorPoint = Vector2.new(0.5, 0.5)
				TextBox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				TextBox.BackgroundTransparency = 1
				TextBox.BorderColor3 = Color3.fromRGB(0, 0, 0)
				TextBox.BorderSizePixel = 0
				TextBox.Position = UDim2.new(0.5, 0, 0.5, 0)
				TextBox.Size = UDim2.new(0.899999976, 0, 0.899999976, 0)
				TextBox.Font = Enum.Font.Gotham
				TextBox.Text = tostring(Value)
				TextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
				TextBox.TextSize = 9
				TextBox.ZIndex = Slide.ZIndex

				local function roundToDecimal(value, decimals)
					local factor = 10 ^ decimals
					return math.floor(value * factor + 0.5) / factor
				end

				local function updateSlider(value)
					value = math.clamp(value, Min, Max)
					value = roundToDecimal(value, Rounding)
					tw({
						v = color,
						t = 0.15,
						s = "Exponential",
						d = "Out",
						g = {Size = UDim2.new((value - Min) / (Max - Min), 0, 1, 0)}
					}):Play()
					local startValue = tonumber(TextBox.Text) or 0
					local targetValue = value

					local steps = 5
					local currentValue = startValue
					for i = 1, steps do
						task.wait(0.01 / steps)
						currentValue = currentValue + (targetValue - startValue) / steps
						TextBox.Text = tostring(roundToDecimal(currentValue, Rounding))
					end

					Box.Size = UDim2.new(0, TextBox.TextBounds.X + 15, 0, 12)
					TextBox.Text = tostring(roundToDecimal(targetValue, Rounding))

					Callback(value)
				end

				updateSlider(Value or 0)

				local function move(input)
					local sliderBar = Nocolor
					local relativeX = math.clamp((input.Position.X - sliderBar.AbsolutePosition.X) / sliderBar.AbsoluteSize.X, 0, 1)
					local value = relativeX * (Max - Min) + Min
					updateSlider(value)
				end

				TextBox.FocusLost:Connect(function()
					local value = tonumber(TextBox.Text) or Min
					updateSlider(value)
				end)

				local dragging = false

				Slide.InputBegan:Connect(function(input)
					for _, v in pairs(Background:GetChildren()) do
						if (v.Name == "Dropdown" and v.Visible) or v.Name == "Window" then
							return
						end
					end
					if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
						dragging = true
						move(input)
					end
				end)

				Slide.InputEnded:Connect(function(input)
					for _, v in pairs(Background:GetChildren()) do
						if (v.Name == "Dropdown" and v.Visible) or v.Name == "Window" then
							return
						end
					end
					if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
						dragging = false
					end
				end)

				UserInputService.InputChanged:Connect(function(input)
					for _, v in pairs(Background:GetChildren()) do
						if (v.Name == "Dropdown" and v.Visible) or v.Name == "Window" then
							return
						end
					end
					if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
						move(input)
					end
				end)
			end

			function Class:Textbox(meta)

				local Value = meta.Value or "Example"
				local ClearOnFocus = meta.ClearOnFocus or false
				local Callback = meta.Callback

				local Textbox = Instance.new("Frame")
				local UICorner_1 = Instance.new("UICorner")
				local Val_1 = Instance.new("TextBox")

				Textbox.Name = "Textbox"
				Textbox.Parent = Section
				Textbox.BackgroundColor3 = Color3.fromRGB(20,20,20)
				Textbox.BackgroundTransparency = 0
				Textbox.BorderColor3 = Color3.fromRGB(0,0,0)
				Textbox.BorderSizePixel = 0
				Textbox.Size = UDim2.new(0.97, 0,0, 25)

				UICorner_1.Parent = Textbox
				UICorner_1.CornerRadius = UDim.new(0,10)

				Val_1.Name = "Val"
				Val_1.Parent = Textbox
				Val_1.Active = true
				Val_1.AnchorPoint = Vector2.new(0.5, 0.5)
				Val_1.BackgroundColor3 = Color3.fromRGB(255,255,255)
				Val_1.BackgroundTransparency = 1
				Val_1.BorderColor3 = Color3.fromRGB(0,0,0)
				Val_1.BorderSizePixel = 0
				Val_1.CursorPosition = -1
				Val_1.Position = UDim2.new(0.5, 0,0.5, 0)
				Val_1.Size = UDim2.new(0.899999976, 0,0.899999976, 0)
				Val_1.Font = Enum.Font.Gotham
				Val_1.PlaceholderColor3 = Color3.fromRGB(178,178,178)
				Val_1.PlaceholderText = "..."
				Val_1.Text = tostring(Value)
				Val_1.TextColor3 = Color3.fromRGB(255,255,255)
				Val_1.TextSize = 10
				Val_1.TextTruncate = Enum.TextTruncate.AtEnd
				Val_1.TextXAlignment = Enum.TextXAlignment.Center
				Val_1.ClearTextOnFocus = ClearOnFocus

				Val_1.FocusLost:Connect(function()
					if #Val_1.Text > 0 then
						pcall(Callback, Val_1.Text)
					end
				end)
			end

			function Class:Label(t, s)
				local Label = Instance.new("Frame")
				local UICorner_1 = Instance.new("UICorner")
				local Title_1 = Instance.new("TextLabel")

				Label.Name = "Label"
				Label.Parent = Section
				Label.BackgroundColor3 = Color3.fromRGB(255,255,255)
				Label.BackgroundTransparency = 1
				Label.BorderColor3 = Color3.fromRGB(0,0,0)
				Label.BorderSizePixel = 0
				Label.Size = UDim2.new(0.9, 0,0, 16)

				UICorner_1.Parent = Label
				UICorner_1.CornerRadius = UDim.new(0,3)

				Title_1.Name = "Title"
				Title_1.Parent = Label
				Title_1.AnchorPoint = Vector2.new(0.5, 0.5)
				Title_1.BackgroundColor3 = Color3.fromRGB(255,255,255)
				Title_1.BackgroundTransparency = 1
				Title_1.BorderColor3 = Color3.fromRGB(0,0,0)
				Title_1.BorderSizePixel = 0
				Title_1.LayoutOrder = 1
				Title_1.Position = UDim2.new(0.5, 0,0.5, 0)
				Title_1.Size = UDim2.new(1, 0,0, 10)
				Title_1.Font = Enum.Font.GothamSemibold
				Title_1.RichText = true
				Title_1.Text = t
				Title_1.TextColor3 = Color3.fromRGB(255,255,255)
				Title_1.TextSize = 11
				Title_1.TextWrapped = true
				Title_1.TextXAlignment = (s == "l" and Enum.TextXAlignment.Left) or (s == "r" and Enum.TextXAlignment.Right) or (s == "c" and Enum.TextXAlignment.Center) or Enum.TextXAlignment.Center

				return Title_1
			end

			function Class:Line()
				local Line = Instance.new("Frame")
				Line.Name = "Line"
				Line.Parent = Section
				Line.BackgroundColor3 = Color3.fromRGB(255,255,255)
				Line.BackgroundTransparency = 0.949999988079071
				Line.BorderColor3 = Color3.fromRGB(0,0,0)
				Line.BorderSizePixel = 0
				Line.Position = UDim2.new(0, 0,0, 44)
				Line.Size = UDim2.new(1, 0,0, 1)
			end
			return Class
		end
		return Section
	end
	return Tabs
end

return Library
