module GLI
  class Fetcher
    def initialize
      @conn = Faraday.new(:url => 'https://code.osu.edu') do |faraday|
        faraday.response :logger # log requests to STDOUT
        faraday.adapter  Faraday.default_adapter
        faraday.headers['PRIVATE-TOKEN'] = ENV['GITLAB_PRIVATE_TOKEN']
      end
    end

    def projects
      response = project_page(1)
      MultiJson.load(response.body)
    end

    def issues(project_id)
      response = issue_page(1, project_id)
      MultiJson.load(response.body)
    end

    private

    def project_page(page)
      @conn.get do |req|
        req.url 'api/v3/projects', :page => page
        req.params['per_page'] = 10
      end
    end

    def issue_page(page, project_id)
      @conn.get do |req|
        url_request = 'api/v3/projects/' + project_id.to_s + '/issues'
        req.url url_request, :page => page
        req.params['per_page'] = 10
      end
    end

  end
end
