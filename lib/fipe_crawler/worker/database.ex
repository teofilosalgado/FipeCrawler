defmodule FipeCrawler.Worker.Database do
  use GenServer

  def start_link(init_arg) do
    GenServer.start_link(__MODULE__, init_arg, name: :database)
  end

  @impl true
  def init(state) do
    {:ok, state}
  end

  @impl true
  def handle_call({:marca, marca}, _from, state) do
    item = %FipeCrawler.Schema.Marca{
      id: String.to_integer(marca["Value"]),
      nome: marca["Label"]
    }
    {:ok, struct} = FipeCrawler.Repo.insert(item, on_conflict: :replace_all, conflict_target: :id)
    {:reply, struct, state}
  end

  @impl true
  def handle_call({:modelo, marca, modelo}, _from, state) do
    item = %FipeCrawler.Schema.Modelo{
      nome: modelo["Label"],
      id: modelo["Value"],
      marca: marca
    }
    {:ok, struct} = FipeCrawler.Repo.insert(item, on_conflict: :replace_all, conflict_target: :id)
    {:reply, struct, state}
  end

  @impl true
  def handle_call({:ano, modelo, informacoes}, _from, state) do
    {:ok, valor} = Money.parse(informacoes["Valor"])

    item = %FipeCrawler.Schema.Ano{
      valor: valor,
      ano: Integer.to_string(informacoes["AnoModelo"]),
      combustivel: informacoes["Combustivel"],
      codigo_fipe: informacoes["CodigoFipe"],
      modelo: modelo
    }

    {:ok, struct} = FipeCrawler.Repo.insert(item, on_conflict: :replace_all, conflict_target: :codigo_fipe)
    {:reply, struct, state}
  end

end
