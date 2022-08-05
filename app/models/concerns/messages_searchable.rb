require 'elasticsearch/model'

module MessagesSearchable
  extend ActiveSupport::Concern

  included do
    include Elasticsearch::Model
    include Elasticsearch::Model::Callbacks

    Elasticsearch::Model.client = Elasticsearch::Client.new host: '127.0.0.1', port: 9200, user: 'elastic', password: '123456', scheme: 'https', transport_options: { ssl: { ca_file: '/Users/radwan/http_ca_elastic.crt' } }

    mapping do
      indexes :body, type: :text
    end

    def self.search(query, chat_id)
      params = {
        query: {
          bool: {
            must: [
              {
                match: {
                  body: query,
                }
              },
            ],
            filter: [
              {
                term: { chat_id: chat_id.to_i }
              }
            ]
          }
        }
      }

      self.__elasticsearch__.search(params)
    end
  end
end