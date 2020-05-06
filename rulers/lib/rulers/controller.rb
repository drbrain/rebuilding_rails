##
# A controller handles some grouping of application functionality.
#
# There's not much here yet 🤷🏻‍♂️

class Rulers::Controller
  attr_reader :env

  def initialize env
    @env = env
  end
end
