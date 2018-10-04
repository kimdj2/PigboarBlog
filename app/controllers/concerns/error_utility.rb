#ログ出力用クラス
class ErrorUtility
  #ログを出力する。
  def self.errorLogger(e)
    #Exception種類
    Rails.logger.error e.class
    #Exceptionメッセージ
    Rails.logger.error e.message
    #ログ分析の為、トレースも出力
    Rails.logger.error e.backtrace.join("\n")
  end

  #ログを出力する。
  def self.errorLogger(e, message = nil)
    #エラーメッセージ
    Rails.logger.error message
    #Exception種類
    Rails.logger.error e.class
    #Exceptionメッセージ
    Rails.logger.error e.message
    #ログ分析の為、トレースも出力
    Rails.logger.error e.backtrace.join("\n")
  end
end
  