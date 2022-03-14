
class SpottedDog
  
  def initialize(items)
    @items = items

    @actions = [
      {
        name: "Conjured",
        quality_modifier: -2,
      },
      {
        name: "Sulfuras, Hand of Ragnaros",
        quality_modifier: 0,
        sell_in_modifier: 0
      },
      {
        name: "Backstage passes to a TAFKAL80ETC concert",
        modifier: -> (item) {
          if item.quality < 50
            item.quality = item.quality + 1
            item.quality = item.quality + 1 if item.sell_in < 11 && item.quality < 50
            item.quality = item.quality + 1 if item.sell_in < 6 && item.quality < 50
          end
          item.sell_in -= 1
          item.quality = item.quality - item.quality if item.sell_in < 0
          item
        }
      },
      {
        name: "Aged Brie",
        modifier: -> (item) {
          item.quality += 1 if item.quality < 50
          item.sell_in -= 1
          item.quality += 1 if item.sell_in < 0 && item.quality < 50
          item
        }
      },
    ]

  end

  def get_action item
    default_val = {
      quality_modifier: -1,
      sell_in_modifier: -1
    }
    action = @actions.find{|action| (action[:name].to_s == item.name)}
    default_val.merge(action || {})
  end

  def update_item item, action
    if action[:modifier]
      item = action[:modifier].call(item)
    else
      item.sell_in += action[:sell_in_modifier] || 0
      item.quality += action[:quality_modifier] || 0
      item.quality = [item.quality, 0].max
    end
  end
  

  def update_quality()
    @items.each do |item|
      action = self.get_action item
      self.update_item item, action
    end
  end
end

class Item
  attr_accessor :name, :sell_in, :quality

  def initialize(name, sell_in, quality)
    @name = name
    @sell_in = sell_in
    @quality = quality
  end

  def to_s()
    "#{@name}, #{@sell_in}, #{@quality}"
  end
end