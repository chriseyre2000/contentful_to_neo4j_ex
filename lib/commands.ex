defmodule Commands do

  @moduledoc """
  This is the list of commands to be sent to neo4j. Both are lists of queries  
  """
  
  defstruct nodes: [], relationships: []
end