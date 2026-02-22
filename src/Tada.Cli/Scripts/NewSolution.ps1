dotnet new install Tada.TemplatePack;
dotnet new editorconfig;
dotnet new gitignore;
dotnet new tool-manifest;
dotnet new globaljson --roll-forward feature;

dotnet tool install swashbuckle.aspnetcore.cli;
dotnet tool install dotnet-ef;
dotnet tool install dotnet-format;
dotnet tool install Tada;

dotnet new sln -n "$SOLUTION_NAME";
dotnet new tada-sln -n $SOLUTION_NAME -o ./;

dotnet new classlib -n "$SOLUTION_NAME.Domain.Core" -o "./src/1.Domain/$SOLUTION_NAME.Domain.Core";
dotnet new classlib -n "$SOLUTION_NAME.Domain.Services" -o "./src/1.Domain/$SOLUTION_NAME.Domain.Services";
dotnet new classlib -n "$SOLUTION_NAME.Infrastructure.Database" -o "./src/2.Infrastructure/Database/$SOLUTION_NAME.Infrastructure.Database";
dotnet new classlib -n "$SOLUTION_NAME.Infrastructure.Database.Repositories" -o "./src/2.Infrastructure/Database/$SOLUTION_NAME.Infrastructure.Database.Repositories";
dotnet new xunit -n "$SOLUTION_NAME.Infrastructure.Database.Tests" -o "./src/2.Infrastructure/Database/$SOLUTION_NAME.Infrastructure.Database.Tests";
dotnet new classlib -n "$SOLUTION_NAME.Services" -o "./src/3.Services/$SOLUTION_NAME.Services";
dotnet new xunit -n "$SOLUTION_NAME.Services.Tests" -o "./src/3.Services/$SOLUTION_NAME.Services.Tests";
dotnet new webapi -n "$SOLUTION_NAME.Presentation.Api" -o "./src/4.Presentation/$SOLUTION_NAME.Presentation.Api" --use-controllers true;
