module RandomGenerators
  def self.generate_3d6_3_stat( modifier )
    d6 + d6 + d6 + 3 + ( modifier )
  end

  def self.generate_d6_6_stat( modifier )
    d6 + d6 + 6 + ( modifier )
  end

  def self.generate_d6_stat( modifier )
    d6 + d6 + d6 + ( modifier )
  end

  def self.d6
    ( rand * 6 ).to_i + 1
  end
end