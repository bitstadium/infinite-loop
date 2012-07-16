class String
  include Term::ANSIColor
end

module Infinite
  module Loop
    module Helpers
      def agent
        @agent = Infinite::Loop::Agent.new unless @agent
        @agent
      end
      
      def pluralize(n, singular, plural = nil)
        n.to_i == 1 ? "1 #{singular}" : "#{n} #{plural || singular + 's'}"
      end
      
      def try
        return unless block_given?

        begin
          yield
        #rescue UnsuccessfulAuthenticationError
        #  say_error "Could not authenticate with HockeyApp." and abort
        end
      end
    end
  end
end