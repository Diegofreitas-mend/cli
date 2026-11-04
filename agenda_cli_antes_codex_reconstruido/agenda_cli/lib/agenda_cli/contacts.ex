defmodule AgendaCli.Contacts do
  def total(contatos) do
  length(contatos)
  end

  def add(contatos, contato) do
    [contato | contatos]
  end

  def show(contatos, id) do
    Enum.find(contatos, fn contato ->
      contato.id == id end)
  end

  def delete(contatos, id) do
    Enum.reject(contatos, fn contato ->
      contato.id == id end)
  end

  def edit(contatos, id, alteracoes) do
    Enum.map(contatos, fn contato ->
      if contato.id == id do
        Map.merge(contato, alteracoes)
      else
        contato
      end
    end)
  end
end
