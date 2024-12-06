defmodule PensieveWeb.WizardLive do
  use PensieveWeb, :live_view

  alias Pensieve.Hogwarts

  def mount(_params, _session, socket) do
    {:ok, assign(socket, :wizards, Hogwarts.list_wizards())}
  end

  def handle_event("search", %{"value" => name}, socket) do
    wizards = Hogwarts.search_wizards_by_name(name)
    {:noreply, assign(socket, :wizards, wizards)}
  end
end
