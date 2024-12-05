defmodule Pensieve.HogwartsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Pensieve.Hogwarts` context.
  """

  @doc """
  Generate a wizard.
  """
  def wizard_fixture(attrs \\ %{}) do
    {:ok, wizard} =
      attrs
      |> Enum.into(%{
        first_name: "some first_name",
        house: "some house",
        last_name: "some last_name",
        points: 42
      })
      |> Pensieve.Hogwarts.create_wizard()

    wizard
  end
end
