module GLI
  class Elasticsearcher
    def initialize
      @client = Elasticsearch::Client.new host: ENV['ES_HOST'], log: true
      @index = 'gli_tracker'
    end

    def index(type, id, doc)
      @client.index index: @index, type: type, id: id, body: doc
    end

    def refresh
      @client.indices.refresh index: @index
    end

    def search(search)
      @client.search index: @index, body: { query: { match: { description: search } } }
    end
  end

end
