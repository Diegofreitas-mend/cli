defmodule AgendaCli do

  def main do
    IO.puts("--- Agenda de contatos ---")
    contatos = []
    loop(contatos)
  end

  defp loop(contatos) do
    comando =
      IO.gets("agenda> ")
      |> String.trim()
      |> String.downcase()

    case comando do
      "add" ->
        nome = IO.gets("Nome: ") |> String.trim()
        empresa = IO.gets("Empresa: ") |> String.trim()
        telefone = IO.gets("Telefone: ") |> String.trim()
        email = IO.gets("E-mail: ") |> String.trim()

        contato = %{
          id: System.system_time(:millisecond),
          name: nome,
          company: empresa,
          phone: telefone,
          email: email
        }

        novos_contatos = Contacts.add(contatos, contato)
        IO.puts("Contato cadastrado!")
        loop(novos_contatos)

      "list" ->
        IO.puts("Total de contatos: #{Contacts.total(contatos)}")

        Enum.each(contatos, fn contato ->
          exibir_contato(contato)
        end)

        loop(contatos)

      "show" ->
        id =
          IO.gets("Digite o ID: ")
          |> String.trim()
          |> String.to_integer()

        case Contacts.show(contatos, id) do
          nil -> IO.puts("Contato não encontrado.")
          contato -> exibir_contato(contato)
        end

        loop(contatos)

      "exit" ->
        IO.puts("Encerrando a agenda...")

      _ ->
        IO.puts("Comando inexistente.")
        loop(contatos)
    end
  end

  defp exibir_contato(contato) do
    IO.puts("ID: #{contato.id}")
    IO.puts("Nome: #{contato.name}")
    IO.puts("Empresa: #{contato.company}")
    IO.puts("Telefone: #{contato.phone}")
    IO.puts("E-mail: #{contato.email}")
  end
end
