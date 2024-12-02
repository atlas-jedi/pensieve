defmodule PensieveWeb.MemoryController do
  use PensieveWeb, :controller

  alias Pensieve.Memories

  def index(conn, _params) do
    memories = Memories.list_memories
    render(conn, :index, memories: memories)
  end

  def show(conn, %{"id" => id}) do
    memory = Memories.get_memory!(id)
    render(conn, :show, memory: memory)
  end
end
