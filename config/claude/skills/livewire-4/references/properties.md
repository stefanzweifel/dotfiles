# Livewire 4 Properties

Properties store and manage state. Public properties are synced between server and client.

## Initializing Properties

```php
public $todos = [];
public $todo = '';

public function mount()
{
    $this->todos = ['Buy groceries', 'Walk the dog'];
}
```

## Bulk Assignment

```php
public function mount(Post $post)
{
    $this->post = $post;
    $this->fill($post->only('title', 'description'));
}
```

## Data Binding

```html
<input wire:model="todo">                    <!-- Sync on action -->
<input wire:model.live="search">             <!-- Sync on input -->
<input wire:model.blur="email">              <!-- Sync on blur -->
<input wire:model.live.debounce.500ms="q">   <!-- Debounced -->
```

## Resetting Properties

```php
$this->reset('todo');              // Reset single
$this->reset(['title', 'body']);   // Reset multiple
$this->reset();                    // Reset all
```

Note: `reset()` restores to state *before* `mount()` was called.

## Pulling Properties

Reset and retrieve in one operation:

```php
$this->todos[] = $this->pull('todo');  // Get value + reset

$this->pull();                         // Get all + reset all
$this->pull(['title', 'content']);     // Get some + reset those
```

## Supported Types

### Primitives
- Array, String, Integer, Float, Boolean, Null

### PHP Objects
| Type | Class |
|------|-------|
| BackedEnum | BackedEnum |
| Collection | Illuminate\Support\Collection |
| Eloquent Collection | Illuminate\Database\Eloquent\Collection |
| Model | Illuminate\Database\Eloquent\Model |
| DateTime | DateTime |
| Carbon | Carbon\Carbon |
| Stringable | Illuminate\Support\Stringable |

### Custom Types (Wireables)

```php
use Livewire\Wireable;

class Customer implements Wireable
{
    protected $name;
    protected $age;
    
    public function toLivewire()
    {
        return ['name' => $this->name, 'age' => $this->age];
    }
    
    public static function fromLivewire($value)
    {
        return new static($value['name'], $value['age']);
    }
}
```

## Accessing from JavaScript

Use `$wire` in Alpine expressions:

```html
<span x-text="$wire.todo.length"></span>
<button x-on:click="$wire.todo = ''">Clear</button>
<button x-on:click="$wire.set('todo', '')">Clear (with request)</button>
<button x-on:click="$wire.set('todo', '', false)">Clear (deferred)</button>
```

## Security

**Public properties can be manipulated client-side!**

Always validate and authorize before persisting:

```php
// BAD - trusts user-controlled $id
public function update()
{
    $post = Post::findOrFail($this->id);  // User can change $id!
    $post->update([...]);
}

// GOOD - authorize ownership
public function update()
{
    $post = Post::findOrFail($this->id);
    $this->authorize('update', $post);
    $post->update([...]);
}
```

## Protected Properties

- Not sent to frontend
- Not persisted between requests
- Good for static sensitive values

```php
public $title = 'My Post';           // {{ $title }}
protected $apiKey = 'secret';        // {{ $this->apiKey }}
```
