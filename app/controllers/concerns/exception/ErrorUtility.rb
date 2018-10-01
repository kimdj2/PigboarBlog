class ErrorUtility
  def self.errorLogger(e)
    Rails.logger.error e.class
    Rails.logger.error e.message
    Rails.logger.error e.backtrace.join("\n")
  end
end
  