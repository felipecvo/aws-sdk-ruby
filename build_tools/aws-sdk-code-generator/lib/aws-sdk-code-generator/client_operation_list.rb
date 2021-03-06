module AwsSdkCodeGenerator
  class ClientOperationList

    include Enumerable

    def initialize(options)
      api = options.fetch(:api)
      examples = options.fetch(:examples, {})
      client_examples = options.fetch(:client_examples, {})
      @operations = api['operations'].map do |name, operation|
        method_name = Underscore.underscore(name)
        Operation.new(
          name: method_name,
          documentation: ClientOperationDocumentation.new(
            name: name,
            method_name: method_name,
            operation: operation,
            api: api,
            examples: examples,
            client_examples: client_examples[method_name] || []
          ).to_s
        )
      end
    end

    # @return [Enumerable<Operation>]
    def each(&block)
      @operations.each(&block)
    end

    class Operation

      def initialize(options)
        @name = options.fetch(:name)
        @documentation = options.fetch(:documentation)
      end

      # @return [String]
      attr_reader :name

      # @return [String, nil]
      attr_reader :documentation

    end
  end
end
