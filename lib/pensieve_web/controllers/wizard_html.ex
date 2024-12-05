defmodule PensieveWeb.WizardHTML do
  use PensieveWeb, :html

  embed_templates "wizard_html/*"

  @doc """
  Renders a wizard form.
  """
  attr :changeset, Ecto.Changeset, required: true
  attr :action, :string, required: true

  def wizard_form(assigns)
end
