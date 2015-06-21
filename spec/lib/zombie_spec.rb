require "spec_helper"
require "zombie"
describe Zombie do
it "is named Ash" do
zombie=Zombie.new
zombie.name.should == "Ash"
end
end
