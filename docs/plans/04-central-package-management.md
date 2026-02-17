# PR 4: Central Package Management

## Goal

Adopt `Directory.Packages.props` and `Directory.Build.props` for both the tada tooling itself and the scaffolded project templates.

## Context

Sauron uses .NET Central Package Management (CPM) where all NuGet package versions are defined once in `Directory.Packages.props` at the repo root. Individual `.csproj` files use bare `<PackageReference Include="..." />` without Version attributes. This is the modern .NET best practice.

Tada-fork currently uses traditional inline version attributes in each `.csproj` and has no `Directory.Packages.props` or `Directory.Build.props`.

## Sauron Reference Files

- `sauron/Directory.Packages.props` - Central package version definitions (76 packages)
- `sauron/Directory.Build.props` - Shared build properties (nullable, implicit usings, warnings as errors, user secrets ID)

## Current Tada-Fork State

```xml
<!-- Tada.Cli.csproj -->
<PackageReference Include="Microsoft.CodeAnalysis" Version="4.7.0" />
<PackageReference Include="Microsoft.CodeAnalysis.CSharp" Version="4.7.0" />
<PackageReference Include="System.CommandLine" Version="2.0.0-beta4.22272.1" />
```

## Two Scopes of Work

### 1. Tada CLI Tooling Itself

- Add `Directory.Packages.props` at tada-fork root with `ManagePackageVersionsCentrally=true`
- Add `Directory.Build.props` with shared build properties
- Remove inline `Version=` attributes from `Tada.Cli.csproj` and `Tada.TemplatePack.csproj`

### 2. Scaffolded Project Templates

- Add `Directory.Packages.props` to the solution template (`templates/solution/base/`) so every scaffolded project uses CPM from the start
- Add `Directory.Build.props` to the solution template
- Ensure template `.csproj` files use bare `<PackageReference Include="..." />` without Version attributes
- The `Directory.Packages.props` in scaffolded projects should include standard packages: EF Core, FluentValidation, Swashbuckle, etc.
- Database-specific packages (Npgsql, MySql.Data, Microsoft.Data.SqlClient) should be included based on the chosen `--dbtype`

## Design Decisions

- `Directory.Build.props` sets: nullable enable, implicit usings, file-scoped namespaces
- `Directory.Packages.props` defines versions for all common packages
- `CentralPackageTransitivePinningEnabled` set to `true` for transitive dependency control
- Database-specific packages managed centrally with conditional inclusion

## Verification

- `dotnet build` succeeds on tada-fork itself after migration
- `tada new TestProject --dbtype Postgres` scaffolds a project with `Directory.Packages.props`
- Scaffolded project `dotnet build` succeeds
- No inline `Version=` attributes remain in scaffolded `.csproj` files

## Implementation Note

This PR should be done first as it's a foundational change. All subsequent template work (PRs 1-3) should build on top of central package management.
