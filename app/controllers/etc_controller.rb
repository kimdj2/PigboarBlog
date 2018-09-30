class EtcController < ApplicationController
    def about
        @title = "About Us"
        render 'about/about.html.erb'
    end
end
