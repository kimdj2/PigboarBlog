json.post do
  json.extract! board, :id, :title, :description, :contents, :contents_html, :author, :tag_list, :image_path, :created_at, :updated_at
  json.url board_url(board, format: :json)
end
json.beforePost do
  json.merge! @before_post
end
json.nextPost do
  json.merge! @next_post
end
json.relatedPosts do 
  json.array! @related_posts
end

