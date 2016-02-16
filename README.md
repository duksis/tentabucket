# Tentabucket

[![Build Status](https://travis-ci.org/duksis/tentabucket.svg?branch=master)](https://travis-ci.org/duksis/tentabucket)

Simple [Bitbucket API](https://confluence.atlassian.com/bitbucket/use-the-bitbucket-cloud-rest-apis-222724129.html) client library for Elixir

---

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed as:

  1. Add tentabucket to your list of dependencies in `mix.exs`:

        def deps do
          [{:tentabucket, "~> 0.0.1"}]
        end

  2. Ensure tentabucket is started before your application:

        def application do
          [applications: [:tentabucket]]
        end

## Bitbucket API coverage

  * [Version 2](https://confluence.atlassian.com/bitbucket/version-2-423626329.html)
    * [ ] repositories endpoint
      * [ ] repository Resource
      * [ ] pullrequests Resource
      * [ ] commits or commit Resource
      * [ ] branch-restrictions Resource
      * [ ] diff Resource
      * [ ] webhooks Resource
      * [ ] statuses/build Resource
    * [ ] teams endpoint
    * [ ] users endpoint
    * [ ] snippets endpoint
    * [ ] user endpoint 2.0

  * [Version 1](https://confluence.atlassian.com/bitbucket/version-1-423626337.html)
    * [ ] privileges Endpoint
    * [ ] groups Endpoint
    * [ ] group-privileges Endpoint
    * [ ] invitations Endpoint
    * [ ] repositories Endpoint - 1.0
    * [ ] user Endpoint
    * [ ] users Endpoint - 1.0rivileges Endpoint
    * [ ] groups Endpoint
    * [ ] group-privileges Endpoint
    * [ ] invitations Endpoint
    * [ ] repositories Endpoint - 1.0
    * [ ] user Endpoint
    * [ ] users Endpoint - 1.0

## Examples

Fetching dependencies and running on elixir console:

```console
mix deps.get
iex -S mix
```

```iex
iex> Tentabucket.Repositories.list_account "duksis"
```

## Contributing

Start by forking this repo

Then run this command to fetch dependencies and run tests:

```console
MIX_ENV=test mix do deps.get, test
```

Pull requests are greatly appreciated
