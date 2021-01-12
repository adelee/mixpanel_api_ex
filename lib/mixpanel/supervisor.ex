defmodule Mixpanel.Supervisor do
  use Supervisor

  @moduledoc """


  """

  def start_link do
    Supervisor.start_link(__MODULE__, :ok)
  end

  def init(:ok) do
    config = Application.get_env(:mixpanel_api_ex, :config)

    if config[:token] == nil do
      raise "Please set :mixpanel, :token in your app environment's config"
    end

    children = [
      {Mixpanel.Client, [config, [name: Mixpanel.Client]]}
    ]

    Supervisor.init(children, strategy: :one_for_one, name: Mixpanel.Supervisor)
  end
end
