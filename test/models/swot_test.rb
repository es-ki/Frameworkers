require "test_helper"

class SwotTest < ActiveSupport::TestCase
  test "全てのフィールドが空の場合は保存できない" do
    assert_no_difference -> { Swot.count } do
      swot = swots(:one)
      assert_not swot.valid?
      assert_includes swot.errors[:base], "1つ以上の項目の入力が必要です。"
      swot.save
    end
  end

  test "1つの項目に入力がある場合は保存できる" do
    assert_difference -> { Swot.count }, 1 do
      project = projects(:one)
      swot = Swot.new(project: project, strength: "test")
      assert swot.valid?
      swot.save
    end
  end
end
