atom_feed do |feed|
    feed.title("Pig And Boar Blog")
    feed.updated((@boards.first.created_at))
   
    @boards.each do |board|
      feed.entry( post ) do |entry|
        entry.title(board.title)
        entry.content(board.content, type: 'html')
      end
    end
  end