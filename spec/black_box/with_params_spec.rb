require "jet_black"

RSpec.describe "integrating RSpec::WithParams" do
  let(:session) { JetBlack::Session.new }

  it "fails correctly with a non-zero exit status" do
    session.create_file("spec/failing_spec.rb", failing_calculator_spec)

    expect(session.run("bundle exec rspec")).
      to be_a_failure.and have_stdout(/1 example, 1 failure/)
  end

  it "executes (# param groups × # specs in block) examples" do
    session.create_file("spec/working_spec.rb", working_calculator_spec)

    expect(session.run("bundle exec rspec")).
      to be_a_success.and have_stdout(/6 examples/)
  end

  private

  def failing_calculator_spec
    <<~RUBY
      require "rspec"
      require "rspec/with_params/dsl"

      RSpec.describe "calculator" do
        extend RSpec::WithParams::DSL

        with_params(
          [:a, :b, :expected],
          [1, 1, 4],
        ) do
          it "works" do
            expect(a + b).to eq expected
          end
        end
      end
    RUBY
  end

  def working_calculator_spec
    <<~RUBY
      require "rspec"
      require "rspec/with_params/dsl"

      RSpec.describe "calculator" do
        extend RSpec::WithParams::DSL

        with_params(
          [:a, :b, :expected],
          [1, 1, 2],
          [2, 2, 4],
          [3, 3, 6],
        ) do
          it "works" do
            expect(a + b).to eq expected
          end

          it "works with arguments swapped" do
            expect(b + a).to eq expected
          end
        end
      end
    RUBY
  end
end
