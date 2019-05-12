require "rspec/with_params/dsl"

RSpec.describe "the DSL" do
  extend RSpec::WithParams::DSL

  let(:dog) { double("dog", bark: "WOOF") }

  with_params(
    [:input, :operation, :expected],
    ["cat", "upcase", "CAT"],
    ["cat", "capitalize", "Cat"],
  ) do
    it "has access to each parameter" do
      expect(input.public_send(operation)).to eq expected
    end

    it "has access to other elements in the RSpec scope" do
      expect(dog.bark).to eq "WOOF"
    end
  end
end
