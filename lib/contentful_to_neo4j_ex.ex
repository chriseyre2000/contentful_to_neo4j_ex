defmodule ContentfulToNeo4jEx do
  @moduledoc """
  Documentation for ContentfulToNeo4jEx.
  """
  import Commands
  import Neo4jQuery

  @space_id  Application.fetch_env!(:contentful_to_neo4j_ex, :space)   
  @access_token Application.fetch_env!(:contentful_to_neo4j_ex, :contentful_access_token)

  @initial_command %Commands{
    nodes: [
      %Neo4jQuery{query: "MATCH (a) DELETE a"} , 
      %Neo4jQuery{query: "MATCH ()-[r]-() DELETE r"}
    ] 
  } 

  def transform do
    read_all_assets()
    |> read_all_entries
    |> process_contentful
    |> write_to_neo4j
  end
  
  def write_to_neo4j(data) do
    conn = Bolt.Sips.begin(Bolt.Sips.conn)
    
    #Nodes need to be reversed as prefixed by delete statements
    entryData = Enum.reverse(data.nodes)
    Enum.each(entryData, fn(item) -> 
       Bolt.Sips.query(conn, item.query, item.params)  
    end )

    Enum.each(data.relationships, fn(item) -> 
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
    assets_to_commands(@initial_command, assets)
  end  

  defp assets_to_commands(commands, []) do
    commands
  end  

  defp assets_to_commands(commands, [asset | assets]) do
    assets_to_commands(%Commands{ commands | nodes: [transformed_asset(asset) | commands.nodes]}, assets )
  end

  defp entries_to_commands(commands, []) do
    commands
  end  

  defp entries_to_commands(commands, [entry | entries]) do
    entries_to_commands(  transformed_entry(commands, entry), entries)
  end  
  
  def transformed_asset(asset) do    
    %Neo4jQuery{ query:  "CREATE (a:asset {cmsid: {idParam}, cmstype: {typeParam}, title: {titleParam}, url: {urlParam}} ) RETURN a", 
     params:  %{ idParam: asset["sys"]["id"], 
                 typeParam: asset["sys"]["type"],
                 titleParam: asset["fields"]["title"],
                 urlParam: asset["fields"]["file"]["url"] }};

  end
 
  def transformed_entry(commands, entry) do
    
    cmsId = entry["sys"]["id"]

    entryCommand = %Neo4jQuery{ 
      query: "CREATE (a:#{entry["sys"]["contentType"]["sys"]["id"]} {cmsid: {cmsId}, contenttype: {contentType}, cmstype: {cmsType}} ) RETURN a", 
      params: %{ cmsId: cmsId,
                 contentType: entry["sys"]["contentType"]["sys"]["id"],
                 cmsType: entry["sys"]["type"]
                 } 
    }

    newRelationships = entry["fields"] 
      |> Enum.map( fn {fieldName, value} -> process_field(cmsId, fieldName, value ) end)
      |> Enum.reduce(fn a,b -> a ++ b end)

    %Commands{commands | nodes: [entryCommand | commands.nodes], 
                         relationships: newRelationships ++ commands.relationships }
  end

  #This is the property version
  defp process_field(cmsId, fieldName, value) when is_number(value) or is_binary(value) or is_boolean(value) do    
    [ 
      %Neo4jQuery{
      query: "MATCH (a { cmsid: '#{cmsId}'}) SET a.#{fieldName} = {valueParam} RETURN a",
      params: %{ valueParam: value }
      } 
    ]
  end

  # This handles the list versions: list of primitives or list of references
  defp process_field(cmsId, fieldName, value) when is_list(value) do
    Enum.map(value, fn item -> process_list_field(cmsId, fieldName, item) end)
  end  

  defp process_field(cmsId, fieldName, %{ "sys" => %{ "id" => otherId, "type" => "Link" } } ) do
    [
      %Neo4jQuery{
        query: "MATCH (a {cmsid: '#{cmsId}'}), (b {cmsid: '#{otherId}'}) CREATE (a)-[r:#{fieldName}]->(b)"
      }
    ]
  end

  defp process_field(cmsId, fieldName, _value) do
  
    IO.puts "Unhandled field: #{fieldName} on #{cmsId}"
    
     [%Neo4jQuery{}] 
  end

  defp process_list_field(_cmsId, _fieldName, value) when is_boolean(value) or is_number(value) or is_binary(value) do
    #Need to work out how to collect all of the field items    
    %Neo4jQuery{}
  end  

  #This handles the list of references to both assets and entries
  defp process_list_field(cmsId, fieldName, %{ "sys" => %{ "id" => otherId, "type" => "Link" } } ) do
    %Neo4jQuery{
      query: "MATCH (a {cmsid: '#{cmsId}'}), (b {cmsid: '#{otherId}'}) CREATE (a)-[r:#{fieldName}]->(b)"
    }
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
  
  def fetch_assets do
    read_all_assets()
  end

end
