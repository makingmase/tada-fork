# PR 3: Background Task Runner

## Goal

Add a `tada add backgroundtasks` command that scaffolds a .NET worker service project with a queue-processing base class.

## Context

Sauron has a dedicated `BackgroundTasks` service project with a `QueueBackgroundService<T>` abstract base class. This handles scoped DI per message, tenant schema resolution (in multi-tenant mode), and message deserialization. Tada currently has no background task infrastructure at all.

## Sauron Reference Files

- `sauron/src/3.Services/Sauron.Services.BackgroundTasks/QueueBackgroundService.cs` - Abstract base class
- `sauron/src/2.Infrastructure/Queues/Sauron.Infrastructure.Queues/IQueueContext.cs` - Queue abstraction
- `sauron/src/2.Infrastructure/Queues/Sauron.Infrastructure.Queues/QueueContext.cs` - AWS SQS implementation
- `sauron/src/3.Services/Sauron.Services.BackgroundTasks/DependencyRegistration.cs`

## Tada Files to Modify

- `src/Tada.Cli/Commands/Add/AddCommand.cs` - Register `AddBackgroundTasksSubCommand`

## New Files

### CLI

- `src/Tada.Cli/Commands/Add/AddBackgroundTasksSubCommand.cs` - New CLI command
- `src/Tada.Cli/Scripts/AddBackgroundTasks.ps1` - Creates worker project, adds references, overlays template

### Queue Infrastructure Template (`templates/infrastructure/queues/base/`)

- `IQueueContext.cs` - Provider-agnostic queue abstraction interface
- `DependencyRegistration.cs` - Stub DI registration

### Background Tasks Template (`templates/infrastructure/backgroundtasks/`)

- `Program.cs` - Worker service host entry point (`Host.CreateApplicationBuilder`)
- `QueueBackgroundService.cs` - Abstract base with conditional tenant-aware message processing
- `DependencyRegistration.cs` - Background service registration

## Design Decisions

- **Provider-agnostic only** - template includes `IQueueContext<T>` interface and `QueueBackgroundService<T>` base class with a stub implementation. Users plug in their own provider (AWS SQS, RabbitMQ, Azure Service Bus, etc.)
- `QueueBackgroundService<T>` conditionally includes tenant schema resolution via `#if (multiTenant)`
- Uses `string` for tenant ID extraction instead of sauron's `Suid` type
- `IQueueContext<T>` uses event-based message handling (`OnMessageReceived` + `StartListening`)

## Verification

- `tada add backgroundtasks` creates worker service project
- `dotnet build` succeeds
- Worker service starts without errors
