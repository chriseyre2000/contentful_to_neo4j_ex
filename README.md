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
- transforms the bare entry node
- Transform entries into commands
- Add tests

Todo:

- Configure the neo4j endpoint in config
- Handle lists of primitives.

Important commands to use:

iex -S mix
SET "MIX_ENV=dev"
:observer.start()

#dev.exs - not included but here is a sample:
```
use Mix.Config

config :contentful_to_neo4j_ex,
    space: "INSERT_SPACE_NAME",
    contentful_access_token: "INSERT_ACCESS_TOKEN"

config :bolt_sips, Bolt,
  hostname: 'localhost',
  basic_auth: [username: "neo4j", password: "INSERT_PASSWORD"],
  port: 7687,
  pool_size: 10,
  max_overflow: 5  
```