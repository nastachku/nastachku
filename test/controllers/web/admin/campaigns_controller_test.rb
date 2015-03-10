require 'test_helper'

class Web::Admin::CampaignsControllerTest < ActionController::TestCase
  def setup
    admin = create :admin

    sign_in admin

    @campaign = create :campaign
  end

  test 'GET #index' do
    get :index

    assert_response :success
  end

  test 'GET #new' do
    get :new

    assert_response :success
  end

  test 'POST #create' do
    attrs = attributes_for :campaign
    post :create, campaign: attrs

    assert_response :redirect
    assert { Campaign.exists?(name: attrs[:name]) }
  end

  test 'GET #edit' do
    get :edit, id: @campaign.id

    assert_response :success
  end

  test 'PUT #update' do
    params = attributes_for :campaign

    put :update, id: @campaign.id, campaign: params

    @campaign.reload

    assert_response :redirect
    assert { @campaign.name == params[:name] }
  end

  test 'DELETE #destroy' do
    delete :destroy, id: @campaign.id

    assert_response :redirect
    assert { !Campaign.exists?(id: @campaign.id) }
  end
end
