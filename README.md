# FluentModify

A modified version of the [Fluent](https://github.com/dawid-scripts/Fluent) UI library for Roblox, extended with extra themes,multi-pack icon support, and quality-of-life improvements.

---

## Quick Start

```lua
local Fluent = loadstring(game:HttpGet("https://github.com/justmoon56/FluentModify/releases/download/Testing/FluentModify.lua"))()

local Window = Fluent:CreateWindow({
    Title       = "My Hub",
    SubTitle    = "by me",
    TabWidth    = 160,
    Size        = UDim2.fromOffset(500, 480),
    Acrylic     = true,
    Theme       = "Deep Ocean",
    MinimizeKey = Enum.KeyCode.LeftControl,
    Search      = true,
})

local Tab = Window:AddTab({ Title = "Main", Icon = "solar/home-bold" })
```

- Global Tabs
```lua
local Tabs =  {
    Main = Window:AddTab({ Title = "| Main", Icon = "solar/home-bold }),
    Elements = Window:AddTab({ Title "| Elements", Icon = "rbxassetid://123456789"))()
}

Tabs.Main:AddParagraph({
    Title = "Text",
    Content = "Text"
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



```lua
-- Usage example
Tab:AddButton({ Title = "Home", Icon = "solar/home-bold", Callback = function() end })
Tab:AddButton({ Title = "Archive", Icon = "gravity/archive", Callback = function() end })
```

---

## SaveManager & InterfaceManager

```lua
SaveManager:SetLibrary(Fluent)
InterfaceManager:SetLibrary(Fluent)

InterfaceManager:SetFolder("MyHub")
SaveManager:SetFolder("MyHub/Config")

InterfaceManager:BuildInterfaceSection(SettingsTab)
SaveManager:BuildConfigSection(SettingsTab)

SaveManager:IgnoreThemeSettings()
SaveManager:LoadAutoloadConfig()
```

---

## License

MIT - see the original [Fluent repository](https://github.com/dawid-scripts/Fluent) for license details.

---

## Credits

- [dawid-scripts/Fluent](https://github.com/dawid-scripts/Fluent) - original library

## Contributors

- **justmoon56** - main dev
