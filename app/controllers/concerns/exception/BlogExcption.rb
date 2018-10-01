class BlogException < StandardError
    def initialize(error_code, message)
        @code = error_code 
        super("[#{error_code}] - #{message}")
    end
    
    def self.exception(error_code, message)
        self.new(error_code, message)
    end
    
    def self.throw(error_code)
        self.new(error_code, error_message(error_code))
    end
    
    def self.error_message(error_code)
        #エラーログ出力
        ErrorUtility.errorLogger(error_code)
    end
end