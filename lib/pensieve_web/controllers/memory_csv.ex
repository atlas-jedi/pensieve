defmodule PensieveWeb.MemoryCSV do
  @moduledoc """
  Handles CSV formatting for Memory records.

  Provides utility functions to convert Memory records into CSV strings
  suitable for HTTP responses.
  """

  alias Pensieve.Memories.Memory

  @headers ["ID", "Title", "Content", "Created At"]

  @type memory_list :: [%Memory{}]
  @type memory_payload :: %{memories: memory_list}
  @type single_memory_payload :: %{memory: %Memory{}}

  @doc """
  Returns the content type for CSV responses.
  """
  @spec content_type :: String.t()
  def content_type, do: "text/csv"

  @doc """
  Converts a list of memories to a CSV string.
  """
  @spec index(memory_payload) :: String.t()
  def index(%{memories: memories}) do
    memories
    |> Enum.map(&to_row/1)
    |> add_headers()
    |> to_csv()
  end

  @doc """
  Converts a single memory to a CSV string.
  """
  @spec show(single_memory_payload) :: String.t()
  def show(%{memory: memory}) do
    [to_row(memory)]
    |> add_headers()
    |> to_csv()
  end

  defp to_row(%Memory{id: id, title: title, content: content, inserted_at: inserted_at}) do
    [id, title, content, format_datetime(inserted_at)]
  end

  defp add_headers(rows), do: [@headers | rows]

  defp to_csv(rows) do
    rows
    |> CSV.encode()
    |> Enum.join()
  end

  defp format_datetime(datetime) do
    Calendar.strftime(datetime, "%Y-%m-%d %H:%M:%S")
  rescue
    ArgumentError -> "Invalid Date"
  end
end
