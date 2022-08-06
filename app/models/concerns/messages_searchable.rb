require 'elasticsearch/model'

module MessagesSearchable
  extend ActiveSupport::Concern

  included do
    include Elasticsearch::Model
    include Elasticsearch::Model::Callbacks

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
                  body: query
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