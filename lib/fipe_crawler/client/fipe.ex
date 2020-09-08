defmodule FipeCrawler.Client.Fipe do
  use Tesla

  plug Tesla.Middleware.BaseUrl, "http://veiculos.fipe.org.br/api/veiculos/"
  plug Tesla.Middleware.FormUrlencoded

  def fetch_marcas(form) do
    post("/ConsultarMarcas", form, opts: [adapter: [recv_timeout: 60_000]])
  end

  def fetch_modelos(form) do
    post("/ConsultarModelos", form, opts: [adapter: [recv_timeout: 60_000]])
  end

  def fetch_anos(form) do
    post("/ConsultarAnoModelo", form, opts: [adapter: [recv_timeout: 60_000]])
  end

  def fetch_informacoes(form) do
    post("/ConsultarValorComTodosParametros", form, opts: [adapter: [recv_timeout: 60_000]])
  end
end
