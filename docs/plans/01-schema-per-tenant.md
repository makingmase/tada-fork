# PR 1: Schema-Per-Tenant Database Pattern

## Goal

Add a `--multi-tenant` flag to `tada new` that scaffolds dual DbContexts with PostgreSQL schema isolation.

## Context

Sauron uses a schema-per-tenant model with two DbContexts:

- **PublicDatabaseContext** - `public` schema for global data (organisations, user mappings)
- **TenantDatabaseContext** - Per-tenant schema for all tenant-scoped entities

PostgreSQL `search_path` is switched at connection time via EF Core interceptors, providing database-level tenant isolation. This is more secure than the older approach (zoolander) of filtering by CompanyId on every query.

## Sauron Reference Files

- `sauron/src/2.Infrastructure/Database/Sauron.Infrastructure.Database/TenantDatabaseContext.cs`
- `sauron/src/2.Infrastructure/Database/Sauron.Infrastructure.Database/PublicDatabaseContext.cs`
- `sauron/src/2.Infrastructure/Database/Sauron.Infrastructure.Database/Providers/ITenantSchemaProvider.cs`
- `sauron/src/2.Infrastructure/Database/Sauron.Infrastructure.Database/Interceptors/TenantSearchPathInterceptor.cs`
- `sauron/src/2.Infrastructure/Database/Sauron.Infrastructure.Database/Interceptors/PublicSearchPathInterceptor.cs`
- `sauron/src/2.Infrastructure/Database/Sauron.Infrastructure.Database/DependencyRegistration.cs`

## Tada Files to Modify

- `src/Tada.Cli/Commands/NewSolutionCommand.cs` - Add `--multi-tenant` option, validate Postgres-only, pass flag to template
- `src/Tada.Cli/Models/TadaConfiguration.cs` - Add `MultiTenant` property
- `src/Tada.TemplatePack/templates/infrastructure/database/Postgres/.template.config/template.json` - Add `multiTenant` symbol + conditional file exclusions
- `src/Tada.TemplatePack/templates/infrastructure/database/Postgres/src/2.Infrastructure/Database/TadaSourceName.Infrastructure.Database/DependencyRegistration.cs` - Conditional dual-context registration via `#if (multiTenant)`
- `src/Tada.Cli/Commands/Add/AddEntitySubCommand.cs` - Inject DbSet into correct context (Tenant vs Public)
- `src/Tada.Cli/Commands/Add/AddRepositorySubCommand.cs` - Use correct context type
- Database migration commands - Support `--context` parameter for dual contexts

## New Template Files

Under the Postgres template, conditionally included when `multiTenant=true`:

- `TenantDatabaseContext.cs` - Per-tenant context (replaces `DatabaseContext.cs`)
- `PublicDatabaseContext.cs` - Shared/global context
- `Providers/ITenantSchemaProvider.cs` + `TenantSchemaProvider.cs`
- `Interceptors/TenantSearchPathInterceptor.cs` + `PublicSearchPathInterceptor.cs`
- `Entities/Public/IGlobalEntityConfiguration.cs` - Marker interface for public entity configs

## Design Decisions

- Opt-in via `--multi-tenant`; single-context remains default
- Only valid with `--dbtype Postgres` (schema isolation is PG-specific)
- Uses `template.json` conditional `sources.modifiers` for file inclusion/exclusion
- When `multiTenant=true`: excludes `DatabaseContext.cs`/`BundleFactory.cs`, includes dual-context files
- When `multiTenant=false`: excludes all multi-tenant files
- `IGlobalEntityConfiguration` marker interface separates which entity configs go to which context

## Verification

- `tada new TestProject --dbtype Postgres --multi-tenant` scaffolds dual contexts, interceptors, providers
- `tada new TestProject --dbtype Postgres` (no flag) scaffolds unchanged single-context
- `tada new TestProject --dbtype SqlServer --multi-tenant` errors with "multi-tenant requires PostgreSQL"
- `tada add entity Foo` in multi-tenant project injects into `TenantDatabaseContext`
- `dotnet build` succeeds on scaffolded project
