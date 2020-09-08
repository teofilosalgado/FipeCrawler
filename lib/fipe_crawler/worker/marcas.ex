defmodule FipeCrawler.Worker.Marcas do
  use GenServer

  @spec start_link(any) :: :ignore | {:error, any} | {:ok, pid}
  def start_link(init_arg) do
    GenServer.start_link(__MODULE__, init_arg, name: :marcas)
  end

  def salvar_marca(form_base, marca) do
    resultado = GenServer.call(:database, {:marca, marca})
    GenServer.cast(:modelos, {:fetch, form_base, resultado})
  end

  def handle_fetch_marca(form_base) do
    case FipeCrawler.Client.Fipe.fetch_marcas(form_base) do
      {:ok, response_marcas} ->
        {:ok, marcas} = Poison.decode(response_marcas.body)
        Enum.each(marcas, &(spawn_link(__MODULE__, :salvar_marca, [form_base, &1])))
      {:error, _error} ->
        Process.sleep(5000)
        handle_fetch_marca(form_base)
    end
  end

  @impl true
  def init(state) do
    {:ok, state}
  end

  @impl true
  def handle_cast({:fetch, form_base}, state) do
    spawn_link(__MODULE__, :handle_fetch_marca, [form_base])
    {:noreply, state}
  end
end
