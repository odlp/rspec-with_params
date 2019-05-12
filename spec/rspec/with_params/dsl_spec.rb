require "rspec/with_params/dsl"

RSpec.describe "the DSL" do
  extend RSpec::WithParams::DSL

  with_params(
    [:input, :operation, :expected],
    ["cat", "upcase", "CAT"],
    ["cat", "capitalize", "Cat"],
  ) do
    it "has access to each parameter" do
      expect(input.public_send(operation)).to eq expected
    end
  end

  describe "access to the wider RSpec scope" do
    let(:dog) { double("dog", bark: "WOOF") }

    with_params(
      [:a, :b, :expected],
      [1, 2, 3],
    ) do
      it "has access to other elements in the RSpec scope" do
        expect(dog.bark).to eq "WOOF"
      end
    end
  end
end
