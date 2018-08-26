defmodule ContentfulToNeo4jEx do
  @moduledoc """
  Documentation for ContentfulToNeo4jEx.
  """

  @space_id  Application.fetch_env!(:contentful_to_neo4j_ex, :space)   
  @access_token Application.fetch_env!(:contentful_to_neo4j_ex, :contentful_access_token)

  @initial_command [%{query: "MATCH (a) DELETE a", params: %{} } , %{query: "MATCH ()-[r]-() DELETE r", params: %{}}]

  def transform do
    read_all_assets()
    |> read_all_entries
    |> process_contentful
    |> write_to_neo4j
  end
  
  def write_to_neo4j(data) do
    conn = Bolt.Sips.begin(Bolt.Sips.conn)
    data = Enum.reverse(data)
    Enum.each(data, fn(item) -> 
       Bolt.Sips.query(conn, item.query, item.params)  
    end )
    Bolt.Sips.commit(conn)
  end  

  def process_contentful( data ) do
    IO.puts "#{length(data.assets)} #{length(data.entries)}"

    assets_to_commands(data.assets)
    |> entries_to_commands(data.entries)
  end
  
  def assets_to_commands(assets) do
    assets_to_commands( assets, @initial_command)
  end  

  defp assets_to_commands( [], commands ) do
    commands
  end  

  defp assets_to_commands( [asset | assets], commands ) do
    assets_to_commands(assets, [transformed_asset(asset) | commands])
  end

  defp entries_to_commands(commands, []) do
    commands
  end  

  defp entries_to_commands(commands, [entry | entries]) do
    entries_to_commands(transformed_entry(entry) ++ commands, entries)
  end  
  
  defp transformed_asset(asset) do    
    %{ query:  "CREATE (a:asset {cmsid: {idParam}, cmstype: {typeParam}, title: {titleParam}, url: {urlParam}} ) RETURN a", 
     params:  %{ idParam: asset["sys"]["id"], 
                 typeParam: asset["sys"]["type"],
                 titleParam: asset["fields"]["title"],
                 urlParam: asset["fields"]["file"]["url"] }};

  end
 
  defp transformed_entry(entry) do    
    entry = %{ query: "CREATE (a:#{entry["sys"]["contentType"]["sys"]["id"]} {cmsid: {cmsId}, contenttype: {contentType}, cmstype: {cmsType}} ) RETURN a", 
      params: %{ cmsId: entry["sys"]["id"],
                 contentType: entry["sys"]["contentType"]["sys"]["id"],
                 cmsType: entry["sys"]["type"]
                 } 
    }

    [entry]
  end

  def read_all_assets() do  
    read_assets(500, 0, [])
  end

  defp read_assets(batch, skip, acc) do
    {:ok, assets} = ContentfulToNeo4jEx.ContentfulApi.assets(@space_id, @
    access_token, batch, skip)

    acc = acc ++ assets.items

    if (batch + skip) < assets.total do
      read_assets(batch, batch + skip, acc)
    end
    
    acc
  end

  def read_all_entries(assets) do
    entries = read_entries(500, 0, [])

    %{ assets: assets, entries: entries}
  end
  
  defp read_entries(batch, skip, acc) do
    {:ok, entries} = ContentfulToNeo4jEx.ContentfulApi.entries(@space_id, @access_token, batch, skip)

    acc = acc ++ entries.items
    if (batch + skip) < entries.total do
      read_entries(batch, batch + skip, acc)
    end
    acc  
  end
  

  def read_assets_from_contentful do
  
    batch_size = 500
  
    {:ok, assets} = ContentfulToNeo4jEx.ContentfulApi.assets(@space_id, @access_token, batch_size, 0)

    IO.puts "#{assets.total}"

    # Printing Content Type ID for every entry
    Enum.each(assets.items, fn (asset) -> IO.puts(asset["fields"]["file"]["fileName"]) end)
  
  end


  def read_entries_from_contentful do
    {:ok, entries} = ContentfulToNeo4jEx.ContentfulApi.entries(@space_id, @access_token, 500, 0)

    IO.puts "#{entries.total}"

    # Printing Content Type ID for every entry
    Enum.each(entries.items, fn (entry) -> IO.puts(entry["sys"]["contentType"]["sys"]["id"]) end)
    
  end

end
