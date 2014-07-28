module GLI
  class Indexer
    def perform
      gitlab = GLI::Fetcher.new
      es = GLI::Elasticsearcher.new

      logger = Logger.new(STDOUT)
      # logger.info projects

      #logger.info projects.class

      gitlab.projects.each do |project|

        # index projects.
        es.index('project', project['id'], project)

        #index project issues.
        gitlab.issues(project['id']).each do |issue|
          es.index('issue', issue['id'], issue)
        end

      end

      es.refresh
    end
  end
end
