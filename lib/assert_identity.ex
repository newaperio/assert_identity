defmodule AssertIdentity do
  import ExUnit.Assertions, only: [assert: 2]

  @typedoc """
  Value that can be compared by identity.
  """
  @type comparable :: list | {list, any} | %{id: any} | {map, any}

  @doc """
  Asserts that `a` and `b` have the same identity.

  Checks that the `id` keys of all provided structs are equal. Also compares
  any lists.

  This is useful to assert that Ecto structs are equal without doing a
  comparison on the direct structs, which may not be strictly equivalent due
  to e.g. association preloading.

  Raises `ExUnit.AssertionError` if identities can't be compared.

  ## Options

  * `sorted` - If `true`, indicates that the given lists are already sorted and
    should not be sorted by the function

  ## Examples

      iex> AssertIdentity.assert_ids_match([%{id: 1}], [%{id: 1}])
      true

      iex> AssertIdentity.assert_ids_match({[%{"id" => 1}], "id"}, {[%{"id" => 1}], "id"})
      true

      iex> AssertIdentity.assert_ids_match(%{id: 1}, %{id: 1})
      true

      iex> AssertIdentity.assert_ids_match({%{"id" => 1}, "id"}, {%{"id" => 1}, "id"})
      true

      iex> AssertIdentity.assert_ids_match([%{id: 2}, %{id: 1}], [%{id: 1}, %{id: 2}])
      true

  """
  @spec assert_ids_match(comparable(), comparable(), list) :: boolean()
  def assert_ids_match(a, b, opts \\ [])

  def assert_ids_match(list1, list2, opts)
      when is_list(list1) and is_list(list2) do
    key = Keyword.get(opts, :key, :id)
    sort = Keyword.get(opts, :sorted, false)

    list1_ids = pluck_ids(list1, key, sort)
    list2_ids = pluck_ids(list2, key, sort)

    match_lists(list1_ids, list2_ids)
  end

  def assert_ids_match({list1, id1}, {list2, id2}, opts)
      when is_list(list1) and is_list(list2) do
    sort = Keyword.get(opts, :sorted, false)

    list1_ids = pluck_ids(list1, id1, sort)
    list2_ids = pluck_ids(list2, id2, sort)

    match_lists(list1_ids, list2_ids)
  end

  def assert_ids_match(%{id: id1}, %{id: id2}, _opts) do
    match_structs(id1, id2)
  end

  def assert_ids_match({struct1, id1}, {struct2, id2}, _opts)
      when is_map(struct1) and is_map(struct2) do
    match_structs({struct1, id1}, {struct2, id2})
  end

  def assert_ids_match(a, b, _opts) do
    raise ExUnit.AssertionError,
      left: a,
      right: b,
      message: "No `id` key found to compare"
  end

  defp pluck_ids(list, key, true) do
    list
    |> Enum.map(fn
      %{^key => id} -> id
      nil -> nil
    end)
  end

  defp pluck_ids(list, key, false) do
    list
    |> pluck_ids(key, true)
    |> Enum.sort()
  end

  defp match_lists(list1_ids, list2_ids) do
    assert list1_ids == list2_ids,
      left: list1_ids,
      right: list2_ids,
      message: "List `id` keys do not match"
  end

  defp match_structs({struct1, id1}, {struct2, id2}) do
    id1 = Map.get(struct1, id1)
    id2 = Map.get(struct2, id2)
    match_structs(id1, id2)
  end

  defp match_structs(id1, id2) do
    assert id1 == id2,
      left: id1,
      right: id2,
      message: "Struct `id` keys do not match"
  end
end
