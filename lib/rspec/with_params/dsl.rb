module RSpec
  module WithParams
    module DSL
      def with_params(param_names, *parameter_groups, &block)
        parameter_groups.each do |parameter_group|
          params = param_names.zip(parameter_group)
          test_case_description = params
            .map { |name, value| "#{name} -> #{value.inspect}" }
            .join(", ")

          context("given #{test_case_description}") do
            params.each do |name, value|
              let(name) { value }
            end

            module_eval(&block)
          end
        end
      end
    end
  end
end
