class RankingController < ApplicationController
  def have
    ranking "Have"
  end

  def want
    ranking "Want"
  end

  private

  def ranking(type)
    #postgreでNG
    #@items = Item.joins(:ownerships).where('ownerships.type = ?', type).group(:item_id).distinct.order('count(item_id) desc').limit(10)

    @items = Item.find_by_sql(['SELECT DISTINCT "items".* FROM "items" INNER JOIN "ownerships" ON "ownerships"."item_id" = "items"."id" WHERE (ownerships.type = ?) GROUP BY "item_id"  ORDER BY count(item_id) desc limit 10', type])
    
    #ows = Ownership.where('ownerships.type = "Wnat"')
    #@items = Item.where(ows).group(:item_id).order('count(id) desc').limit(10)
  end
end
