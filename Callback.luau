local _Env = getgenv()
_Env.Config = {}
_Env.Func = {}

repeat 
	task.wait()
until game:IsLoaded() and game:GetService("Players") and game:GetService("Players").LocalPlayer and workspace

local function SaveConfig()
	local path = "Quertzy'Script/Config/"..game.Players.LocalPlayer.UserId
	local file = path.."/"..game.PlaceId..".json"
	if not isfolder("Quertzy'Script") then makefolder("Quertzy'Script") end
	if not isfolder("Quertzy'Script/Config") then makefolder("Quertzy'Script/Config") end
	if not isfolder(path) then makefolder(path) end
	writefile(file, game:GetService("HttpService"):JSONEncode(_Env.Config))
end

local function LoadConfig()
	local path = "Quertzy'Script/Config/"..game.Players.LocalPlayer.UserId
	local file = path.."/"..game.PlaceId..".json"
	if isfile(file) then
		local data = readfile(file)
		local ok, result = pcall(function() 
			return game:GetService("HttpService"):JSONDecode(data) 
		end)
		if ok and type(result) == "table" then
			_Env.Config = result
		end
	end
end

local function Language(English, Thai)
    return _Env.Config["Language"] == "ไทย" and Thai or English
end

local DeleteFolder = Instance.new("BindableFunction")
DeleteFolder.OnInvoke = function(v)
    if v == "Yes" then
        local path = "Quertzy'Script/Config/"..game.Players.LocalPlayer.UserId
        if isfolder(path) then
            delfolder(path)
            game:GetService("TeleportService"):Teleport(game.PlaceId, game.Players.LocalPlayer)
        end
    end
end

local function Default(key, value)
	if _Env.Config[key] == nil then
		_Env.Config[key] = value
	end
end

Default("Language", "English")
LoadConfig()

function _Env._Loop(func)
	task.spawn(function()
		while task.wait() do
			xpcall(func, warn)
		end
	end)
end

function _Env._Button(tab, title, key, callback)
	Default(key, false)
	return tab:Button({
		Title = title,
		Callback = function()
			if callback then callback() end
			_Env.Config[key] = true
			SaveConfig()
			if _Env.Func[key] then _Env.Func[key]() end
		end
	})
end

function _Env._Toggle(tab, title, key)
	Default(key, false)
	return tab:Toggle({
		Title = title,
		Value = _Env.Config[key],
		Callback = function(v)
			_Env.Config[key] = v
			SaveConfig()
			if _Env.Func[key] then _Env.Func[key]() end
		end
	})
end

function _Env._Slider(tab, title, min, max, key)
    tab:Slider({
        Title = title,
        Min = min,
        Max = max,
        Rounding = 0,
        Value = _Env.Config[key] or min,
        Callback = function(v)
            _Env.Config[key] = v
            SaveConfig()
        end
    })
end

function _Env._Dropdown(tab, title, list, multi, key)
	Default(key, multi and {} or list[1])
	return tab:Dropdown({
		Title = title,
		List = list,
		Value = _Env.Config[key],
		Multi = multi,
		Callback = function(v)
			_Env.Config[key] = v
			SaveConfig()
			if _Env.Func[key] then _Env.Func[key]() end
		end
	})
end

function _Env._Textbox(tab, title, key)
	Default(key, "")
	return tab:Textbox({
		Value = _Env.Config[key],
		ClearOnFocus = true,
		Callback = function(v)
			_Env.Config[key] = v
			SaveConfig()
			if _Env.Func[key] then _Env.Func[key]() end
		end
	})
end

function _Env._Notify(icon, title, text, dur, b1, b2, cb)
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Icon = icon,
        Title = title,
        Text = text,
        Duration = dur,
        Button1 = b1,
        Button2 = b2,
        Callback = cb
    })
end

_Env._Notify(
    "rbxassetid://122367415593848",
    Language("Quertzy Hub - Scripts", "Quertzy Hub - สคริปต์"),
    Language("Do you want to delete the workspace file?", "คุณต้องการลบไฟล์ Workspace หรือไม่?"),
    99999999,
    Language("Yes", "ยืนยัน"),
    Language("No", "ไม่"),
    DeleteFolder
)

Button   = _Env._Button
Toggle   = _Env._Toggle
Slider   = _Env._Slider
Dropdown = _Env._Dropdown
Textbox  = _Env._Textbox
Notify   = _Env._Notify
Loop     = _Env._Loop
