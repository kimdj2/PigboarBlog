module BlogCommon
    extend ActiveSupport::Concern
    included do
        include ErrorHandler
    end

    private

    # privateメソッド

end
