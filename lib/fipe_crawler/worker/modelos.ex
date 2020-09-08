defmodule FipeCrawler.Worker.Modelos do
  use GenServer

  def start_link(init_arg) do
    GenServer.start_link(__MODULE__, init_arg, name: :modelos)
  end

  def salvar_modelo(form_modelos, marca, modelo) do
    resultado = GenServer.call(:database, {:modelo, marca, modelo})
    GenServer.cast(:anos, {:fetch, form_modelos, resultado})
  end

  def handle_fetch_modelos(form_base, marca) do
    form_modelos = Map.merge(form_base, %{codigoMarca: Map.get(marca, :id)})

    case FipeCrawler.Client.Fipe.fetch_modelos(form_modelos) do
      {:ok, response_modelos} ->
        {:ok, objeto_modelos} = Poison.decode(response_modelos.body)
        modelos = objeto_modelos["Modelos"]
        Enum.each(modelos, &(spawn_link(__MODULE__, :salvar_modelo, [form_modelos, marca, &1])))
      {:error, _error} ->
        Process.sleep(5000)
        handle_fetch_modelos(form_base, marca)
    end

  end

  @impl true
  def init(state) do
    {:ok, state}
  end

  @impl true
  def handle_cast({:fetch, form_base, marca}, state) do
    spawn_link(__MODULE__, :handle_fetch_modelos, [form_base, marca])
    {:noreply, state}
  end
end
