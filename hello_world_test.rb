require 'minitest/autorun'
require_relative 'hello_world'

class HelloWorldTest < Minitest::Test
  def test__name_given__says_hello_name
    hello_world = HelloWorld.new
    assert hello_world.greet("Suzie") == "Hello, Suzie! I'm Ruby!"
  end
end
