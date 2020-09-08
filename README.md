# FipeCrawler

## Sobre
Aplicação criada com o intuito de automatizar o processo de obtenção de *dumps* da base de dados da tabela Fipe para veículos. É possível obter a listagem completa de marcas, modelos, anos, motorizações e preços para o mês de consulta escolhido.

## Requisitos
- Elixir
- Postgresql

## Como executar

```
$ mix deps.get
$ mix ecto.drop 
$ mix ecto.create 
$ mix ecto.migrate
$ iex -S mix

iex(1)> GenServer.cast(:marcas, {:fetch, %{codigoTipoVeiculo: "1", codigoTabelaReferencia: [mes_desejado]}})
```
Aonde `mes_desejado` equivale ao número de meses desde 01/01/1999 até o mês que se deseja consultar. Por exemplo: para consultar preços referentes ao mês 09/2020 deve-se definir `mes_desejado` para `260` pois setembro de 2020 equivale a 260 meses após janeiro de 1999.

## Funcionamento
A aplicação popula o *schema* `public` do banco Postgresql com as tabelas:
- marcas
- modelos
- anos

Os preços se encontram na tabela anos, definidos como inteiros, aonde os últimos dois digitos equivalem aos centavos.