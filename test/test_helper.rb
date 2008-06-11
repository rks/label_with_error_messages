require "rubygems"

require "test/unit"

require "activesupport"
require "action_controller"
require "action_controller/test_process"
require "action_view/test_case"

begin
  require "mocha"
  require "stubba"
rescue Exception => e
  $stderr.puts "!!!\n!!! The fancy_views test cases rely on mocha (gem install mocha)\n!!!"
end