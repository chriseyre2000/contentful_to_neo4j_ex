defmodule ContentfulToNeo4jEx.Neo4jWrite do

  @moduledoc """
  This is responsible for sending the commands to neo4j  
  """

  def write_to_neo4j(data) do
    conn = Bolt.Sips.begin(Bolt.Sips.conn)
    
    #Nodes need to be reversed as prefixed by delete statements
    entry_data = Enum.reverse(data.nodes)
    Enum.each(entry_data, fn(item) -> 
       Bolt.Sips.query(conn, item.query, item.params)  
    end )

    #Relationships include the properties
    Enum.each(data.relationships, fn(item) -> 
       Bolt.Sips.query(conn, item.query, item.params)  
    end )

    Bolt.Sips.commit(conn)
  end  

end 