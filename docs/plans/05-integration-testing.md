# PR 5: Integration Testing

## Goal

End-to-end verification of all features together.

## Test Plan

1. Scaffold full project with all features:
   ```bash
   tada new TestProject --dbtype Postgres --multi-tenant
   ```

2. Add entities:
   ```bash
   tada add entity Organisation
   tada add entity User
   ```

3. Add services:
   ```bash
   tada add service Organisation --entity
   tada add service User --entity
   ```

4. Add events infrastructure:
   ```bash
   tada add infrastructure Events
   ```

5. Add background tasks:
   ```bash
   tada add backgroundtasks
   ```

6. Verify build:
   ```bash
   dotnet build
   ```

7. Verify structure:
   - `Directory.Packages.props` present at root
   - No inline `Version=` attributes in any `.csproj`
   - `TenantDatabaseContext.cs` and `PublicDatabaseContext.cs` present (not `DatabaseContext.cs`)
   - Interceptors and providers present
   - Background tasks worker project present
   - Events models present with proper structure

8. Also test single-tenant mode:
   ```bash
   tada new SingleTenantTest --dbtype Postgres
   tada add entity Foo
   tada add service Foo --entity
   dotnet build
   ```
   - Verify `DatabaseContext.cs` present (not dual contexts)
   - Verify no multi-tenant files present
