defmodule PensieveWeb.MemoryCSV do
  alias Pensieve.Memories.Memory

  @type list_of_memories :: [%Memory{}]

  @doc """
  Returns the format for the CSV response.
  """
  @spec format :: String.t()
  def format, do: "text/csv"

  @doc """
  Returns the CSV representation of the index page.
  """
  @spec index(%{memories: list_of_memories}) :: String.t()
  def index(%{memories: memories}) do
    memories
    |> Enum.map(&memory_to_list/1)
    |> prepend_headers()
    |> encode_csv()
  end

  @doc """
  Returns the CSV representation of the show page.
  """
  @spec show(%Memory{}) :: String.t()
  def show(%Memory{} = memory) do
    [memory]
    |> Enum.map(&memory_to_list/1)
    |> prepend_headers()
    |> encode_csv()
  end

  defp memory_to_list(%Memory{id: id, title: title, content: content, inserted_at: inserted_at}) do
    [id, title, content, format_datetime(inserted_at)]
  end

  defp prepend_headers(records) do
    headers = ["ID", "Title", "Content", "Created At"]
    [headers | records]
  end

  defp encode_csv(records) do
    records
    |> CSV.encode()
    |> Enum.to_list()
    |> Enum.join("")
  end

  defp format_datetime(datetime) do
    Calendar.strftime(datetime, "%Y-%m-%d %H:%M:%S")
  end
end
