require "spec_helper"

describe Magnum::Payload::Base do
  let(:base) { described_class }

  before do
    Magnum::Payload::Base.any_instance.stub(:parse!)
  end

  describe "#new" do
    it "assigns raw data attribute" do
      Magnum::Payload::Base.any_instance.stub(:parse_payload)

      payload = base.new("raw data")
      expect(payload.raw_data).to eq "raw data"
    end

    it "assigns data attribute" do
      payload = base.new({"foo" => "bar"})
      expect(payload.data).to be_a Hashr
    end

    it "accepts a string" do
      payload = base.new('{"foo":"bar"}')

      expect(payload.data).to be_a Hashr
      expect(payload.data.foo).to eq "bar"
    end

    it "accepts a hash" do
      payload = base.new({"foo" => "bar"})

      expect(payload.data).to be_a Hashr
      expect(payload.data.foo).to  eq "bar"
    end

    it "raises error on invalid input type" do
      expect { base.new(nil) }.to raise_error "String or Hash required"
    end

    it "raises error on invalid json" do
      expect { base.new("invalid json") }.
        to raise_error Magnum::Payload::ParseError, "Valid JSON required"
    end
  end

  describe "#skip" do
    before do
      Magnum::Payload::Base.any_instance.stub(:parse_payload)
    end

    it "returns false" do
      expect(base.new("data").skip).to be_false
    end
  end

  describe "#skip?" do
    before do
      Magnum::Payload::Base.any_instance.stub(:parse_payload)
      Magnum::Payload::Base.any_instance.stub(:skip) { true }
    end

    it "returns true if skip" do
      expect(base.new("data").skip?).to be_true
    end
  end
end