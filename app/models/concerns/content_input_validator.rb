class ContentInputValidator <  ActiveModel::EachValidator 
    #board、comment用のバリデーション
    def validate_each ( record ,  attribute ,  value ) 
        #htmlをクリアし、トリムして
        if Sanitize.clean(value).strip! == nil || Sanitize.clean(value).strip! == ''
            record.errors[attribute] << (options[:message] || "内容を入力してください。")
        end
    end
end