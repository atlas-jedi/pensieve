defmodule Pensieve.Hogwarts do
  @moduledoc """
  The Hogwarts context.
  """

  import Ecto.Query, warn: false
  alias Pensieve.Repo

  alias Pensieve.Hogwarts.Wizard

  @doc """
  Returns the list of wizards.

  ## Examples

      iex> list_wizards()
      [%Wizard{}, ...]

  """
  def list_wizards do
    Repo.all(Wizard)
  end

  @doc """
  Gets a single wizard.

  Raises `Ecto.NoResultsError` if the Wizard does not exist.

  ## Examples

      iex> get_wizard!(123)
      %Wizard{}

      iex> get_wizard!(456)
      ** (Ecto.NoResultsError)

  """
  def get_wizard!(id), do: Repo.get!(Wizard, id)

  @doc """
  Creates a wizard.

  ## Examples

      iex> create_wizard(%{field: value})
      {:ok, %Wizard{}}

      iex> create_wizard(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_wizard(attrs \\ %{}) do
    %Wizard{}
    |> Wizard.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a wizard.

  ## Examples

      iex> update_wizard(wizard, %{field: new_value})
      {:ok, %Wizard{}}

      iex> update_wizard(wizard, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_wizard(%Wizard{} = wizard, attrs) do
    wizard
    |> Wizard.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a wizard.

  ## Examples

      iex> delete_wizard(wizard)
      {:ok, %Wizard{}}

      iex> delete_wizard(wizard)
      {:error, %Ecto.Changeset{}}

  """
  def delete_wizard(%Wizard{} = wizard) do
    Repo.delete(wizard)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking wizard changes.

  ## Examples

      iex> change_wizard(wizard)
      %Ecto.Changeset{data: %Wizard{}}

  """
  def change_wizard(%Wizard{} = wizard, attrs \\ %{}) do
    Wizard.changeset(wizard, attrs)
  end

  def search_wizards_by_name(name) do
    query_parts = String.split(name, " ")

    from(w in Wizard, where: ^build_dynamic_conditions(query_parts))
    |> Repo.all()
  end

  defp build_dynamic_conditions([single_name]) do
    dynamic(
      [w],
      ilike(w.first_name, ^"%#{single_name}%") or
      ilike(w.last_name, ^"%#{single_name}%")
    )
  end

  defp build_dynamic_conditions([first_name, last_name]) do
    dynamic(
      [w],
      ilike(w.first_name, ^"%#{first_name}%") and
      ilike(w.last_name, ^"%#{last_name}%")
    )
  end
end
