defmodule AssertIdentityTest do
  use ExUnit.Case
  doctest AssertIdentity

  import AssertIdentity

  defmodule Post do
    defstruct id: nil, title: nil
  end

  defmodule Comment do
    defstruct post_id: nil, body: nil
  end

  test "assert_ids_match/2 matches structs with default keys" do
    a = %Post{id: 1}
    b = %Post{id: 1}

    assert_ids_match(a, b)
  end

  test "assert_ids_match/2 matches structs with given keys" do
    a = {%Comment{post_id: 1}, :post_id}
    b = {%Comment{post_id: 1}, :post_id}

    assert_ids_match(a, b)
  end

  test "assert_ids_match/2 matches maps with default keys" do
    a = %{id: 1}
    b = %{id: 1}

    assert_ids_match(a, b)
  end

  test "assert_ids_match/2 matches maps with given keys" do
    a = {%{x: 1}, :x}
    b = {%{y: 1}, :y}

    assert_ids_match(a, b)
  end

  test "assert_ids_match/2 matches list with default keys" do
    a = [%{id: 1}]
    b = [%{id: 1}]

    assert_ids_match(a, b)
  end

  test "assert_ids_match/2 matches lists with given keys" do
    a = {[%{x: 1}], :x}
    b = {[%{y: 1}], :y}

    assert_ids_match(a, b)
  end

  test "assert_ids_match/2 doesn't sort when given option" do
    a = [%{id: 1, name: "alpha"}, %{id: 0, name: "bravo"}]
    b = [%{id: 1, name: "alpha"}, %{id: 0, name: "bravo"}]

    assert_ids_match(a, b, sorted: true)
  end

  test "assert_ids_match/2 raises if identities can't be compared" do
    a = %{"id" => 1}
    b = %{"id" => 1}

    assert_raise ExUnit.AssertionError, fn ->
      assert_ids_match(a, b)
    end
  end
end
