class RankingControllerController < ApplicationController
  def have
  end

  def want
    ranking "Want"
  end
  
  private
  
  def ranking(type)
    #Ownership.where(type: 'Want').group(:item_id)
    @items = Item.joins(:ownerships).where('ownerships.type = ?', 'Want').group(:item_id).order('count(item_id) desc')
  end
end
