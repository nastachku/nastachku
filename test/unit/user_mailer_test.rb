# -*- coding: utf-8 -*-
require 'test_helper'

class UserMailerTest < ActionMailer::TestCase
  test "send" do
    #FIXME добавить factories :email
    @email = create :mail_params
    @user = create :user
    @token = "ABCDE"
    assert_equal @user.email, UserMailer.conference_is_open(@user, @token, @email).to[0]
    assert_equal @email[:subject], UserMailer.conference_is_open(@user, @token, @email).subject
  end

end
