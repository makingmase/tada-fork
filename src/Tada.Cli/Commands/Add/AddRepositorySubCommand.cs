using System.CommandLine;

namespace Tada.Cli.Commands.Add;

public class AddRepositorySubCommand : Command
{
    public AddRepositorySubCommand() : base("repository", "add repository code")
    {
        var name = new Argument<string>
            ("name", "Repository name");

        this.Add(name);

        this.SetHandler((nameValue) => Execute(nameValue), name);
    }

    public void Execute(string name)
    {
        var config = ConfigurationLoader.LoadTadaFile();
        var ns = config?.Namespace ?? "tada";

        ConsoleWriter.Start($"Adding {name} repository");

        var shell = new ProcessShell();
        shell.Execute("dotnet", "new install Tada.TemplatePack");
        shell.Execute("dotnet", $"new tada-database-repository -n {name} --nameSpace {ns} -o \"./src/2.Infrastructure/Database/\"  --idType \"{config?.Templates.Entity.IdType}\" --idTypeNameSpace \"{config?.Templates.Entity.IdTypeNameSpace}\"");

        UpdateContent(name, ns);

        shell.DotnetFormat();

        ConsoleWriter.Success($"{name} repository added");
    }

    public static void UpdateContent(string name, string nameSpace)
    {
        var repositoryRegistration = Path.Combine(Directory.GetCurrentDirectory(), $"src/2.Infrastructure/Database/{nameSpace}.Infrastructure.Database.Repositories/DependencyRegistration.cs");
        FileUpdater.UpdateContent(repositoryRegistration,
        @"// <!-- tada injection token -->",
        $@"// <!-- tada injection token -->
        services.AddTransient<{name}s.I{name}Repository, {name}s.{name}Repository>();
            ");
    }
}