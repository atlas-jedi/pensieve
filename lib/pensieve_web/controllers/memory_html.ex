defmodule PensieveWeb.MemoryHTML do

  use PensieveWeb, :html

  alias Pensieve.Memories.Memory
  import PensieveWeb.MemoryInformation

  embed_templates "/memory_html/*"

  def memory_inserted_at(%Memory{inserted_at: timestamp}) do
    Calendar.strftime(timestamp, "%d/%m/%y %H:%M:%S")
  end
end
