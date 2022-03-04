require 'test_helper'

class TrnWipStocksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @trn_wip_stock = trn_wip_stocks(:one)
  end

  test "should get index" do
    get trn_wip_stocks_url, as: :json
    assert_response :success
  end

  test "should create trn_wip_stock" do
    assert_difference('TrnWipStock.count') do
      post trn_wip_stocks_url, params: { trn_wip_stock: {  } }, as: :json
    end

    assert_response 201
  end

  test "should show trn_wip_stock" do
    get trn_wip_stock_url(@trn_wip_stock), as: :json
    assert_response :success
  end

  test "should update trn_wip_stock" do
    patch trn_wip_stock_url(@trn_wip_stock), params: { trn_wip_stock: {  } }, as: :json
    assert_response 200
  end

  test "should destroy trn_wip_stock" do
    assert_difference('TrnWipStock.count', -1) do
      delete trn_wip_stock_url(@trn_wip_stock), as: :json
    end

    assert_response 204
  end
end
