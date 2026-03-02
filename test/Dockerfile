FROM mcr.microsoft.com/dotnet/sdk:10.0

WORKDIR /tada

# Copy the entire tada-fork project
COPY . .

# Pack and install locally
RUN dotnet pack --output /tada/output \
    && dotnet tool install Tada --global --add-source /tada/output \
    && dotnet new install Tada.TemplatePack --force --nuget-source /tada/output

ENV PATH="$PATH:/root/.dotnet/tools"

# Register local output as a NuGet source so that when the embedded NewSolution.ps1
# script runs "dotnet new install Tada.TemplatePack" and "dotnet tool install Tada",
# it picks up the local 1.0.0 packages instead of an older cached version.
RUN dotnet nuget add source /tada/output --name local-tada

# Scaffold and build a test project for each database type
WORKDIR /test

RUN mkdir postgres && cd postgres \
    && tada new TestPostgres --dbtype Postgres \
    && dotnet build \
    && echo "=== Postgres: BUILD PASSED ==="

RUN mkdir sqlserver && cd sqlserver \
    && tada new TestSqlServer --dbtype SqlServer \
    && dotnet build \
    && echo "=== SqlServer: BUILD PASSED ==="

# MySQL is skipped: Pomelo.EntityFrameworkCore.MySql does not yet support EF Core 10 / .NET 10
# See https://github.com/PomeloFoundation/Pomelo.EntityFrameworkCore.MySql/issues/2007
# RUN mkdir mysql && cd mysql \
#     && tada new TestMySql --dbtype Mysql \
#     && dotnet build \
#     && echo "=== MySql: BUILD PASSED ==="

# Verify CPM files exist and no inline versions remain
RUN echo "=== Checking CPM files ===" \
    && test -f /test/postgres/Directory.Packages.props \
    && test -f /test/postgres/Directory.Build.props \
    && echo "CPM files exist: PASSED" \
    && ! grep -R --include='*.csproj' 'Version=' /test/postgres/src 2>/dev/null \
    && echo "No inline versions: PASSED" \
    && echo "=== ALL CHECKS PASSED ==="
