defmodule PensieveWeb.MemoryHTML do
  use PensieveWeb, :html

  import PensieveWeb.MemoryInformation

  embed_templates "/memory_html/*"
end
