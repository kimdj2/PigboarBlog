crumb :root do
  link "Home", root_path
end
# Issue list
crumb :boards do
  link "Posts", boards_path
end

crumb :board do |board|
  link board.title, board
  parent :boards
end

crumb :board_new do
  link "スレット作成", boards_path
  parent :boards
end

crumb :board_edit do
  link "スレット修正", boards_path
  parent :boards
end

# crumb :projects do
#   link "Projects", projects_path
# end

# crumb :project do |project|
#   link project.name, project_path(project)
#   parent :projects
# end

# crumb :project_issues do |project|
#   link "Issues", project_issues_path(project)
#   parent :project, project
# end

# crumb :issue do |issue|
#   link issue.title, issue_path(issue)
#   parent :project_issues, issue.project
# end

# If you want to split your breadcrumbs configuration over multiple files, you
# can create a folder named `config/breadcrumbs` and put your configuration
# files there. All *.rb files (e.g. `frontend.rb` or `products.rb`) in that
# folder are loaded and reloaded automatically when you change them, just like
# this file (`config/breadcrumbs.rb`).