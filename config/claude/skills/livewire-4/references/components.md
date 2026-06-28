# Livewire 4 Components

## Creating Components

```bash
php artisan make:livewire post.create           # Single-file
php artisan make:livewire post.create --mfc     # Multi-file
php artisan make:livewire pages::post.create    # Page component
php artisan make:livewire CreatePost --class    # Class-based (v3 style)
```

## Single-File Component Structure

```php
<?php // resources/views/components/post/⚡create.blade.php
use Livewire\Component;
new class extends Component {
    public $title = '';
    
    public function save()
    {
        // Save logic here...
    }
};
?>
<div>
    <input wire:model="title" type="text">
    <button wire:click="save">Save Post</button>
</div>
```

The ⚡ emoji in filenames makes Livewire components recognizable. Disable in `config/livewire.php`:
```php
'make_command' => ['emoji' => false],
```

## Multi-File Component Structure

```
resources/views/components/post/⚡create/
├── create.php           # PHP class
├── create.blade.php     # Blade template
├── create.js            # JavaScript (optional)
├── create.css           # Scoped styles (optional)
├── create.global.css    # Global styles (optional)
└── create.test.php      # Pest test (with --test flag)
```

## Converting Between Formats

```bash
php artisan livewire:convert post.create        # Auto-detect
php artisan livewire:convert post.create --mfc  # To multi-file
php artisan livewire:convert post.create --sfc  # To single-file
```

## Rendering Components

```html
<livewire:component-name />
<livewire:post.create />
<livewire:pages::post.create />
```

## Passing Props

```html
<livewire:post.create title="Initial Title" />
<livewire:post.create :title="$initialTitle" />
```

Received via `mount()` or auto-assigned to matching properties:

```php
public $title;

public function mount($title = null)
{
    $this->title = $title;
}
```

## Page Components

```php
// routes/web.php
Route::livewire('/posts/create', 'pages::post.create');
Route::livewire('/posts/{id}', 'pages::post.show');
Route::livewire('/posts/{post}', 'pages::post.show');  // Model binding
```

## Computed Properties

```php
use Livewire\Attributes\Computed;

#[Computed]
public function posts()
{
    return Post::with('author')->latest()->get();
}
```

Access with `$this->` prefix:
```html
@foreach ($this->posts as $post)
    <article wire:key="{{ $post->id }}">{{ $post->title }}</article>
@endforeach
```

## Component Namespaces

Default namespaces:
- `pages::` → `resources/views/pages/`
- `layouts::` → `resources/views/layouts/`

Add custom namespaces in `config/livewire.php`:
```php
'component_namespaces' => [
    'admin' => resource_path('views/admin'),
    'widgets' => resource_path('views/widgets'),
],
```

## Class-Based Components (v3 style)

```bash
php artisan make:livewire CreatePost --class
```

Creates:
- `app/Livewire/CreatePost.php`
- `resources/views/livewire/create-post.blade.php`

```php
<?php
namespace App\Livewire;

use Livewire\Component;

class CreatePost extends Component
{
    public function render()
    {
        return view('livewire.create-post');
    }
}
```
