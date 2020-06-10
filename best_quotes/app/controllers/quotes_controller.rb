class QuotesController < Rulers::Controller
  def a_quote
    # brew install fortune
    fortune = IO.popen %w[fortune wisdom]
    quote = fortune.read
    fortune.close

    render :a_quote, quote: quote
  end
end
