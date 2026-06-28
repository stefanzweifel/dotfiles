---
name: spatie-guidelines
description: Spatie's coding guidelines and conventions. Use when writing PHP, Laravel, JavaScript, or Vue code for Spatie projects or packages. Covers code style, naming, routing, controllers, Blade, validation, Git workflow, package structure, testing (Pest), and service providers. Triggers include "follow Spatie guidelines", "Spatie style", "Spatie package", or any code review for Spatie packages/projects.
---

# Spatie Guidelines

Apply these guidelines when writing code for Spatie projects or contributing to Spatie packages.

**Core principle:** Write things the way Laravel intended. If there's a documented way, follow it. Deviate only with justification.

---

## PHP Style

### Type System
- Type properties, parameters, and return types. Skip docblocks for fully typed methods.
- Use `?Type` (short nullable), not `Type|null`.
- Use `void` return type when a method returns nothing.
- Use constructor property promotion when all properties can be promoted; one per line, trailing comma:

```php
class MyClass {
    public function __construct(
        protected string $firstArgument,
        protected string $secondArgument,
    ) {}
}
```

### Docblocks
- Skip docblocks for fully type-hinted methods unless you need a description.
- Use full sentences with a period for descriptions.
- Always import classnames in docblocks (use FQCNs like `\Spatie\Url\Url`).
- One-line docblocks when possible: `/** @var string */`
- Always add docblock types for iterables: `@param array<int, string> $items`
- If a function needs one docblock param, add all other params too.

### Code Style
- PSR-1, PSR-2, PSR-12.
- Don't use `final` by default.
- Prefer string interpolation: `"Hi, I am {$name}."`
- Enums use PascalCase values: `case Diamonds;`
- Each trait on its own line with its own `use`:

```php
class MyClass
{
    use TraitA;
    use TraitB;
}
```

### Control Flow
- **Happy path last** — handle failures first, return early.
- **Avoid `else`** — refactor to early returns or ternaries.
- **Separate compound ifs** — individual `if` statements over `&&` chains.
- Always use curly brackets for `if` statements.
- Whitespace: blank lines between statements (except sequences of single-line operations).
- No extra empty lines between `{}` brackets.

### Comments
- Avoid comments. Write expressive code instead.
- Refactor comments into descriptively named methods.

---

## Laravel Conventions

### Configuration
- Config filenames: **kebab-case** (`media-library.php`, `permission.php`)
- Config keys: **snake_case** (`'chrome_path' => env('CHROME_PATH')`)
- Never use `env()` outside config files.
- Service-specific config goes in `config/services.php`, not a new file.

### Routing
- URLs: **kebab-case** (`/open-source`, `/front-end-developer`)
- Route names: **camelCase** (`->name('openSource')`)
- Route parameters: **camelCase** (`{newsItem}`)
- HTTP verb first: `Route::get('open-source', [OpenSourceController::class, 'index'])`
- Use tuple notation: `[Controller::class, 'method']`, not string `'Controller@method'`
- Don't prefix URLs with `/` (except root `/`)

### API Routing
- Plural resource names: `/errors`, `/error-occurrences`
- Kebab-case resources
- Limit deep nesting. Prefer `/error-occurrences/1` over `/projects/1/errors/1/error-occurrences/1`
- Nest only when context is necessary: `/errors/1/occurrences`

### Controllers
- **Plural** resource name + `Controller` suffix: `PostsController`
- Stick to CRUD keywords: `index`, `create`, `store`, `show`, `edit`, `update`, `destroy`
- Extract new controllers for non-CRUD actions (e.g., `FavoritePostsController` with `store`/`destroy`)
- Invokable controllers for single actions: `PerformCleanupController`

### Views & Blade
- View files: **camelCase** (`openSource.blade.php`)
- Indent with 4 spaces.
- No spaces after directives: `@if($condition)`
- Use `__()` for translations, not `@lang`

### Validation
- Always array notation: `['required', 'email']`, never pipe `'required|email'`
- Custom rules: **snake_case** (`organisation_type`)

### Authorization
- Policies: **camelCase** (`editPost`)
- Use CRUD words; replace `show` with `view`

### Artisan Commands
- Command names: **kebab-case** (`delete-old-records`)
- Always output feedback. Minimum: `$this->comment('All ok!')` at end.
- For batch processing: output progress per item, summary at end.

### Naming Classes

| Type | Convention | Example |
|------|-----------|---------|
| Controller | Plural + `Controller` | `PostsController` |
| Invokable Controller | Action + `Controller` | `PerformCleanupController` |
| Model | Singular | `Post` |
| Job | Action description | `CreateUser` |
| Event | Tense indicates timing | `ApprovingLoan` / `LoanApproved` |
| Listener | Action + `Listener` | `SendInvitationMailListener` |
| Command | Action + `Command` | `PublishScheduledPostsCommand` |
| Mailable | Event/action + `Mail` | `AccountActivatedMail` |
| Resource | Plural + `Resource` | `UsersResource` |
| Enum | Descriptive, no prefix | `OrderStatus`, `Suit` |

---

## Spatie Package Architecture

### Package Structure (spatie/package-skeleton-laravel)

```
src/                          # Main source code
src/Commands/                 # Artisan commands
src/Components/               # Blade components
src/Contracts/                # Interfaces
src/Events/                   # Events
src/Exceptions/               # Exception classes
src/Models/                   # Eloquent models
src/Traits/                   # Reusable traits
config/                       # Config file (kebab-case, no `laravel-` prefix)
database/factories/           # Model factories
database/migrations/          # Migrations (stubs)
resources/views/              # Views
routes/                       # Routes
tests/                        # Tests (Pest)
```

### Service Provider Pattern

All Spatie Laravel packages extend `PackageServiceProvider` from `spatie/laravel-package-tools`:

```php
use Spatie\LaravelPackageTools\Package;
use Spatie\LaravelPackageTools\PackageServiceProvider;

class MediaLibraryServiceProvider extends PackageServiceProvider
{
    public function configurePackage(Package $package): void
    {
        $package
            ->name('laravel-medialibrary')     // Package name
            ->hasConfigFile('media-library')   // Config without 'laravel-' prefix
            ->hasMigration('create_media_table')
            ->hasViews('media-library')
            ->hasCommands([
                RegenerateCommand::class,
                ClearCommand::class,
                CleanCommand::class,
            ]);
    }

    public function packageBooted(): void
    {
        // Post-boot logic: observers, event listeners, gate registrations
    }

    public function packageRegistered(): void
    {
        // Bindings, singletons, scoped instances
    }
}
```

**Key lifecycle methods:**
- `configurePackage()` — declare assets (config, migrations, views, commands)
- `packageRegistered()` — bind interfaces, register singletons
- `packageBooted()` — register observers, macros, blade directives

### Namespace Conventions
- Root namespace: `Spatie\PackageName` (e.g., `Spatie\Permission`, `Spatie\MediaLibrary`)
- Packagist name: `spatie/laravel-package-name` or `spatie/package-name`
- Config file drops the `laravel-` prefix: `spatie/laravel-permission` → `config/permission.php`

### Contracts Pattern

Spatie packages use contracts (interfaces) for extensibility:

```php
// src/Contracts/Permission.php
namespace Spatie\Permission\Contracts;

interface Permission
{
    // ...
}

// src/Models/Permission.php — implements the contract
class Permission extends Model implements PermissionContract
{
    // ...
}

// Service provider binds contract to implementation
$this->app->bind(PermissionContract::class, 
    fn ($app) => $app->make($app->config['permission.models.permission'])
);
```

Config allows users to swap model implementations:

```php
// config/permission.php
return [
    'models' => [
        'permission' => Spatie\Permission\Models\Permission::class,
        'role' => Spatie\Permission\Models\Role::class,
    ],
    'table_names' => [
        'roles' => 'roles',
        'permissions' => 'permissions',
    ],
];
```

### Model Patterns
- Use `$guarded = []` (not `$fillable`).
- Configurable table names via config: `$this->table = config('permission.table_names.permissions') ?: parent::getTable();`
- Provide static factory methods: `Permission::create()`, `Permission::findByName()`, `Permission::findOrCreate()`
- Throw custom exceptions for domain errors: `PermissionAlreadyExists`, `PermissionDoesNotExist`
- Use traits for shared behavior: `HasRoles`, `InteractsWithMedia`

### Config File Conventions
- Verbose comments explaining each option in the config file.
- Let users swap class implementations via config (models, generators, etc.).
- Use `snake_case` keys throughout.
- Group related options (`models`, `table_names`, `column_names`).

---

## Testing (Pest)

Spatie packages use **Pest** for testing with **Orchestra Testbench** for Laravel integration.

### Setup

```php
// tests/Pest.php
use Spatie\YourPackage\Tests\TestCase;

uses(TestCase::class)->in(__DIR__);
```

```php
// tests/TestCase.php
use Orchestra\Testbench\TestCase as Orchestra;

class TestCase extends Orchestra
{
    protected function setUp(): void
    {
        parent::setUp();

        Factory::guessFactoryNamesUsing(
            fn (string $modelName) => 'Spatie\\YourPackage\\Database\\Factories\\' . class_basename($modelName) . 'Factory'
        );
    }

    protected function getPackageProviders($app)
    {
        return [YourPackageServiceProvider::class];
    }

    public function getEnvironmentSetUp($app)
    {
        config()->set('database.default', 'testing');
        // Run migrations, set config overrides
    }
}
```

### Test Style

```php
// Use Pest's `it()` syntax with closures
it('can assign a role', function () {
    $user = User::factory()->create();
    
    $user->assignRole('admin');

    expect($user->hasRole('admin'))->toBeTrue();
});

it('throws when permission does not exist', function () {
    expect(fn () => Permission::findByName('nonexistent'))
        ->toThrow(PermissionDoesNotExist::class);
});

// Chain expectations
it('can create a data object from array', function () {
    $dto = SimpleDto::from('Hello World');

    expect($dto)
        ->toBeInstanceOf(SimpleDto::class)
        ->and($dto->string)->toEqual('Hello World');
});
```

### What to Test
- **Core functionality**: CRUD operations, main feature paths
- **Edge cases**: null inputs, missing data, duplicate entries
- **Custom exceptions**: verify domain errors throw correct exception types
- **Config overrides**: test that swapping implementations via config works
- **Blade directives/components**: if the package provides them
- **Artisan commands**: test output and side effects

### Test Helpers
- Define internal test classes within the test file when possible:

```php
// At the bottom of the test file, not in a separate file
class ItemAdded extends ShouldBeStored
{
    public function __construct(public string $name) {}
}
```

- For reusable test support classes, put them in `tests/TestSupport/`:

```
tests/
  TestSupport/
    TestModels/
      TestModel.php
      TestModelWithConversion.php
```

### composer.json Testing Stack
```json
{
    "require-dev": {
        "laravel/pint": "^1.14",
        "larastan/larastan": "^3.0",
        "orchestra/testbench": "^10.0||^9.0",
        "pestphp/pest": "^4.0",
        "pestphp/pest-plugin-arch": "^4.0",
        "pestphp/pest-plugin-laravel": "^4.0",
        "phpstan/extension-installer": "^1.4"
    },
    "scripts": {
        "test": "vendor/bin/pest",
        "format": "vendor/bin/pint",
        "analyse": "vendor/bin/phpstan analyse"
    }
}
```

---

## Git & GitHub Workflow

### Branch Naming
- Feature branches: `feature-mailchimp`, `fix-deliverycosts`
- Use present tense, descriptive commit messages
- Master/main always stable after go-live

### PR Workflow for Spatie Packages
1. Fork the repo and create a feature branch
2. Write tests for new functionality
3. Follow the code style (run `composer format` / Pint)
4. Run `composer test` and `composer analyse` (PHPStan)
5. Squash on merge to master
6. Keep PRs small and focused

### Common Mistakes to Avoid
- ❌ Using `env()` outside config files
- ❌ Using pipe notation for validation rules (`'required|email'`)
- ❌ Using `$fillable` instead of `$guarded = []` in package models
- ❌ Adding spaces after Blade directives (`@if ($condition)`)
- ❌ Putting extra empty lines inside `{}` brackets
- ❌ Using `final` on classes (Spatie doesn't by default)
- ❌ Docblocks on fully type-hinted methods without descriptions
- ❌ String controller references (`'Controller@method'`) instead of tuple notation
- ❌ Using `else` where early returns work
- ❌ Deep API route nesting when a flat route suffices
- ❌ Creating new config files for service credentials (use `services.php`)
- ❌ Forgetting `void` return type on methods that return nothing

---

## Detailed References

Load these as needed for full examples:
- **Laravel & PHP style**: See `references/laravel-php.md`
- **JavaScript style**: See `references/javascript.md`
- **Git workflow**: See `references/version-control.md`
- **New project setup**: See `references/new-project-setup.md`
