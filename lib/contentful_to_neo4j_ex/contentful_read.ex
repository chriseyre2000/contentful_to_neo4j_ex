defmodule ContentfulToNeo4jEx.ContentfulRead do

  @moduledoc """
  This is responsible for performing batched reads from contentful.
  It is higher level than the raw api.

  Currently it makes no effort to handle rate limiting, but could easily be adapted to do so.
  """

  alias ContentfulToNeo4jEx.ContentfulApi, as: ContentfulApi

  @space_id  Application.fetch_env!(:contentful_to_neo4j_ex, :space)   
  @access_token Application.fetch_env!(:contentful_to_neo4j_ex, :contentful_access_token)

  def read_all_assets() do  
    read_assets(500, 0, [])
  end

  defp read_assets(batch, skip, acc) do
    {:ok, assets} = ContentfulApi.assets(@space_id, @
    access_token, batch, skip)

    acc = acc ++ assets.items

    if (batch + skip) < assets.total do
      read_assets(batch, batch + skip, acc)
    end
    
    acc
  end

  def read_all_entries(assets) do
    entries = read_entries(500, 0, [])

    %{
      assets: assets, 
      entries: entries
    }
  end
  
  defp read_entries(batch, skip, acc) do
    {:ok, entries} = ContentfulApi.entries(@space_id, @access_token, batch, skip)

    acc = acc ++ entries.items
    if (batch + skip) < entries.total do
      read_entries(batch, batch + skip, acc)
    end
    acc  
  end
end  
