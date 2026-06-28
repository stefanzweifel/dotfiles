# Tailwind Layout Patterns

## Flexbox

### Container
```html
<div class="flex">              <!-- Horizontal (row) -->
<div class="flex flex-col">     <!-- Vertical (column) -->
<div class="inline-flex">       <!-- Inline flex -->
```

### Alignment
```html
<!-- Main axis (justify) -->
<div class="flex justify-start">      <!-- Start (default) -->
<div class="flex justify-center">     <!-- Center -->
<div class="flex justify-end">        <!-- End -->
<div class="flex justify-between">    <!-- Space between -->
<div class="flex justify-around">     <!-- Space around -->
<div class="flex justify-evenly">     <!-- Space evenly -->

<!-- Cross axis (items) -->
<div class="flex items-start">        <!-- Top -->
<div class="flex items-center">       <!-- Center -->
<div class="flex items-end">          <!-- Bottom -->
<div class="flex items-stretch">      <!-- Stretch (default) -->
<div class="flex items-baseline">     <!-- Baseline -->
```

### Flex Items
```html
<div class="flex-1">          <!-- Grow and shrink, ignore initial size -->
<div class="flex-auto">       <!-- Grow and shrink, respect initial size -->
<div class="flex-initial">    <!-- Shrink only -->
<div class="flex-none">       <!-- Don't grow or shrink -->
<div class="grow">            <!-- Grow to fill -->
<div class="grow-0">          <!-- Don't grow -->
<div class="shrink">          <!-- Allow shrinking -->
<div class="shrink-0">        <!-- Prevent shrinking -->
```

### Ordering
```html
<div class="order-first">     <!-- -9999 -->
<div class="order-last">      <!-- 9999 -->
<div class="order-none">      <!-- 0 -->
<div class="order-1">         <!-- 1 -->
```

## Grid

### Basic Grid
```html
<div class="grid grid-cols-3 gap-4">
<div class="grid grid-cols-12 gap-6">
<div class="grid grid-cols-[200px_1fr_200px]">  <!-- Custom columns -->
```

### Responsive Grid
```html
<div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4 gap-6">
```

### Spanning
```html
<div class="col-span-2">      <!-- Span 2 columns -->
<div class="col-span-full">   <!-- Span all columns -->
<div class="row-span-2">      <!-- Span 2 rows -->
```

### Auto Columns/Rows
```html
<div class="grid auto-cols-fr">     <!-- Equal width auto columns -->
<div class="grid auto-rows-min">    <!-- Min-content auto rows -->
```

## Spacing

### Gap (flex/grid)
```html
<div class="gap-4">       <!-- All directions -->
<div class="gap-x-4">     <!-- Horizontal only -->
<div class="gap-y-2">     <!-- Vertical only -->
```

### Space Between Children
```html
<div class="space-y-4">   <!-- Vertical margin between children -->
<div class="space-x-4">   <!-- Horizontal margin between children -->
```

## Common Layout Patterns

### Centered Container
```html
<div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
```

### Sticky Header
```html
<header class="sticky top-0 z-50 bg-white/80 backdrop-blur">
```

### Full Height Layout
```html
<div class="min-h-screen flex flex-col">
  <header>...</header>
  <main class="flex-1">...</main>
  <footer>...</footer>
</div>
```

### Sidebar Layout
```html
<div class="flex min-h-screen">
  <aside class="w-64 shrink-0">Sidebar</aside>
  <main class="flex-1 min-w-0">Content</main>
</div>
```

### Card Grid
```html
<div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-6">
  <div class="bg-white rounded-lg shadow p-6">Card 1</div>
  <div class="bg-white rounded-lg shadow p-6">Card 2</div>
  <div class="bg-white rounded-lg shadow p-6">Card 3</div>
</div>
```

### Horizontal Scroll
```html
<div class="flex overflow-x-auto gap-4 pb-4">
  <div class="shrink-0 w-72">Item</div>
  <div class="shrink-0 w-72">Item</div>
  <div class="shrink-0 w-72">Item</div>
</div>
```

### Aspect Ratio
```html
<div class="aspect-video">      <!-- 16:9 -->
<div class="aspect-square">     <!-- 1:1 -->
<div class="aspect-[4/3]">      <!-- Custom -->
```
