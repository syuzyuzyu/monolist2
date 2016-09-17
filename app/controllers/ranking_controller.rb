class RankingController < ApplicationController
  def have
    ranking "Have"
  end

  def want
    ranking "Want"
  end

  private

  def ranking(type)
    #posgreでNG
    #@items = Item.joins(:ownerships).where('ownerships.type = ?', type).group(:item_id).distinct.order('count(item_id) desc').limit(10)
    @items = Item.joins(:ownerships).where('ownerships.type = ?', type).group('items.id').distinct.order('count(item_id) desc').limit(10)

    #ows = Ownership.where('ownerships.type = "Wnat"')
    #@items = Item.where(ows).group(:item_id).order('count(id) desc').limit(10)
  end
end
