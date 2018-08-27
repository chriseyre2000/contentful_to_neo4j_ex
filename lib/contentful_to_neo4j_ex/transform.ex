defmodule ContentfulToNeo4jEx.Transform do

  @moduledoc """
  This handles the transformation of the extracted contentful data into commands that can
  be sent to neo4j.
  """

  @initial_command %Commands{
    nodes: [
      %Neo4jQuery{query: "MATCH (a) DELETE a"} , 
      %Neo4jQuery{query: "MATCH ()-[r]-() DELETE r"}
    ] 
  } 
  
  def process_contentful(data) do
    IO.puts "#{length(data.assets)} #{length(data.entries)}"

    data.assets 
      |> assets_to_commands()
      |> entries_to_commands(data.entries)
  end
  
  def assets_to_commands(assets) do
    assets_to_commands(@initial_command, assets)
  end  

  defp assets_to_commands(commands, []) do
    commands
  end  

  defp assets_to_commands(commands, [asset | assets]) do
    assets_to_commands(%Commands{commands | nodes: [transformed_asset(asset) | commands.nodes]}, assets)
  end

  defp entries_to_commands(commands, []) do
    commands
  end  

  defp entries_to_commands(commands, [entry | entries]) do
    entries_to_commands(transformed_entry(commands, entry), entries)
  end  
  
  def transformed_asset(asset) do    
    %Neo4jQuery{
      query:  "CREATE (a:asset {cmsid: {idParam}, cmstype: {typeParam}, title: {titleParam}, url: {urlParam}} ) RETURN a", 
      params: %{
        idParam: asset["sys"]["id"], 
        typeParam: asset["sys"]["type"],
        titleParam: asset["fields"]["title"],
        urlParam: asset["fields"]["file"]["url"]
      }
    }
  end
 
  def transformed_entry(commands, entry) do
    
    cms_id = entry["sys"]["id"]

    entry_command = %Neo4jQuery{ 
      query: "CREATE (a:#{entry["sys"]["contentType"]["sys"]["id"]} {cmsid: {cmsId}, contenttype: {contentType}, cmstype: {cmsType}} ) RETURN a", 
      params: %{cmsId: cms_id,
                 contentType: entry["sys"]["contentType"]["sys"]["id"],
                 cmsType: entry["sys"]["type"]
               } 
    }

    new_relationships = entry["fields"] 
      |> Enum.map(fn {field_name, value} -> process_field(cms_id, field_name, value) end)
      |> Enum.reduce(fn a, b -> a ++ b end)

    %Commands{commands | nodes: [entry_command | commands.nodes], 
                         relationships: new_relationships ++ commands.relationships}
  end

  #This is the property version
  defp process_field(cms_id, field_name, value) when is_number(value) or is_binary(value) or is_boolean(value) do    
    [ 
      %Neo4jQuery{
      query: "MATCH (a { cmsid: '#{cms_id}'}) SET a.#{field_name} = {valueParam} RETURN a",
      params: %{valueParam: value}
      } 
    ]
  end

  # This handles the list versions: list of primitives or list of references
  defp process_field(cms_id, field_name, value) when is_list(value) do
    Enum.map(value, fn item -> process_list_field(cms_id, field_name, item) end)
  end  

  defp process_field(cms_id, field_name, %{"sys" => %{"id" => other_id, "type" => "Link"}}) do
    [
      %Neo4jQuery{
        query: "MATCH (a {cmsid: '#{cms_id}'}), (b {cmsid: '#{other_id}'}) CREATE (a)-[r:#{field_name}]->(b)"
      }
    ]
  end

  # defp process_field(cmsId, fieldName, _value) do
  
  #   IO.puts "Unhandled field: #{fieldName} on #{cmsId}"
    
  #    [%Neo4jQuery{}] 
  # end

  # defp process_list_field(_cmsId, _fieldName, value) when is_boolean(value) or is_number(value) or is_binary(value) do
  #   #Need to work out how to collect all of the field items    
  #   %Neo4jQuery{}
  # end  

  #This handles the list of references to both assets and entries
  defp process_list_field(cms_id, field_name, %{"sys" => %{"id" => other_id, "type" => "Link"}}) do
    %Neo4jQuery{
      query: "MATCH (a {cmsid: '#{cms_id}'}), (b {cmsid: '#{other_id}'}) CREATE (a)-[r:#{field_name}]->(b)"
    }
  end


end  