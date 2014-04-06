require 'spec_helper'

describe Parapets::Versionable do
  let(:versionable) do
    Class.new do
      include Parapets::Versionable

      def self.build_version(version_id,options,&block)
        version_id
      end
    end
  end

  describe "#version" do
    describe "when there are no versions" do
      it "returns nil when there are no versions" do
        expect(versionable.version(1234)).to be_nil
      end
    end

    describe "when it has a versions" do
      before(:each) do
        versionable.version(10){ }
        versionable.version(20){ }
        versionable.version(30){ }
      end

      it "returns the requested version" do
        expect(versionable.version(10)).to be_equal(10)
        expect(versionable.version(20)).to be_equal(20)
        expect(versionable.version(30)).to be_equal(30)
      end

      it "return nil when requested a version lower than the available ones" do
        expect(versionable.version(5)).to be_nil
      end

      it "returns the lower version number available" do
        expect(versionable.version(14)).to be_equal(10)
        expect(versionable.version(27)).to be_equal(20)
        expect(versionable.version(100)).to be_equal(30)
      end

    end
  end

end
