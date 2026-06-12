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

---
## StyearX Elements

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
| `AddCode` | Copy Button |
| `AddSpace` | Space|
| `AddGroup` | Group other element|
| `Addimage` | image in Window support httpGet and rbxassetid |
| `AddDivider` | divider|
| `AddVideo` | Video In window Supported rbxassetid|
| `AddAudio` | Audio In window Supported httpGet /http url and rbxassetid|




## Custom Themes

Register a custom theme before calling `CreateWindow`.

```lua
Fluent:RegisterCustomTheme("MyTheme", {
    Accent      = Color3.fromRGB(96, 205, 255),
    AcrylicMain = Color3.fromRGB(20, 20, 30),
    Text        = Color3.fromRGB(240, 240, 255),
    -- ... (see built-in themes for all fields)
    IconColor   = Color3.fromRGB(96, 205, 255), -- tint all icons
    IconSize    = 18,                            -- icon size in px
})

-- Switch theme at runtime
Fluent:SetTheme("MyTheme")
```

### Built-in Themes

`AMOLED` - `Ash Gray` - `Red` - `Cyanic` - `Amber Glow` - `Deep Violet` - `Neon Cyber` - `Neon Purple` - `Royal Blue` - `Deep Ocean` - `RGB` - `Orange` - `Charcoal` - `Pearl White` - `Midnight Blue` - `Galaxy Purple` - `Cosmic Violet` - `Cotton Candy`

---

## Icon Packs

All icon packs are loaded on demand. Use the `prefix/icon-name` format anywhere an `Icon` property is accepted.

| Pack | Prefix | Repository |
|---|---|---|
| Solar | `solar/` | https://github.com/StyearX/Icons/tree/main/solar |
| Gravity | `gravity/` | https://github.com/StyearX/Icons/tree/main/gravity |
| Lucide | `lucide/` | https://github.com/StyearX/Icons/tree/main/lucide |
| Craft | `craft/` | https://github.com/StyearX/Icons/tree/main/craft |
| Geist | `geist/` | https://github.com/StyearX/Icons/tree/main/geist |
| SF Symbols | `sfsymbols/` | https://github.com/StyearX/Icons/tree/main/sfsymbols |
| Heroicons | `hero/` | https://github.com/StyearX/Icons/blob/main/hero |
| Google Material Icons| `gmi/` | https://github.com/StyearX/Icons/blob/main/GoogleMaterialIcons |


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

MIT â€„1¤7 see the original [Fluent repository](https://github.com/dawid-scripts/Fluent) for license details.

---

## Credits

- [dawid-scripts/Fluent](https://github.com/dawid-scripts/Fluent) - original library
- [richie0866/remote-spy](https://github.com/richie0866/remote-spy) - UI assets and code
- [violin-suzutsuki/LinoriaLib](https://github.com/violin-suzutsuki/LinoriaLib) - element code, save manager
- [7kayoh/Acrylic](https://github.com/7kayoh/Acrylic) - Lua acrylic blur port
- [Latte Softworks & Kotera](https://discord.gg/rMMByr4qas) - bundler

## Contributors

- **StyearX** - original FluentModded
