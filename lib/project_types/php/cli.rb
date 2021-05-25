# frozen_string_literal: true
module PHP
  class Project < ShopifyCli::ProjectType
    title("PHP App")
    creator("PHP::Commands::Create")
    connector("PHP::Commands::Connect")

    register_command("PHP::Commands::Serve", "serve")
    register_command("PHP::Commands::Tunnel", "tunnel")
    register_command("PHP::Commands::Open", "open")
    register_command("PHP::Commands::Populate", "populate")
    register_command("PHP::Commands::Deploy", "deploy")

    require Project.project_filepath("messages/messages")
    register_messages(PHP::Messages::MESSAGES)
  end

  # define/autoload project specific Commands
  module Commands
    autoload :Create, Project.project_filepath("commands/create")
    autoload :Serve, Project.project_filepath("commands/serve")
    autoload :Tunnel, Project.project_filepath("commands/tunnel")
    autoload :Connect, Project.project_filepath("commands/connect")
    autoload :Open, Project.project_filepath("commands/open")
    autoload :Populate, Project.project_filepath("commands/populate")
    autoload :Deploy, Project.project_filepath("commands/deploy")
  end

  # define/autoload project specific Tasks
  module Tasks
  end

  # define/autoload project specific Forms
  module Forms
    autoload :Create, Project.project_filepath("forms/create")
  end
end