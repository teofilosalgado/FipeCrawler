defmodule FipeCrawler.Worker.Informacoes do
  use GenServer

  def start_link(init_arg) do
    GenServer.start_link(__MODULE__, init_arg, name: :informacoes)
  end

  def salvar_informacoes(modelo, informacoes) do
    GenServer.call(:database, {:ano, modelo, informacoes})
  end

  def handle_fetch_informacoes(form_anos, modelo, ano) do
    split_item = String.split(ano["Value"], "-")
    form_informacoes =  Map.merge(%{
      tipoVeiculo: "carro",
      tipoConsulta: "tradicional",
      anoModelo: Enum.at(split_item, 0),
      codigoTipoCombustivel: Enum.at(split_item, 1)
    }, form_anos)
    case FipeCrawler.Client.Fipe.fetch_informacoes(form_informacoes) do
      {:ok, response_informacoes} ->
        {:ok, informacoes} = Poison.decode(response_informacoes.body)
        spawn_link(__MODULE__, :salvar_informacoes, [modelo, informacoes])
      {:error, _error} ->
        Process.sleep(5000)
        handle_fetch_informacoes(form_anos, modelo, ano)
    end
  end

  @impl true
  def init(state) do
    {:ok, state}
  end

  @impl true
  def handle_cast({:fetch, form_anos, modelo, ano}, state) do
    spawn_link(__MODULE__, :handle_fetch_informacoes, [form_anos, modelo, ano])
    {:noreply, state}
  end
end
