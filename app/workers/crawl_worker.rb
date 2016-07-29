class CrawlWorker
  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform(latitude, longitude)
    crawler = Crawler.new(latitude, longitude)
    crawler.perform
  end
end

