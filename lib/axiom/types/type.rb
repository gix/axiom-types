# encoding: utf-8

module Axiom
  module Types

    # Abstract base class for every type
    class Type
      extend Options, DescendantsTracker

      accept_options :constraint
      constraint proc { true }

      def self.new
        raise NotImplementedError, "#{inspect} should not be instantiated"
      end

      def self.constraint(constraint = Undefined, &block)
        constraint = block if constraint.equal?(Undefined)
        current    = @constraint
        return current if constraint.nil?
        @constraint = if current
          lambda { |object| current.call(object) && constraint.call(object) }
        else
          constraint
        end
        self
      end

      # TODO: move this into a module. separate the constraint setup from
      # declaration of the members, like the comparable modules.
      def self.includes(*members)
        set = IceNine.deep_freeze(members.to_set)
        constraint { |object| set.include?(object) }
      end

      def self.include?(object)
        included = constraint.call(object)
        if included != true && included != false
          raise TypeError,
            "constraint must return true or false, but was #{included.inspect}"
        end
        included
      end

      def self.finalize
        IceNine.deep_freeze(@constraint)
        freeze
      end

      def self.finalized?
        frozen?
      end

    end # class Type
  end # module Types
end # module Axiom
