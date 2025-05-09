class HomeController < ApplicationController
  def index
  end
	
	def test_back
	end

  def airdrop
    @airdrops = Airdrop.home_airdrops
  end

  def fund
    @funds = Fund.home_funds 
  end
end
