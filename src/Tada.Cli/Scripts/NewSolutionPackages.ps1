dotnet sln add "./src/1.Domain/$SOLUTION_NAME.Domain.Core/$SOLUTION_NAME.Domain.Core.csproj";
dotnet sln add "./src/1.Domain/$SOLUTION_NAME.Domain.Services/$SOLUTION_NAME.Domain.Services.csproj";
dotnet sln add "./src/2.Infrastructure/Database/$SOLUTION_NAME.Infrastructure.Database/$SOLUTION_NAME.Infrastructure.Database.csproj";
dotnet sln add "./src/2.Infrastructure/Database/$SOLUTION_NAME.Infrastructure.Database.Tests/$SOLUTION_NAME.Infrastructure.Database.Tests.csproj";
dotnet sln add "./src/2.Infrastructure/Database/$SOLUTION_NAME.Infrastructure.Database.Repositories/$SOLUTION_NAME.Infrastructure.Database.Repositories.csproj";
dotnet sln add "./src/3.Services/$SOLUTION_NAME.Services/$SOLUTION_NAME.Services.csproj";
dotnet sln add "./src/3.Services/$SOLUTION_NAME.Services.Tests/$SOLUTION_NAME.Services.Tests.csproj";
dotnet sln add "./src/4.Presentation/$SOLUTION_NAME.Presentation.Api/$SOLUTION_NAME.Presentation.Api.csproj";

dotnet add "./src/1.Domain/$SOLUTION_NAME.Domain.Core/$SOLUTION_NAME.Domain.Core.csproj" package FluentValidation;

dotnet add "./src/1.Domain/$SOLUTION_NAME.Domain.Services/$SOLUTION_NAME.Domain.Services.csproj" reference "./src/1.Domain/$SOLUTION_NAME.Domain.Core/$SOLUTION_NAME.Domain.Core.csproj";

dotnet add "./src/2.Infrastructure/Database/$SOLUTION_NAME.Infrastructure.Database/$SOLUTION_NAME.Infrastructure.Database.csproj" package Microsoft.EntityFrameworkCore;
dotnet add "./src/2.Infrastructure/Database/$SOLUTION_NAME.Infrastructure.Database/$SOLUTION_NAME.Infrastructure.Database.csproj" package Microsoft.EntityFrameworkCore.Design;
dotnet add "./src/2.Infrastructure/Database/$SOLUTION_NAME.Infrastructure.Database/$SOLUTION_NAME.Infrastructure.Database.csproj" package Microsoft.Extensions.Configuration.EnvironmentVariables;
dotnet add "./src/2.Infrastructure/Database/$SOLUTION_NAME.Infrastructure.Database/$SOLUTION_NAME.Infrastructure.Database.csproj" package Microsoft.Extensions.Configuration.UserSecrets;
dotnet add "./src/2.Infrastructure/Database/$SOLUTION_NAME.Infrastructure.Database/$SOLUTION_NAME.Infrastructure.Database.csproj" reference "./src/1.Domain/$SOLUTION_NAME.Domain.Core/$SOLUTION_NAME.Domain.Core.csproj";

dotnet add "./src/2.Infrastructure/Database/$SOLUTION_NAME.Infrastructure.Database.Repositories/$SOLUTION_NAME.Infrastructure.Database.Repositories.csproj" reference "./src/2.Infrastructure/Database/$SOLUTION_NAME.Infrastructure.Database/$SOLUTION_NAME.Infrastructure.Database.csproj";
dotnet add "./src/2.Infrastructure/Database/$SOLUTION_NAME.Infrastructure.Database.Repositories/$SOLUTION_NAME.Infrastructure.Database.Repositories.csproj" reference "./src/1.Domain/$SOLUTION_NAME.Domain.Core/$SOLUTION_NAME.Domain.Core.csproj";

dotnet add "./src/2.Infrastructure/Database/$SOLUTION_NAME.Infrastructure.Database.Tests/$SOLUTION_NAME.Infrastructure.Database.Tests.csproj" reference "./src/2.Infrastructure/Database/$SOLUTION_NAME.Infrastructure.Database/$SOLUTION_NAME.Infrastructure.Database.csproj";
dotnet add "./src/2.Infrastructure/Database/$SOLUTION_NAME.Infrastructure.Database.Tests/$SOLUTION_NAME.Infrastructure.Database.Tests.csproj" reference "./src/2.Infrastructure/Database/$SOLUTION_NAME.Infrastructure.Database.Repositories/$SOLUTION_NAME.Infrastructure.Database.Repositories.csproj";
dotnet add "./src/2.Infrastructure/Database/$SOLUTION_NAME.Infrastructure.Database.Tests/$SOLUTION_NAME.Infrastructure.Database.Tests.csproj" package Microsoft.EntityFrameworkCore.InMemory;
dotnet add "./src/2.Infrastructure/Database/$SOLUTION_NAME.Infrastructure.Database.Tests/$SOLUTION_NAME.Infrastructure.Database.Tests.csproj" package Bogus;

dotnet add "./src/3.Services/$SOLUTION_NAME.Services/$SOLUTION_NAME.Services.csproj" reference "./src/1.Domain/$SOLUTION_NAME.Domain.Core/$SOLUTION_NAME.Domain.Core.csproj";
dotnet add "./src/3.Services/$SOLUTION_NAME.Services/$SOLUTION_NAME.Services.csproj" reference "./src/1.Domain/$SOLUTION_NAME.Domain.Services/$SOLUTION_NAME.Domain.Services.csproj";
dotnet add "./src/3.Services/$SOLUTION_NAME.Services/$SOLUTION_NAME.Services.csproj" reference "./src/2.Infrastructure/Database/$SOLUTION_NAME.Infrastructure.Database/$SOLUTION_NAME.Infrastructure.Database.csproj";
dotnet add "./src/3.Services/$SOLUTION_NAME.Services/$SOLUTION_NAME.Services.csproj" reference "./src/2.Infrastructure/Database/$SOLUTION_NAME.Infrastructure.Database.Repositories/$SOLUTION_NAME.Infrastructure.Database.Repositories.csproj";
dotnet add "./src/3.Services/$SOLUTION_NAME.Services/$SOLUTION_NAME.Services.csproj" package FluentValidation;

dotnet add "./src/3.Services/$SOLUTION_NAME.Services.Tests/$SOLUTION_NAME.Services.Tests.csproj" reference "./src/3.Services/$SOLUTION_NAME.Services/$SOLUTION_NAME.Services.csproj";
dotnet add "./src/3.Services/$SOLUTION_NAME.Services.Tests/$SOLUTION_NAME.Services.Tests.csproj" reference "./src/2.Infrastructure/Database/$SOLUTION_NAME.Infrastructure.Database.Tests/$SOLUTION_NAME.Infrastructure.Database.Tests.csproj";
dotnet add "./src/3.Services/$SOLUTION_NAME.Services.Tests/$SOLUTION_NAME.Services.Tests.csproj" package Moq;
dotnet add "./src/3.Services/$SOLUTION_NAME.Services.Tests/$SOLUTION_NAME.Services.Tests.csproj" package Bogus;

dotnet add "./src/4.Presentation/$SOLUTION_NAME.Presentation.Api/$SOLUTION_NAME.Presentation.Api.csproj" reference "./src/1.Domain/$SOLUTION_NAME.Domain.Core/$SOLUTION_NAME.Domain.Core.csproj";
dotnet add "./src/4.Presentation/$SOLUTION_NAME.Presentation.Api/$SOLUTION_NAME.Presentation.Api.csproj" reference "./src/1.Domain/$SOLUTION_NAME.Domain.Services/$SOLUTION_NAME.Domain.Services.csproj";
dotnet add "./src/4.Presentation/$SOLUTION_NAME.Presentation.Api/$SOLUTION_NAME.Presentation.Api.csproj" reference "./src/2.Infrastructure/Database/$SOLUTION_NAME.Infrastructure.Database/$SOLUTION_NAME.Infrastructure.Database.csproj";
dotnet add "./src/4.Presentation/$SOLUTION_NAME.Presentation.Api/$SOLUTION_NAME.Presentation.Api.csproj" reference "./src/2.Infrastructure/Database/$SOLUTION_NAME.Infrastructure.Database.Repositories/$SOLUTION_NAME.Infrastructure.Database.Repositories.csproj";
dotnet add "./src/4.Presentation/$SOLUTION_NAME.Presentation.Api/$SOLUTION_NAME.Presentation.Api.csproj" reference "./src/3.Services/$SOLUTION_NAME.Services/$SOLUTION_NAME.Services.csproj";
dotnet add "./src/4.Presentation/$SOLUTION_NAME.Presentation.Api/$SOLUTION_NAME.Presentation.Api.csproj" package Microsoft.AspNetCore.Mvc.Versioning;
dotnet add "./src/4.Presentation/$SOLUTION_NAME.Presentation.Api/$SOLUTION_NAME.Presentation.Api.csproj" package Microsoft.AspNetCore.Mvc.Versioning.ApiExplorer;
dotnet add "./src/4.Presentation/$SOLUTION_NAME.Presentation.Api/$SOLUTION_NAME.Presentation.Api.csproj" package Swashbuckle.AspNetCore;
dotnet add "./src/4.Presentation/$SOLUTION_NAME.Presentation.Api/$SOLUTION_NAME.Presentation.Api.csproj" package Swashbuckle.AspNetCore.Annotations;

dotnet restore;
