module ApplicationHelper
    def nested_groups(groups)        
        groups.map do |group, categories|
            content_tag(:ul) do
                if categories.length != 0
                    categories.map do |key,value|
                        content_tag(:li) do
                            content_tag(:a, (key.category_name).html_safe)
                        end
                    end.join.html_safe
                end
            end 
        end.join.html_safe
    end
    def get_content_img(contents)
        result = contents.scan(/<img[^>]*src=[\"']?([^>\"']+)[\"']?[^>]*>/i)
        if !result.empty?
            "#{result[0][0].to_s}"
        else
            "#{''}" 
        end
    end
end
