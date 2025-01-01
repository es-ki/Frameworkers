class ErrorUtility
  def self.logger(error, custom_message = "予期せぬエラー")
    class_name = error.class
    message = custom_message || error.message
    backtrace = error.backtrace.join("\n")
    Rails.logger.error "#{custom_message}:\n#{class_name}\n#{message}\n#{backtrace}"
    raise
  end
end
