class QuotesController < Rulers::Controller
  def a_quote
    # brew install fortune
    fortune = IO.popen %w[fortune wisdom]
    quote = fortune.read
    fortune.close

    render :a_quote, quote: quote
  end

  def quote_1
    @quote = File.find 1

    render :quote
  end
end
