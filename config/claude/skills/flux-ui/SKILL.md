---
name: flux-ui
description: Flux UI component library for Livewire. Use when building UIs with Flux components like buttons, inputs, modals, tables, forms, navigation, or any Livewire interface using the flux: Blade component prefix. Triggers include "Flux component", "flux:button", "flux:input", "Livewire UI components", or building admin/dashboard interfaces.
---

# Flux UI

Hand-crafted UI component library for Livewire applications, built with Tailwind CSS.

## Setup

```php
// Layout file
<head>
    @fluxAppearance
</head>
<body>
    @fluxScripts
</body>
```

```css
/* resources/css/app.css */
@import 'tailwindcss';
@import '../../vendor/livewire/flux/dist/flux.css';
@custom-variant dark (&:where(.dark, .dark *));
```

## Core Components

### Buttons
```html
<flux:button>Default</flux:button>
<flux:button variant="primary">Primary</flux:button>
<flux:button variant="filled">Filled</flux:button>
<flux:button variant="danger">Danger</flux:button>
<flux:button variant="ghost">Ghost</flux:button>
<flux:button variant="subtle">Subtle</flux:button>

<!-- With icons -->
<flux:button icon="arrow-down-tray">Export</flux:button>
<flux:button icon:trailing="chevron-down">Open</flux:button>
<flux:button icon="x-mark" variant="subtle" />

<!-- Sizes -->
<flux:button size="sm">Small</flux:button>
<flux:button size="xs">Extra Small</flux:button>

<!-- Loading (automatic with wire:click) -->
<flux:button wire:click="save">Save</flux:button>

<!-- As link -->
<flux:button href="/dashboard">Dashboard</flux:button>

<!-- Full width -->
<flux:button variant="primary" class="w-full">Submit</flux:button>

<!-- Button groups -->
<flux:button.group>
    <flux:button>Option 1</flux:button>
    <flux:button>Option 2</flux:button>
</flux:button.group>
```

### Inputs
```html
<flux:input wire:model="email" label="Email" type="email" />
<flux:input wire:model="search" placeholder="Search..." icon="magnifying-glass" />
<flux:textarea wire:model="content" label="Content" rows="4" />
<flux:select wire:model="status" label="Status">
    <flux:select.option value="draft">Draft</flux:select.option>
    <flux:select.option value="published">Published</flux:select.option>
</flux:select>
```

### Forms
```html
<flux:field>
    <flux:label>Email</flux:label>
    <flux:input wire:model="email" type="email" />
    <flux:error name="email" />
    <flux:description>We'll never share your email.</flux:description>
</flux:field>
```

### Modals
```html
<flux:modal.trigger name="confirm-delete">
    <flux:button variant="danger">Delete</flux:button>
</flux:modal.trigger>

<flux:modal name="confirm-delete">
    <flux:heading>Delete item?</flux:heading>
    <flux:text>This action cannot be undone.</flux:text>
    <div class="flex gap-2 mt-4">
        <flux:modal.close>
            <flux:button>Cancel</flux:button>
        </flux:modal.close>
        <flux:button variant="danger" wire:click="delete">Delete</flux:button>
    </div>
</flux:modal>
```

### Tables
```html
<flux:table>
    <flux:table.columns>
        <flux:table.column>Name</flux:table.column>
        <flux:table.column>Status</flux:table.column>
        <flux:table.column></flux:table.column>
    </flux:table.columns>
    <flux:table.rows>
        @foreach($items as $item)
        <flux:table.row :key="$item->id">
            <flux:table.cell>{{ $item->name }}</flux:table.cell>
            <flux:table.cell>
                <flux:badge color="green">Active</flux:badge>
            </flux:table.cell>
            <flux:table.cell>
                <flux:button size="sm" variant="ghost" icon="pencil" />
            </flux:table.cell>
        </flux:table.row>
        @endforeach
    </flux:table.rows>
</flux:table>
```

### Navigation
```html
<flux:navlist>
    <flux:navlist.item href="/dashboard" icon="home">Dashboard</flux:navlist.item>
    <flux:navlist.item href="/users" icon="users">Users</flux:navlist.item>
    <flux:navlist.group heading="Settings">
        <flux:navlist.item href="/settings/general">General</flux:navlist.item>
        <flux:navlist.item href="/settings/security">Security</flux:navlist.item>
    </flux:navlist.group>
</flux:navlist>
```

### Cards & Layout
```html
<flux:card>
    <flux:heading>Card Title</flux:heading>
    <flux:text>Card content goes here.</flux:text>
</flux:card>

<flux:separator />

<flux:heading size="lg">Page Title</flux:heading>
<flux:subheading>Subtitle text</flux:subheading>
```

### Badges & Indicators
```html
<flux:badge>Default</flux:badge>
<flux:badge color="green">Success</flux:badge>
<flux:badge color="red">Error</flux:badge>
<flux:badge color="yellow">Warning</flux:badge>
```

### Dropdowns
```html
<flux:dropdown>
    <flux:button icon:trailing="chevron-down">Options</flux:button>
    <flux:menu>
        <flux:menu.item icon="pencil">Edit</flux:menu.item>
        <flux:menu.item icon="trash" variant="danger">Delete</flux:menu.item>
    </flux:menu>
</flux:dropdown>
```

## Props Reference

### Button Props
| Prop | Options |
|------|---------|
| `variant` | outline, primary, filled, danger, ghost, subtle |
| `size` | base, sm, xs |
| `icon` | Heroicon name |
| `icon:trailing` | Icon on right side |
| `loading` | true/false (auto with wire:click) |

### Input Props
| Prop | Description |
|------|-------------|
| `wire:model` | Livewire binding |
| `label` | Field label |
| `placeholder` | Placeholder text |
| `icon` | Leading icon |
| `type` | text, email, password, etc. |

## Customization

Publish components for customization:
```bash
php artisan flux:publish
```

## References

For complete component docs, see `references/components.md`
