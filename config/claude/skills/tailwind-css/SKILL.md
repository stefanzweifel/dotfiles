---
name: tailwind-css
description: Tailwind CSS utility-first styling. Use when building UIs with Tailwind classes, responsive design, dark mode, flexbox/grid layouts, hover/focus states, or any frontend styling with utility classes. Triggers include "Tailwind", "utility classes", "responsive design", "dark mode styling", or CSS layout questions.
---

# Tailwind CSS

Utility-first CSS framework. Style by combining single-purpose classes directly in markup.

## Core Concepts

### Utility Classes
```html
<div class="flex items-center gap-4 p-6 bg-white rounded-xl shadow-lg">
  <img class="size-12 rounded-full" src="..." />
  <div>
    <h3 class="text-xl font-medium text-black">Title</h3>
    <p class="text-gray-500">Description</p>
  </div>
</div>
```

### State Variants
```html
<button class="bg-sky-500 hover:bg-sky-700 focus:ring-2 active:bg-sky-800">
  Save
</button>
<input class="border focus:border-blue-500 focus:ring-1" />
<button class="bg-blue-500 disabled:opacity-50 disabled:cursor-not-allowed">
```

### Responsive (Mobile-First)
| Prefix | Min Width | CSS |
|--------|-----------|-----|
| (none) | 0 | Default (mobile) |
| `sm:` | 640px | `@media (width >= 40rem)` |
| `md:` | 768px | `@media (width >= 48rem)` |
| `lg:` | 1024px | `@media (width >= 64rem)` |
| `xl:` | 1280px | `@media (width >= 80rem)` |
| `2xl:` | 1536px | `@media (width >= 96rem)` |

```html
<!-- Stack on mobile, side-by-side on md+ -->
<div class="flex flex-col md:flex-row gap-4">
  <div class="w-full md:w-1/2">...</div>
  <div class="w-full md:w-1/2">...</div>
</div>
```

### Dark Mode
```html
<div class="bg-white dark:bg-gray-800">
  <h1 class="text-gray-900 dark:text-white">Title</h1>
  <p class="text-gray-500 dark:text-gray-400">Text</p>
</div>
```

## Common Patterns

### Flexbox Layout
```html
<div class="flex items-center justify-between">     <!-- Horizontal, spaced -->
<div class="flex flex-col gap-4">                   <!-- Vertical stack -->
<div class="flex-1">                                <!-- Grow to fill -->
<div class="flex-none">                             <!-- Don't grow/shrink -->
<div class="shrink-0">                              <!-- Prevent shrinking -->
```

### Grid Layout
```html
<div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-6">
<div class="col-span-2">                            <!-- Span 2 columns -->
```

### Spacing
```html
<div class="p-4">           <!-- Padding all sides -->
<div class="px-6 py-4">     <!-- Horizontal/vertical padding -->
<div class="mt-4 mb-2">     <!-- Margin top/bottom -->
<div class="space-y-4">     <!-- Vertical spacing between children -->
<div class="gap-4">         <!-- Gap in flex/grid -->
```

### Sizing
```html
<div class="w-full max-w-md">     <!-- Full width, max 448px -->
<div class="h-screen">            <!-- Full viewport height -->
<div class="size-12">             <!-- 48px width AND height -->
<div class="min-h-0">             <!-- For flex overflow fix -->
```

### Typography
```html
<h1 class="text-2xl font-bold text-gray-900">
<p class="text-sm text-gray-500 leading-relaxed">
<span class="font-medium">
<a class="text-blue-600 hover:underline">
```

### Cards & Containers
```html
<div class="bg-white rounded-lg shadow-md p-6">
<div class="border border-gray-200 rounded-xl">
<div class="ring-1 ring-gray-900/5">
```

### Arbitrary Values
```html
<div class="w-[327px]">           <!-- Exact width -->
<div class="bg-[#1da1f2]">        <!-- Custom color -->
<div class="grid-cols-[1fr_2fr]"> <!-- Custom grid -->
```

## Best Practices

1. **Mobile-first**: Write base styles for mobile, add `sm:`, `md:` for larger
2. **Avoid `@apply`**: Use utilities directly; extract components instead
3. **Consistent spacing**: Use the scale (4, 6, 8, 12...) not arbitrary values
4. **Group related**: Keep layout, spacing, colors logically grouped in class lists

## References

For detailed docs, see `references/` directory:
- `responsive.md` — Breakpoints and responsive patterns
- `dark-mode.md` — Dark mode configuration
- `layout.md` — Flexbox and grid patterns
