module Site::AdDetailHelper
    def post_date(date)
    # formatting date: Aug, 31 2007 - 9:55PM
    date.strftime("postado em %b, %m %Y - %H:%M")
  end
end
