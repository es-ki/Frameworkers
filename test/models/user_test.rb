require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "既存のユーザーをuidで見つけられる" do
    user = users(:one)
    auth_hash = OmniAuth::AuthHash.new(uid: user.uid, info: { email: user.email })

    result = User.find_or_create_from_auth_hash(auth_hash)

    assert_equal user, result
  end

  test "新しいユーザーを作成するとデフォルトプロジェクトを作成される" do
    auth_hash = OmniAuth::AuthHash.new(uid: "new", info: { email: "new@example.com" })

    assert_difference -> { User.count }, 1 do
      assert_difference -> { Project.count }, 1 do
        user = User.find_or_create_from_auth_hash(auth_hash)
        assert_equal "new@example.com", user.email
        assert_equal "新規プロジェクト", user.projects.first.name
      end
    end
  end

  test "無効なユーザーデータの場合は例外が発生する" do
    auth_hash = OmniAuth::AuthHash.new(uid: nil, info: { email: nil })

    assert_no_difference -> { Project.count } do
      assert_raises(ActiveRecord::RecordInvalid) do
        User.find_or_create_from_auth_hash(auth_hash)
      end
    end
  end

  test "無効なプロジェクトデータの場合は例外が発生する" do
    auth_hash = OmniAuth::AuthHash.new(uid: "new", info: { email: "new@example.com" })
    User.any_instance.stubs(:create_default_project).raises(ActiveRecord::RecordInvalid.new(Project.new))

    assert_no_difference -> { User.count } do
      assert_raises(ActiveRecord::RecordInvalid) do
        User.find_or_create_from_auth_hash(auth_hash)
      end
    end
  end
end
