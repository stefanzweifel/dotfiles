# Livewire 4 Actions

Actions are component methods triggered by frontend interactions.

## Basic Action

```php
public function save()
{
    Post::create([
        'title' => $this->title,
        'content' => $this->content,
    ]);
    
    return redirect()->to('/posts');
}
```

```html
<form wire:submit="save">
    <input wire:model="title">
    <textarea wire:model="content"></textarea>
    <button type="submit">Save</button>
</form>
```

## Passing Parameters

```html
<button wire:click="delete({{ $post->id }})">Delete</button>
```

```php
public function delete($id)
{
    $post = Post::findOrFail($id);
    $this->authorize('delete', $post);
    $post->delete();
}
```

### Route Model Binding

```php
public function delete(Post $post)  // Auto-resolved from ID
{
    $this->authorize('delete', $post);
    $post->delete();
}
```

## Dependency Injection

```php
public function delete(PostRepository $posts, $postId)
{
    $posts->deletePost($postId);
}
```

## Event Listeners

| Listener | Description |
|----------|-------------|
| `wire:click` | Element clicked |
| `wire:submit` | Form submitted |
| `wire:keydown` | Key pressed |
| `wire:keyup` | Key released |
| `wire:mouseenter` | Mouse enters |
| `wire:*` | Any browser event |

### Key Modifiers

```html
<input wire:keydown.enter="search">
<input wire:keydown.shift.enter="sendMessage">
```

| Modifier | Key |
|----------|-----|
| `.enter` | Enter |
| `.space` | Space |
| `.escape` | Escape |
| `.tab` | Tab |
| `.shift` | Shift |
| `.ctrl` | Ctrl |
| `.cmd` | Cmd |
| `.alt` | Alt |
| `.up/.down/.left/.right` | Arrows |

### Event Modifiers

| Modifier | Effect |
|----------|--------|
| `.prevent` | preventDefault() |
| `.stop` | stopPropagation() |
| `.window` | Listen on window |
| `.document` | Listen on document |
| `.outside` | Clicks outside element |
| `.once` | Fire once |
| `.debounce` | Debounce 250ms |
| `.debounce.500ms` | Custom debounce |
| `.throttle` | Throttle 250ms |
| `.throttle.100ms` | Custom throttle |
| `.self` | Only if originated here |

## Loading States

### With Tailwind + data-loading

```html
<button wire:click="save" class="data-loading:opacity-50">
    Save
</button>
<span class="not-data-loading:hidden">Saving...</span>
```

### With wire:loading

```html
<button wire:click="save">Save</button>
<span wire:loading>Saving...</span>
```

## Refreshing Components

```html
<button wire:click="$refresh">Refresh</button>
```

Or from Alpine:
```html
<button x-on:click="$wire.$refresh()">Refresh</button>
```

## Confirmation Dialogs

```html
<button 
    wire:click="delete" 
    wire:confirm="Are you sure you want to delete this?"
>
    Delete
</button>
```

## Custom Events

### Dispatch from Alpine

```html
<button x-on:click="$dispatch('custom-event')">Fire</button>
```

### Listen in Livewire

```html
<div wire:custom-event="handleEvent">...</div>
<div wire:custom-event.window="handleEvent">...</div>
```

## Security

**Always authorize actions!**

```php
public function delete(Post $post)
{
    $this->authorize('delete', $post);  // Essential!
    $post->delete();
}
```

Parameters can be manipulated client-side — never trust them blindly.
