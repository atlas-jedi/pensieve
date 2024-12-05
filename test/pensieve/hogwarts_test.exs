defmodule Pensieve.HogwartsTest do
  use Pensieve.DataCase

  alias Pensieve.Hogwarts

  describe "wizards" do
    alias Pensieve.Hogwarts.Wizard

    import Pensieve.HogwartsFixtures

    @invalid_attrs %{first_name: nil, last_name: nil, house: nil, points: nil}

    test "list_wizards/0 returns all wizards" do
      wizard = wizard_fixture()
      assert Hogwarts.list_wizards() == [wizard]
    end

    test "get_wizard!/1 returns the wizard with given id" do
      wizard = wizard_fixture()
      assert Hogwarts.get_wizard!(wizard.id) == wizard
    end

    test "create_wizard/1 with valid data creates a wizard" do
      valid_attrs = %{first_name: "some first_name", last_name: "some last_name", house: "some house", points: 42}

      assert {:ok, %Wizard{} = wizard} = Hogwarts.create_wizard(valid_attrs)
      assert wizard.first_name == "some first_name"
      assert wizard.last_name == "some last_name"
      assert wizard.house == "some house"
      assert wizard.points == 42
    end

    test "create_wizard/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Hogwarts.create_wizard(@invalid_attrs)
    end

    test "update_wizard/2 with valid data updates the wizard" do
      wizard = wizard_fixture()
      update_attrs = %{first_name: "some updated first_name", last_name: "some updated last_name", house: "some updated house", points: 43}

      assert {:ok, %Wizard{} = wizard} = Hogwarts.update_wizard(wizard, update_attrs)
      assert wizard.first_name == "some updated first_name"
      assert wizard.last_name == "some updated last_name"
      assert wizard.house == "some updated house"
      assert wizard.points == 43
    end

    test "update_wizard/2 with invalid data returns error changeset" do
      wizard = wizard_fixture()
      assert {:error, %Ecto.Changeset{}} = Hogwarts.update_wizard(wizard, @invalid_attrs)
      assert wizard == Hogwarts.get_wizard!(wizard.id)
    end

    test "delete_wizard/1 deletes the wizard" do
      wizard = wizard_fixture()
      assert {:ok, %Wizard{}} = Hogwarts.delete_wizard(wizard)
      assert_raise Ecto.NoResultsError, fn -> Hogwarts.get_wizard!(wizard.id) end
    end

    test "change_wizard/1 returns a wizard changeset" do
      wizard = wizard_fixture()
      assert %Ecto.Changeset{} = Hogwarts.change_wizard(wizard)
    end
  end
end
