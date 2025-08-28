Notify = {}

local Quertzy = Instance.new("ScreenGui")
Patinum.Parent = game.CoreGui
Patinum.Name = "Quertzy"
Patinum.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
Patinum.ResetOnSpawn = false

local AUI = {}

AUI[1] = Instance.new("Frame", Quertzy)
AUI[1]["BorderSizePixel"] = 0
AUI[1]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255)
AUI[1]["AnchorPoint"] = Vector2.new(0.5, 1) 
AUI[1]["Size"] = UDim2.new(0, 25, 0, 309)
AUI[1]["Position"] = UDim2.new(0.9734, 0, 0.95, 0)
AUI[1]["BorderColor3"] = Color3.fromRGB(0, 0, 0)
AUI[1]["Name"] = [[NotificationList]]
AUI[1]["BackgroundTransparency"] = 1

AUI[2] = Instance.new("UIListLayout", AUI[1])
AUI[2]["HorizontalAlignment"] = Enum.HorizontalAlignment.Right
AUI[2]["Padding"] = UDim.new(0, 8)
AUI[2]["VerticalAlignment"] = Enum.VerticalAlignment.Bottom
AUI[2]["SortOrder"] = Enum.SortOrder.LayoutOrder

function Library:Notify(a)
	local Time = a.Time

	local notify = Instance.new("CanvasGroup", AUI[1])
	notify["BorderSizePixel"] = 0
	notify["BackgroundColor3"] = Color3.fromRGB(19, 19, 19)
	notify["Size"] = UDim2.new(0, 0, 0, 50)
	notify["BorderColor3"] = Color3.fromRGB(0, 0, 0)

	local UICorner = Instance.new("UICorner", notify)
	UICorner["CornerRadius"] = UDim.new(0, 9)

	local UIStroke = Instance.new("UIStroke", notify)
	UIStroke["Transparency"] = 0.6
	UIStroke["Color"] = Color3.fromRGB(15, 16, 17)

	local textList = Instance.new("Frame", notify)
	textList["BorderSizePixel"] = 0
	textList["BackgroundColor3"] = Color3.fromRGB(19, 19, 19)
	textList["Size"] = UDim2.new(1, 0, 1, 0)
	textList["BorderColor3"] = Color3.fromRGB(0, 0, 0)
	textList["Name"] = "TextList"

	local UIListLayout = Instance.new("UIListLayout", textList)
	UIListLayout["Padding"] = UDim.new(0, 8)
	UIListLayout["VerticalAlignment"] = Enum.VerticalAlignment.Center
	UIListLayout["SortOrder"] = Enum.SortOrder.LayoutOrder
	UIListLayout["FillDirection"] = Enum.FillDirection.Horizontal

	local textFrame = Instance.new("Frame", textList)
	textFrame["BorderSizePixel"] = 0
	textFrame["BackgroundColor3"] = Color3.fromRGB(19, 19, 19)
	textFrame["Size"] = UDim2.new(0, 154, 0, 50)
	textFrame["BorderColor3"] = Color3.fromRGB(0, 0, 0)
	textFrame["Name"] = "Text"
	textFrame["BackgroundTransparency"] = 1

	local title = Instance.new("TextLabel", textFrame)
	title["BorderSizePixel"] = 0
	title["TextXAlignment"] = Enum.TextXAlignment.Left
	title["BackgroundTransparency"] = 1
	title["TextSize"] = 13
	title["FontFace"] = Font.new([[rbxasset://fonts/families/GothamSSm.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal)
	title["TextColor3"] = Color3.fromRGB(255, 255, 255)
	title["Size"] = UDim2.new(0, 154, 0, 15)
	title["Text"] = a.Title
	title["Name"] = "Title"
	title["Position"] = UDim2.new(0, 0, 0.16, 0)

	local desc = Instance.new("TextLabel", textFrame)
	desc["BorderSizePixel"] = 0
	desc["TextXAlignment"] = Enum.TextXAlignment.Left
	desc["TextTransparency"] = 0
	desc["BackgroundTransparency"] = 1
	desc["TextSize"] = 11
	desc["FontFace"] = Font.new([[rbxasset://fonts/families/GothamSSm.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal)
	desc["TextColor3"] = Color3.fromRGB(200, 200, 200)
	desc["Size"] = UDim2.new(0, 154, 0, 15)
	desc["Text"] = a.Desc
	desc["Name"] = "Desc"
	desc["Position"] = UDim2.new(0, 0, 0.5, 0)

	local logo = Instance.new("Frame", textList)
	logo["BorderSizePixel"] = 0
	logo["BackgroundColor3"] = Color3.fromRGB(19, 19, 19)
	logo["Size"] = UDim2.new(0, 45, 0, 50)
	logo["BorderColor3"] = Color3.fromRGB(0, 0, 0)
	logo["Name"] = "Logo"
	logo["LayoutOrder"] = -1

	local logoStroke = Instance.new("UIStroke", logo)
	logoStroke["Transparency"] = 0.8
	logoStroke["Color"] = Color3.fromRGB(255, 255, 255)

	local logoImage = Instance.new("ImageLabel", logo)
	logoImage["BorderSizePixel"] = 0
	logoImage["BackgroundTransparency"] = 1
	logoImage["ImageTransparency"] = 0.2
	logoImage["ImageColor3"] = Color3.fromRGB(255, 255, 255)
	logoImage["AnchorPoint"] = Vector2.new(0.5, 0.5)
	logoImage["Image"] = [[rbxassetid://2790460444]]
	logoImage["Size"] = UDim2.new(0.8, 0, 0.65, 0)
	logoImage["Position"] = UDim2.new(0.5, 0, 0.5, 0)

	local timeBar = Instance.new("Frame", notify)
	timeBar["BorderSizePixel"] = 0
	timeBar["BackgroundColor3"] = Color3.fromRGB(255, 255, 255)
	timeBar["AnchorPoint"] = Vector2.new(0, 0.5)
	timeBar["Size"] = UDim2.new(1, 0, 0, 3)
	timeBar["Position"] = UDim2.new(0, 0, 0.9625, 0)
	timeBar["BorderColor3"] = Color3.fromRGB(0, 0, 0)
	timeBar["Name"] = "Time"

	local UIGradient_1 = Instance.new("UIGradient")
	UIGradient_1.Parent = timeBar
	UIGradient_1.Color = ColorSequence.new{
		ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 255, 127)),
		ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 61, 29))
	}

	local closeButton = Instance.new("TextButton", notify)
	closeButton["BorderSizePixel"] = 0
	closeButton["TextColor3"] = Color3.fromRGB(255, 255, 255)
	closeButton["BackgroundTransparency"] = 1
	closeButton["FontFace"] = Font.new([[rbxasset://fonts/families/GothamSSm.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal)
	closeButton["AnchorPoint"] = Vector2.new(0.5, 0.5)
	closeButton["Size"] = UDim2.new(0, 20, 0, 20)
	closeButton["Name"] = "Close"
	closeButton["Text"] = "×"
	closeButton["Position"] = UDim2.new(0.95, 0, 0.2, 0)

	local TweenService = game:GetService("TweenService")
	local function TweenS(instance, targetSize)
		local tween = TweenService:Create(instance, TweenInfo.new(0.5, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), { Size = targetSize })
		tween:Play()
		return tween
	end

	TweenS(notify, UDim2.new(0, 250, 0, 50))

	task.spawn(function()
		local totalDuration = Time
		while Time > 0 do
			wait(1)
			Time = Time - 1
			local targetSize = UDim2.new(Time / totalDuration, 0, 0, 3)
			TweenS(timeBar, targetSize)
		end
		wait(.2)
		TweenS(notify, UDim2.new(0, 0, 0, 50))
		wait(.5)
		notify:Destroy()
	end)

	closeButton.MouseButton1Click:Connect(function()
		TweenS(timeBar, UDim2.new(0, 0, 0, 3))
		Time = 0
	end)
end

return Notify
