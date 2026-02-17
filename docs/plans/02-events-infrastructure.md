# PR 2: Events Infrastructure Upgrade

## Goal

Upgrade the existing events stub to a production-ready pattern with proper models and typing.

## Context

Tada currently has an events infrastructure that is a stub - `EventContext.BroadCast()` returns `Task.CompletedTask`. The models are minimal (just `EventMessage<T>` with a Type and Message). Sauron has evolved this into a richer pattern with CloudEvents-style metadata, actor context, and typed event objects.

## Sauron Reference Files

- `sauron/src/2.Infrastructure/Events/Sauron.Infrastructure.Events/`
- `sauron/docs/events-system.md`

## Tada Files to Modify

- `src/Tada.TemplatePack/templates/infrastructure/events/base/src/2.Infrastructure/Events/TadaSourceName.Infrastructure.Events/EventContext.cs` - Upgrade stub
- `src/Tada.TemplatePack/templates/infrastructure/events/base/src/2.Infrastructure/Events/TadaSourceName.Infrastructure.Events/IEventContext.cs` - Update interface
- `src/Tada.TemplatePack/templates/infrastructure/events/base/src/2.Infrastructure/Events/TadaSourceName.Infrastructure.Events/Models/EventMessage.cs` - Richer model with context, metadata
- `src/Tada.TemplatePack/templates/infrastructure/events/base/src/2.Infrastructure/Events/TadaSourceName.Infrastructure.Events/Types/EventTypes.cs` - Add injection token

## New Files

- `Models/EventMessageContext.cs` - Actor/context metadata (who triggered the event)
- `Models/EventMessageObject.cs` - Base payload class for event data

## Design Decisions

- Keep stub implementation (`return Task.CompletedTask`) but with correct interface shape
- Users plug in their provider (SNS, Azure Service Bus, RabbitMQ) by replacing the stub
- Event naming follows sauron's `noun:verb` convention (e.g., `company:edit`, `user:new`)
- Event payload includes: id, date, type, source, context (actor), object, affectedAttributes

## Verification

- `tada add infrastructure Events` produces updated models
- `dotnet build` succeeds on scaffolded project
