class ScanWorker
  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform
    Scanner.perform
  end
end
