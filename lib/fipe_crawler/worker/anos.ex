defmodule FipeCrawler.Worker.Anos do
  use GenServer

  def start_link(init_arg) do
    GenServer.start_link(__MODULE__, init_arg, name: :anos)
  end

  def salvar_ano(form_anos, modelo, ano) do
    GenServer.cast(:informacoes, {:fetch, form_anos, modelo, ano})
  end

  def handle_fetch_anos(form_modelos, modelo) do
    form_anos = Map.merge(form_modelos, %{codigoModelo: Map.get(modelo, :id)})

    case FipeCrawler.Client.Fipe.fetch_anos(form_anos) do
      {:ok, response_anos} ->
        {:ok, anos} = Poison.decode(response_anos.body)
        Enum.each(anos, &(spawn_link(__MODULE__, :salvar_ano, [form_anos, modelo, &1])))
      {:error, _error} ->
        Process.sleep(5000)
        handle_fetch_anos(form_modelos, modelo)
    end

  end

  @impl true
  def init(state) do
    {:ok, state}
  end

  @impl true
  def handle_cast({:fetch, form_modelos,modelo}, state) do
    spawn_link(__MODULE__, :handle_fetch_anos, [form_modelos, modelo])
    {:noreply, state}
  end
end
