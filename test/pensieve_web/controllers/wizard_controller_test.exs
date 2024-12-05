defmodule PensieveWeb.WizardControllerTest do
  use PensieveWeb.ConnCase

  import Pensieve.HogwartsFixtures

  @create_attrs %{first_name: "some first_name", last_name: "some last_name", house: "some house", points: 42}
  @update_attrs %{first_name: "some updated first_name", last_name: "some updated last_name", house: "some updated house", points: 43}
  @invalid_attrs %{first_name: nil, last_name: nil, house: nil, points: nil}

  describe "index" do
    test "lists all wizards", %{conn: conn} do
      conn = get(conn, ~p"/wizards")
      assert html_response(conn, 200) =~ "Listing Wizards"
    end
  end

  describe "new wizard" do
    test "renders form", %{conn: conn} do
      conn = get(conn, ~p"/wizards/new")
      assert html_response(conn, 200) =~ "New Wizard"
    end
  end

  describe "create wizard" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/wizards", wizard: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == ~p"/wizards/#{id}"

      conn = get(conn, ~p"/wizards/#{id}")
      assert html_response(conn, 200) =~ "Wizard #{id}"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/wizards", wizard: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Wizard"
    end
  end

  describe "edit wizard" do
    setup [:create_wizard]

    test "renders form for editing chosen wizard", %{conn: conn, wizard: wizard} do
      conn = get(conn, ~p"/wizards/#{wizard}/edit")
      assert html_response(conn, 200) =~ "Edit Wizard"
    end
  end

  describe "update wizard" do
    setup [:create_wizard]

    test "redirects when data is valid", %{conn: conn, wizard: wizard} do
      conn = put(conn, ~p"/wizards/#{wizard}", wizard: @update_attrs)
      assert redirected_to(conn) == ~p"/wizards/#{wizard}"

      conn = get(conn, ~p"/wizards/#{wizard}")
      assert html_response(conn, 200) =~ "some updated first_name"
    end

    test "renders errors when data is invalid", %{conn: conn, wizard: wizard} do
      conn = put(conn, ~p"/wizards/#{wizard}", wizard: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Wizard"
    end
  end

  describe "delete wizard" do
    setup [:create_wizard]

    test "deletes chosen wizard", %{conn: conn, wizard: wizard} do
      conn = delete(conn, ~p"/wizards/#{wizard}")
      assert redirected_to(conn) == ~p"/wizards"

      assert_error_sent 404, fn ->
        get(conn, ~p"/wizards/#{wizard}")
      end
    end
  end

  defp create_wizard(_) do
    wizard = wizard_fixture()
    %{wizard: wizard}
  end
end
