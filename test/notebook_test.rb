require "test_helper"

class PryDocNotebookTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::PryDocNotebook::VERSION
  end
end
