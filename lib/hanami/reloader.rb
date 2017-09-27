require "hanami/cli/commands"
require "hanami/utils"

module Hanami
  module Utils
    # Monkey-patch `Hanami::Utils.reload!` to disable Ruby based code-reloading
    def self.reload!(directory)
      require!(directory)
      warn "Requiring #{directory}"
    end
  end

  module Reloader
    require "hanami/reloader/version"
    require "hanami/reloader/cli"
  end
end
