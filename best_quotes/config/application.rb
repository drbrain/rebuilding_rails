require "rulers"

Rulers.app

module BestQuotes
end

class BestQuotes::Application < Rulers::Application
  def handle_error e
    case e
    when Rulers::NoSuchController then
      case e.name
      when "" then
        return [302, { "Location" => "/quotes/a_quote" }, []]
      end
    end

    super
  end
end
