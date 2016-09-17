class RankingController < ApplicationController
  def have
    ranking "Have"
  end

  def want
    ranking "Want"
  end

  private

  def ranking(type)
    #Ownership.where(type: 'Want').group(:item_id)
    @items = Item.joins(:ownerships).where('ownerships.type = ?', type).group(:item_id).distinct.order('count(item_id) desc').limit(10)
  end
end
