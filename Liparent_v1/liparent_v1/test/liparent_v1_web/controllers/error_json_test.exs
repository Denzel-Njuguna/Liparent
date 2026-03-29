defmodule LiparentV1Web.ErrorJSONTest do
  use LiparentV1Web.ConnCase, async: true

  test "renders 404" do
    assert LiparentV1Web.ErrorJSON.render("404.json", %{}) == %{errors: %{detail: "Not Found"}}
  end

  test "renders 500" do
    assert LiparentV1Web.ErrorJSON.render("500.json", %{}) ==
             %{errors: %{detail: "Internal Server Error"}}
  end
end
