require 'spec_helper'

describe "The CVE-2011-3009 vulnerability" do
	before(:all) do
		@check = Codesake::Dawn::Kb::CVE_2011_3009.new
		# @check.debug = true
	end
  it "fires if ruby version is vulnerable (1.8.6-p111)" do
    @check.detected_ruby = {:engine=>'ruby', :version=>"1.8.6", :patchlevel=>"p111"}
    @check.vuln?.should    be_true
  end
  it "fires if ruby version is vulnerable (1.8.5-p111)" do
    @check.detected_ruby = {:engine=>'ruby', :version=>"1.8.5", :patchlevel=>"p111"}
    @check.vuln?.should    be_true
  end
  it "doesn't fire if ruby version is not vulnerable (1.8.6-p112)" do
    @check.detected_ruby = {:engine=>'ruby', :version=>"1.8.6", :patchlevel=>"p112"}
    @check.vuln?.should    be_false
  end
  it "doesn't fire if ruby version is not vulnerable (1.9.2-p112)" do
    @check.detected_ruby = {:engine=>'ruby', :version=>"1.9.2", :patchlevel=>"p112"}
    @check.vuln?.should    be_false
  end

end
