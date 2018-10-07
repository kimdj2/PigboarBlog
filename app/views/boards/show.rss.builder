#rss feedページ
xml.instruct! :xml, :version => "1.0"
xml.rss :version => "2.0" do
  xml.channel do
    xml.title "PigAndBoar Blog"
    xml.description "PigAndBoarBlog"
    xml.link root_url
    xml.item do
        xml.title board.title
        xml.description board.contents
        xml.pubDate board.created_at.to_s(:rfc822)
        xml.link board_path(board.id)
        xml.guid board_path(board.id)
    end
  end
end
