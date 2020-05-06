class QuotesController < Rulers::Controller
  def a_quote
    fortune = IO.popen %w[fortune wisdom]
    quote = fortune.read
    fortune.close

    <<-HTML
<!DOCTYPE html>

<title>Random quote</title>

<blockquote><p>#{quote}</blockquote>
    HTML
  end
end
