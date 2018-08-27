defmodule ContentfulToNeo4jEx do
  @moduledoc """
  This is the main entrypoint for the contentful to neo4j loader.
  """
  import Commands
  import Neo4jQuery
  import ContentfulToNeo4jEx.ContentfulRead
  import ContentfulToNeo4jEx.Neo4jWrite
  import ContentfulToNeo4jEx.Transform

  def transform do
    read_all_assets()
    |> read_all_entries
    |> process_contentful
    |> write_to_neo4j
  end

end
