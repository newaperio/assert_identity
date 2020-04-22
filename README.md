# AssertIdentity

![](https://github.com/newaperio/assert_identity/workflows/CI/badge.svg)

ExUnit assertions for comparing data structures by identity.

## Installation

AssertIdentity is available on [Hex](https://hex.pm/packages/assert_identity).

The package can be installed by adding `assert_identity` to your list of
dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:assert_identity, "~> 0.1.0"}
  ]
end
```

## Usage

Check the [documentation](https://hexdocs.pm/assert_identity) for more details.

AssertIdentity is designed to be used with ExUnit. It provides assertions to
check that two inputs have the same identity. This is useful, for example, when
dealing with Ecto structs which may not be strictly equivalent due to, e.g.
association preloading.

For convenience, you can import the helpers in your test case:

```elixir
def MyApp.DataCase do
  use ExUnit.CaseTemplate

  using do
    quote do
      import MyApp.DataCase
      import AssertIdentity
    end
  end
end
```

Or otherwise just directly in your test:

```elixir
def MyApp.ModuleTest do
  import AssertIdentity
end
```

Use the `assert_ids_match` function to check that two maps, structs, or lists of
the former have the same identity (i.e., the same values for the `:id` key). You
can optionally specify the key name if not `:id`.

```elixir
def MyApp.PostTest do
  use MyApp.DataCase

  test "list_posts/0 returns all posts" do
    post = insert(:post)
    assert_ids_match(Posts.list_posts(), [post])
  end
end
```

## Contributing

Contributions are welcome! To make changes, clone the repo, make sure tests
pass, and then open a PR on GitHub.

```console
git clone https://github.com/newaperio/assert_identity.git
cd assert_identity
mix deps.get
mix test
```

## License

AssertIdentity is Copyright © 2020 NewAperio. It is free software, and may be
redistributed under the terms specified in the [LICENSE](/LICENSE) file.

## About NewAperio

AssertIdentity is built by NewAperio, LLC.

NewAperio is a web and mobile design and development studio. We offer [expert
Elixir and Phoenix][services] development as part of our portfolio of services.
[Get in touch][contact] to see how our team can help you.

[services]: https://newaperio.com/services#elixir?utm_source=github
[contact]: https://newaperio.com/contact?utm_source=github
