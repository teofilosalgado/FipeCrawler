defmodule FipeCrawler.Supervisor do
  use Supervisor

  def start_link(init_arg) do
    Supervisor.start_link(__MODULE__, init_arg, name: :supervisor)
  end

  @impl true
  def init(_init_arg) do
    children = [
      FipeCrawler.Worker.Database,

      FipeCrawler.Worker.Marcas,
      FipeCrawler.Worker.Modelos,
      FipeCrawler.Worker.Anos,
      FipeCrawler.Worker.Informacoes
    ]
    Supervisor.init(children, strategy: :one_for_one)
  end
end
