# FluentModify

A modified version of the [Fluent](https://github.com/dawid-scripts/Fluent) UI library for Roblox, extended with extra themes,multi-pack icon support, and quality-of-life improvements.

---

## Quick Start

```lua
loadstring(game:HttpGet("https://github.com/justmoon56/FluentModify/releases/download/V1.4.1/FluentModify.lua"))()

local Window = Fluent:CreateWindow({
    Title = "My Hub",
    SubTitle = "by me",
    TabWidth = 160,
    Size = UDim2.fromOffset(500, 480),
    Acrylic = true,
    Theme = "Darker",
    MinimizeKey = Enum.KeyCode.LeftControl,
    Search = true,

    Icons = "rbxassetid://"
    TitleIcon = "rbxassetid://"
})
```

If you have created a window, then we can immediately create tabs, you can do like this

## Tabs
```lua
local Tabs =  {
    Main = Window:AddTab({ Title = "| Main", Icon = "rbxassetid://123456789"))(),
    Elements = Window:AddTab({ Title = "| Elements", Icon = "activity" })
}
```

---

## Create Elements
```lua
local group = Tabs.Elements:AddGroup("Display", { Columns = 2, Gap = 8 })
local colLeft = group:AddElement()
local colRight = group:AddElement()

colLeft:AddImageButton({
    AspectRatio = "1:1",
    Image = "rbxassetid://138612651588256", -- rbxassetid, and Https
    Title = "Apply",
    Description = "Trigger the Button to Apply",
    Callback = function()
        Fluent:Notify({
            Title = "Success",
            Content = "Trigger Successfully",
            Type = "Success",
            Icon = nil,
            Duration = 2
        })
    end
})

colRight:AddImageButton({
    AspectRatio = "1:1",
    Image = "https://i.pinimg.com/736x/56/42/4a/56424a41330f0f66cb0b88862ac13079.jpg", -- rbxassetid, and Https
    Title = "Apply",
    Description = "Trigger the Button to Apply",
    Callback = function()
        Fluent:Notify({
            Title = "Success",
            Content = "Trigger Successfully",
            Type = "Success",
            Icon = nil,
            Duration = 2
        })
    end
})
```

---
## Elements

All elements are added via `Tab:AddElementType(id, config)`.

| Method | Description |
|---|---|
| `AddToggle` | On/off switch |
| `AddSlider` | Numeric range slider |
| `AddInput` | Text input box |
| `AddDropdown` | Single or multi-select dropdown |
| `AddColorpicker` | Color picker with transparency |
| `AddKeybind` | Keyboard/mouse keybind |
| `AddButton` | Clickable button |
| `AddParagraph` | Read-only text block |
| `AddDiscord` | Shows Discord server profile |
| `AddImage` | Shows an Image |
| `AddVudeo` | Shows an Video |
| `AddViewport` | 3D view |
| `AddGroup` | Make all elements separate left and right |
| `AddImageButton` | Clickable image in AddGroup |



---

## SaveManager & InterfaceManager

```lua
SaveManager:SetLibrary(Fluent)
InterfaceManager:SetLibrary(Fluent)
FBM:SetLibrary(Fluent)

SaveManager:SetIgnoreIndexes({})

-- Save Folder
InterfaceManager:SetFolder("MyHub")
FBM:SetFolder("MyHub/FloatingButtons")
SaveManager:SetFolder("MyHub")

InterfaceManager:BuildInterfaceSection(Tabs.Settings)
FBM:BuildConfigSection(Tabs.Settings)
SaveManager:BuildConfigSection(Tabs.Settings)

MediaManager:SetFolder("MyMediaManager/MediaCache")

Window:SelectTab(1)

-- Auto Load Configuration
SaveManager:LoadAutoloadConfig()
```

---

## License

MIT - see the original [Fluent repository](https://github.com/dawid-scripts/Fluent) for license details.

---

## Credits

- [dawid-scripts/Fluent](https://github.com/dawid-scripts/Fluent) - original library
- [Fluent-Modded/FluentPro](https://github.com/StyearX/Fluent-modded) - logic

## Contributors

- **justmoon56** - main dev
- **StyearX**
