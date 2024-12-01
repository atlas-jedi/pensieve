defmodule PensieveWeb.MemoryController do
  use PensieveWeb, :controller

  alias Pensieve.Repo
  alias Pensieve.Memories.Memory

  def index(conn, _params) do
    memories = Repo.all(Memory)
    render(conn, :index, memories: memories)
  end
end
