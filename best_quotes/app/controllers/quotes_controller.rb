class QuotesController < Rulers::Controller
  def a_quote
    # brew install fortune
    fortune = IO.popen %w[fortune wisdom]
    quote = fortune.read
    fortune.close

    render :a_quote, quote: quote
  end

  def index
    @quotes = DBM.all

    render :index
  end

  def new_quote
    @quote = DBM.new

    attributes = {
      "quote" => "A riot is the language of the unheard.",
      "attribution" => "Martin Luther King, Jr.",
      "submitter" => "Someone",
    }

    @quote.update_attributes attributes

    @quote.save

    render :quote
  end

  def quote_1
    @quote = DBM.find 1

    render :quote
  end
end
