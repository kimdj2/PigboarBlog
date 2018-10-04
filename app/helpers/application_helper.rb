module ApplicationHelper
        
    #イメージパス取得
    def get_content_img(contents)
        #html形式のデータよりイメージタグのパスを取得する。
        result = contents.scan(/<img[^>]*src=[\"']?([^>\"']+)[\"']?[^>]*>/i)
        if !result.empty?
            "#{result[0][0].to_s}"
        else
            "#{''}" 
        end
    end

    def resource_name
        :user
    end

    def resource
        @resource ||= User.new
    end

    def devise_mapping
        @devise_mapping ||= Devise.mappings[:user]
    end
end
