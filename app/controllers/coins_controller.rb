class CoinsController < ApplicationController
  before_action :authenticate_user!

  def index
  end

  def show
    @coin = Coin.find(params[:id])
  end
end
