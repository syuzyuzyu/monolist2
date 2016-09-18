class RankingController < ApplicationController
  def have
    ranking = Have.group(:item_id).order('count_item_id desc').limit(10).count('item_id')
    item_ids = ranking.keys
    @items = Item.find(item_ids).sort_by{|o| item_ids.index(o.id)}
  end

  def want
    ranking = Want.group(:item_id).order('count_item_id desc').limit(10).count('item_id')
    item_ids = ranking.keys
    @items = Item.find(item_ids).sort_by{|o| item_ids.index(o.id)}
  end

  private

  def ranking(type)
    #postgreでNG
    #@items = Item.joins(:ownerships).where('ownerships.type = ?', type).group(:item_id).distinct.order('count(item_id) desc').limit(10)
    @items = Item.find_by_sql(['SELECT DISTINCT "items".*, count FROM "items" INNER JOIN ( select "item_id", count(item_id) as count from "ownerships"  WHERE (ownerships.type = ?) GROUP BY "item_id" ) "rank" ON "rank"."item_id" = "items"."id" ORDER BY "count" desc limit 10', type])
  end
  
  #privateメソッドでランキングを表示する場合
  def set_params(type)
    #ealの引数に文字列を与えると、クラスがnewされるg
    ranking = eval(type).group(:item_id).order('count_item_id desc').limit(10).count('item_id')#countメソッドでハッシュになる
    #{5=>12, 1=>11, 2=>10, 3=>9, 8=>9, 9=>7, 10=>6, 11=>5, 4=>4, 6=>3} 
    item_ids = ranking.keys
    @items = Item.find(item_ids).sort_by{|o| item_ids.index(o.id)}
  end
end

#ranking = Have.group(:item_id).order('count_item_id desc').limit(10).count('item_id')
#item_ids = ranking.keys
#@items = Item.find(item_ids).sort_by{|o| item_ids.index(o.id)}