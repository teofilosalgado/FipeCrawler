defmodule FipeCrawler.Application do
  use Application

  def start(_type, _args) do
    # GenServer.cast(:marcas, {:fetch, %{codigoTipoVeiculo: "1", codigoTabelaReferencia: "260"}})
    children = [
      FipeCrawler.Supervisor,
      {FipeCrawler.Repo, []}
    ]

    opts = [strategy: :one_for_one, name: :application]
    Supervisor.start_link(children, opts)
  end
end
