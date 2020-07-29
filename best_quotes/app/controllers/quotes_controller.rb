class QuotesController < Rulers::Controller
  def a_quote
    # brew install fortune
    fortune = IO.popen %w[fortune wisdom]
    quote = fortune.read
    fortune.close

    render :a_quote, quote: quote
  end

  def index
    @quotes = File.all

    render :index
  end

  def new_quote
    @quote =
      File.create quote: "A riot is the language of the unheard.",
                  attribution: "Martin Luther King, Jr.",
                  submitter: "Someone"

    render :quote
  end

  def quote_1
    @quote = File.find 1

    render :quote
  end
end
