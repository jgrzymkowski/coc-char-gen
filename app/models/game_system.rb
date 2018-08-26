class GameSystem

  attr_reader :id, :namespace, :name

  def initialize(id:, namespace:, name:)
    @id = id
    @namespace = namespace
    @name = name
  end

  def self.all
    [
      self.new({
        id: 'call-of-cthulhu-1920',
        namespace: 'coc',
        name: 'Call of Cthulhu 1920'
      }),
      self.new({
        id: 'delta-green',
        namespace: 'dg',
        name: 'Delta Green',
      })
    ]
  end

  def self.find(id)
    all.find { |c| c.id == id }
  end

  def campaigns
    case id
    when 'call-of-cthulhu-1920'
      Coc::Campaign.all
    when 'delta-green'
      Dg::Campaign.all
    end
  end
end
