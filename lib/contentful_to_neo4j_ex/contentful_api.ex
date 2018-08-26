defmodule ContentfulToNeo4jEx.ContentfulApi do
  @moduledoc """
  This is a simple api for fetching assets and content types from contentful.
  I can't use the contentful supplied api as it fails to return the total number of items in a set.
  This is critical for enumerating the api without missing items.
  """

  @contentful_source "https://cdn.contentful.com"

  @doc """
  Returns the assets for the given contentful space, key, limit and skip on the master environment
  """
  def assets(space, key, limit, skip) do
    assets(space, key, limit, skip, "master")
  end  

  @doc """
  Returns the assets for the given contentful space, key, limit and skip on the given environment
  """
  def assets(space, key, limit, skip, environment) do
    fetch(space, key, limit, skip, environment, :assets)
    |> handle_response 
  end  

  @doc """
  Returns the entries for the given contentful space, key, limit and skip on the master environment
  """
  def entries(space, key, limit, skip) do
    entries(space, key, limit, skip, "master")
  end

  @doc """
  Returns the entries for the given contentful space, key, limit and skip on the given environment
  """
  def entries(space, key, limit, skip, environment) do
    fetch(space, key, limit, skip, environment, :entries)
    |> handle_response
  end 

  defp fetch(space, key, limit, skip, environment, type) do
    HTTPoison.get "#{@contentful_source}/spaces/#{space}/environments/#{environment}/#{type}?access_token=#{key}&skip=#{skip}&limit=#{limit}&order=sys.createdAt&include=0" 
  end  

  defp handle_response( {:ok, %HTTPoison.Response{ body: body, status_code: 200}} ) do
    data = Poison.Parser.parse!(body, %{})
    {:ok, %{ total: data["total"], items: data["items"] }}
  end

  defp handle_response({:ok, %HTTPoison.Response{ status_code: 429, headers: headers }}) do
    {:rate_limited, %{ retry_seconds:  headers["X-Contentful-RateLimit-Reset"]}}
  end  

end