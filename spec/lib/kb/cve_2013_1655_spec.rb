require 'spec_helper'

describe "The CVE-2013-1655 vulnerability" do
  before(:all) do 
    @check = Codesake::Dawn::Kb::CVE_2013_1655.new
    # @check.debug = true
  end
  it "is detected if vulnerable version of puppet rubygem is detect when running on ruby 1.9.3 and 2.0.0" do
    @check.options[:dependencies]=[{:name=>"puppet", :version=>'2.7.20'}]
    @check.options[:detected_ruby] = {:engine=>"ruby", :version=>"1.9.3", :patchlevel=>"p342"}
    @check.vuln?.should   be_true
  end
  it "is ignored if only vulnerable version of puppet rubygem has been found" do 
    @check.options[:detected_ruby] = {:engine=>"ruby", :version=>"1.8.7", :patchlevel=>"p358"}
    @check.vuln?.should   be_false
  end

  it "is ignored if only the vulnerable ruby interpreter version has been found" do
    @check.options[:dependencies]=[{:name=>"puppet", :version=>'8.7.21'}]
    @check.options[:detected_ruby] = {:engine=>"ruby", :version=>"1.9.3", :patchlevel=>"p342"}
    # @check.dump_status
    @check.vuln?.should   be_false
  end

  it "is ignored if none of the prerequisites have been met" do
    @check.options[:dependencies]=[{:name=>"puppet", :version=>'8.7.21'}]
    @check.options[:detected_ruby] = {:engine=>"ruby", :version=>"1.8.7", :patchlevel=>"p342"}
    # @check.dump_status
    @check.vuln?.should   be_false
  end
end
