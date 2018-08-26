# ContentfulToNeo4jEx

This is a port of the contentful-to-neo4j project from Javascript to Elixir.

The project exports a Contentful Space into a Neo4j graph database.
It looks like I am going to have to go back to basics as the contentful library does not
return the total size of the set of items being read. 

A majority of time on this project has been spent finding a working means of reading from contentful and writing to neo4j.

## Task List

Done:

- read assets from contentful
- read entries from contentful
- transform assets into a command that can be sent to neo4j
- send commands to neo4j

Todo:

- Transform entries into commands
- Add tests
- Configure the neo4j endpoint in config

Important commands to use:

iex -S mix
set "MIX_ENV=dev"