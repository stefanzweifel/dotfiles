# Tailwind Responsive Design

## Breakpoints

| Prefix | Min Width | Devices |
|--------|-----------|---------|
| (none) | 0 | Mobile (default) |
| `sm:` | 640px (40rem) | Large phones, small tablets |
| `md:` | 768px (48rem) | Tablets |
| `lg:` | 1024px (64rem) | Laptops, small desktops |
| `xl:` | 1280px (80rem) | Desktops |
| `2xl:` | 1536px (96rem) | Large desktops |

## Mobile-First Approach

Unprefixed utilities apply to ALL screen sizes. Prefixed utilities apply at that breakpoint AND ABOVE.

```html
<!-- WRONG: This only centers on 640px+, not mobile -->
<div class="sm:text-center">

<!-- RIGHT: Center on mobile, left-align on sm+ -->
<div class="text-center sm:text-left">
```

## Common Patterns

### Responsive Typography
```html
<h1 class="text-2xl sm:text-3xl lg:text-4xl xl:text-5xl">
```

### Responsive Spacing
```html
<div class="p-4 sm:p-6 lg:p-8">
<div class="mt-4 sm:mt-6 lg:mt-8">
```

### Responsive Layout
```html
<!-- Stack → 2 columns → 3 columns -->
<div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-4">

<!-- Stack → Side by side -->
<div class="flex flex-col md:flex-row gap-4">
```

### Responsive Visibility
```html
<div class="hidden sm:block">        <!-- Hidden on mobile -->
<div class="block sm:hidden">        <!-- Only on mobile -->
<div class="hidden md:block lg:hidden"> <!-- Only on tablets -->
```

### Responsive Width
```html
<div class="w-full md:w-1/2 lg:w-1/3">
<div class="max-w-sm sm:max-w-md lg:max-w-lg">
```

## Max-Width Variants

Target below a breakpoint:

| Variant | Media Query |
|---------|-------------|
| `max-sm:` | `@media (width < 40rem)` |
| `max-md:` | `@media (width < 48rem)` |
| `max-lg:` | `@media (width < 64rem)` |
| `max-xl:` | `@media (width < 80rem)` |
| `max-2xl:` | `@media (width < 96rem)` |

### Targeting Ranges
```html
<!-- Only between md and xl -->
<div class="md:max-xl:flex">

<!-- Only on md screens -->
<div class="md:max-lg:block">
```

## Arbitrary Breakpoints
```html
<div class="min-[320px]:text-sm">
<div class="max-[600px]:hidden">
```

## Container

```html
<div class="container mx-auto px-4">
```

Default container max-widths match breakpoints:
- sm: 640px
- md: 768px
- lg: 1024px
- xl: 1280px
- 2xl: 1536px
