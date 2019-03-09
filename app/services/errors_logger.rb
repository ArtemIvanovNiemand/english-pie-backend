class ErrorsLogger
  def call(error)
    Rails.logger.error(error.message)
    Rails.logger.error(error.backtrace.join("\n"))
  end
end