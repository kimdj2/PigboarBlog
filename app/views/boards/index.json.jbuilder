
json.posts do
  json.array! @boards
end
json.pageInfo do
  json.merge! @page_info
end
