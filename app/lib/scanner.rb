class Scanner
  attr_reader :latitude, :longitude

  SCAN_URI = "https://pokevision.com/map/scan/0/0"

  def self.perform
    uri = URI(SCAN_URI)
    response = Net::HTTP.get(uri)
    job = JSON.parse(response)
    save_job(job) if job["status"] == "success"
    job
  rescue => e
    {status: "fail", error: e.message}
  end

  private

  def self.save_job(job)
    ScanJob.create(job_id: job["jobId"])
  end
end
