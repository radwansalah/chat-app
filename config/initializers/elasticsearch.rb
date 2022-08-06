# if xpack.security.enabled=true (not disabled)
# Elasticsearch::Model.client = Elasticsearch::Client.new host: ENV['ELASTIC_HOST'], port: ENV['ELASTIC_PORT'], user: ENV['ELASTIC_USER'], password: ENV['ELASTIC_PASSWORD'], scheme: 'https', transport_options: { ssl: { ca_file: ENV['ELASTIC_CA_FILE'] } }

# if xpack.security.enabled=false
Elasticsearch::Model.client = Elasticsearch::Client.new host: ENV['ELASTIC_HOST'], port: ENV['ELASTIC_PORT']