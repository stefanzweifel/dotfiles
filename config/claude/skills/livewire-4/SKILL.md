---
name: livewire-4
description: Build Livewire 4 components and applications. Use when creating reactive Laravel interfaces, single-file components, multi-file components, page components, forms, actions, or any Livewire-based UI. Triggers include "Livewire component", "wire:model", "wire:click", building interactive Laravel UIs, or working with Livewire 4 projects.
---

# Livewire 4

Build dynamic, reactive interfaces with PHP — no JavaScript required.

## Component Formats

### Single-file (default, recommended)
```php
<?php // resources/views/components/⚡todos.blade.php
use Livewire\Component;
new class extends Component {
    public $todos = [];
    public $todo = '';
    
    public function add()
    {
        $this->todos[] = $this->todo;
        $this->reset('todo');
    }
};
?>
<div>
    <input type="text" wire:model="todo">
    <button wire:click="add">Add</button>
    @foreach ($todos as $item)
        <li wire:key="{{ $loop->index }}">{{ $item }}</li>
    @endforeach
</div>
```

### Multi-file (for complex components)
```bash
php artisan make:livewire post.create --mfc
```
Creates: `resources/views/components/post/⚡create/` with separate `.php`, `.blade.php`, `.js`, `.css` files.

### Page components
```bash
php artisan make:livewire pages::post.create
```
Route with: `Route::livewire('/posts/create', 'pages::post.create');`

## Core Patterns

### Properties
- Public properties auto-available in Blade
- Use `$this->reset('prop')` to reset
- Use `$this->fill([...])` for bulk assignment
- Protected properties hidden from client (not persisted)

### Data Binding
```html
<input wire:model="title">           <!-- Syncs on action -->
<input wire:model.live="search">     <!-- Syncs on input -->
<input wire:model.blur="email">      <!-- Syncs on blur -->
```

### Actions
```html
<button wire:click="save">Save</button>
<button wire:click="delete({{ $id }})">Delete</button>
<form wire:submit="store">...</form>
```

### Computed Properties
```php
use Livewire\Attributes\Computed;

#[Computed]
public function posts()
{
    return Post::latest()->get();
}
```
Access in Blade: `$this->posts`

### Event Modifiers
- `wire:click.prevent` - preventDefault
- `wire:keydown.enter` - specific key
- `wire:click.debounce.500ms` - debounce
- `wire:submit.throttle` - throttle

### Loading States
```html
<button wire:click="save" class="data-loading:opacity-50">
    Save
</button>
<span class="not-data-loading:hidden">Saving...</span>
```

### Confirmation
```html
<button wire:click="delete" wire:confirm="Are you sure?">Delete</button>
```

## Security

**Always validate and authorize** — public properties can be manipulated client-side.

```php
public function delete(Post $post)
{
    $this->authorize('delete', $post);
    $post->delete();
}
```

## Detailed References

Load these as needed:
- **Components deep dive**: See `references/components.md`
- **Properties & state**: See `references/properties.md`
- **Actions & events**: See `references/actions.md`
