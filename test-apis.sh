#!/usr/bin/bash
set -euo pipefail

PORT=${PORT:-3031}
DBNAME=${DBNAME:-n4o}

api=http://localhost:$PORT/$DBNAME

graph="http://example.org/test"
file=test.ttl
skos=http://www.w3.org/2004/02/skos/core#

api=http://localhost:$PORT/$DBNAME

echo "## Test SPARQL, SPARQL update and Graph store protocol"
echo
echo "# Load $file into Fuseki graph $graph at $api"
curl --silent -X PUT "$api" --header "Content-Type: text/turtle" \
    --url-query "graph=$graph" \
    --upload-file "$file"
echo
echo "# SPARQL Update"
sparql="INSERT DATA { GRAPH <$graph> { <http://example.org/B> a <${skos}Concept> } }" 

curl --silent -X POST "$api" --header "Content-Type: application/sparql-update" --data-binary "$sparql"
echo
echo "# SPARQL Query"
sparql="SELECT * { GRAPH <$graph> { ?concept a <${skos}Concept> } }"
curl --silent "$api" --header "Accept: text/csv" --data-urlencode "query=$sparql"
echo
echo "# Download graph $graph from $api"
curl --silent --url-query "graph=$graph" $api
echo
echo "# Delete graph $graph"
curl --silent -X DELETE --url-query "graph=$graph" $api
echo
echo "# Download graph $graph from $api"
curl --silent --url-query "graph=$graph" $api
