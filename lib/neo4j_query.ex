defmodule Neo4jQuery do
  @moduledoc """
  This is the command that is sent to Neo4j  
  """

  defstruct [:query, params: %{}] 
end