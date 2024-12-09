defmodule PensieveWeb.MemoryJSON do
  alias Pensieve.Memories.Memory

  def index(%{memories: memories}) do
    %{data: for(memory <- memories, do: data(memory))}
  end

  defp data(%Memory{} = memory) do
    %{
      id: memory.id,
      content: memory.content,
      title: memory.title
    }
  end
end
