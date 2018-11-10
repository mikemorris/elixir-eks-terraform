use Mix.Config

defmodule Revista.ConfigHelpers do
  @moduledoc false

  def integer_var(varname, default \\ 1) do
    case System.get_env(varname) do
      nil -> default
      val -> String.to_integer(val)
    end
  end
end

alias Revista.ConfigHelpers

# Set Configuration

chat = %{
  port: ConfigHelpers.integer_var("CHAT_PORT", 4001),
  secret_key_base: System.get_env("CHAT_SECRET_KEY_BASE")
}

core = %{
  pool_size: ConfigHelpers.integer_var("CORE_POOL_SIZE", 10),
  database_url: System.get_env("CORE_DATABASE_URL")
}

# Apply Configuration

config :chat, Chat.Endpoint,
  http: [:inet6, port: chat[:port]],
  url: [host: "localhost", port: chat[:port]],
  secret_key_base: chat[:secret_key_base]

config :core, Core.Repo,
  url: core[:database_url],
  pool_size: core[:pool_size]
