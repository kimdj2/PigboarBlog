class TagsController < ApplicationController

  # GET app/taglist
  def taglist
    @tags = ActsAsTaggableOn::Tag.where("taggings_count <> 0").order(name: "ASC")
    render :taglist, formats: :json
end
