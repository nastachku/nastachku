require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase
  test "markdown" do
    content = generate :string
    markdown content
  end

  test "nl2br" do
    content = generate :string
    markdown content
  end

  test "dropdown" do
    args = { name: "Dropdow", items: [ { name: "Good", url: "http://nastachku.ru" } ] }
    dropdown args
  end
end
