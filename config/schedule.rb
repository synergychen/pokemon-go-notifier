every 8.minutes do
  runner "ExpiredCleanWorker.perform_async"
  runner "ScanWorker.perform_async"
end

every 1.minute do
  runner "Manager.update"
  runner "NotifyWorker.perform_async"
end
