module CharacteristicSetsHelper

  def generate_arranged_stats( characteristics )
    puts '!'*100
    puts characteristics.inspect
    create_stats_hash characteristics, generate_stats.sort!.reverse!
  end

  def generate_random_stats
    create_stats_hash characteristics_in_order, generate_stats
  end

  private
  def characteristics_in_order
    [ :strength, :dexterity, :power, :intelligence, :appearance, :constitution, :size, :education ]
  end

  def generate_stats
    [
        RandomGenerators::generate_d6_stat( 0 ),
        RandomGenerators::generate_d6_stat( 0 ),
        RandomGenerators::generate_d6_stat( 0 ),
        RandomGenerators::generate_d6_stat( 0 ),
        RandomGenerators::generate_d6_stat( 0 ),
        RandomGenerators::generate_d6_6_stat( 0 ),
        RandomGenerators::generate_d6_6_stat( 0 ),
        RandomGenerators::generate_3d6_3_stat( 0 )
    ]
  end

  def create_stats_hash( characteristics, stats )
    [characteristics, stats].transpose.inject({}) do |r, s|
      r.merge!( s[0] => s[1] )
    end
  end
end
