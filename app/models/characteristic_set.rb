require 'random_generator'

class CharacteristicSet < ActiveRecord::Base
  belongs_to :character
  attr_accessible :strength,
                  :dexterity,
                  :intelligence,
                  :constitution,
                  :appearance,
                  :power,
                  :size,
                  :education


  #def initialize(options)
  #  puts options.inspect
  #  modifiers = options ? options.dup.delete_if { |k, v| k == :age } : {}
  #
  #  raise "Invalid Modifiers: #{modifiers.values}" unless verify_modifiers modifiers
  #
  #  @strength = RandomGenerators::generate_d6_stat( modifiers[:strength] || 0 )
  #  @dexterity = RandomGenerators::generate_d6_stat( modifiers[:strength] || 0 )
  #  @constitution = RandomGenerators::generate_d6_stat( modifiers[:constitution] || 0 )
  #  @appearance = RandomGenerators::generate_d6_stat( modifiers[:appearance] || 0 )
  #  @power = RandomGenerators::generate_d6_stat( modifiers[:power] || 0 )
  #
  #  @intelligence = RandomGenerators::generate_d6_6_stat( modifiers[:intelligence] || 0 )
  #  @size = RandomGenerators::generate_d6_6_stat( modifiers[:intelligence] || 0 )
  #
  #  generate_education( options )
  #end
  #
  #private
  #def verify_modifiers( options )
  #  options.empty? || options.values.reduce( :+ ) == 0
  #end
  #
  #def generate_education( options )
  #  raise 'Must provide an age for characteristics' unless options[:age]
  #
  #  @education = RandomGenerators::generate_3d6_3_stat( options[:education] || 0 )
  #  if @education > options[:age] - 6
  #    @education = options[:age] + 6
  #  else
  #    age_bonus = (options[:age] - 6 - @education) / 10
  #    @education += age_bonus
  #  end
  #
  #end

  #rgs = {}
  #
  #ARGV.each do |a|
  #  args[a.split('=')[0]] = a.split('=')[1].to_i
  #end
  #
  #def d6
  #  (rand*6).to_i + 1
  #end
  #
  #STR = args['STR'] || (d6 + d6 + d6)
  #DEX = args['DEX'] || (d6 + d6 + d6)
  #INT = args['INT'] || (d6 + d6 + 6)
  #CON = args['CON'] || (d6 + d6 + d6)
  #APP = args['APP'] || (d6 + d6 + d6)
  #POW = args['POW'] || (d6 + d6 + d6)
  #SIZ = args['SIZ'] || (d6 + d6 + 6)
  #SAN = POW*5
  #EDU = args['EDU'] || (d6 + d6 + d6)
  #IDEA = INT*5
  #KNOW = EDU*5
  #LUCK = POW*5
  #DamageBonus = STR+SIZ
  #HitPoints = (((CON+SIZ).to_f/2)+0.5).to_i
  #MagicPoints = POW
  #SanityPoints = SAN
  #OccupationPoints = EDU*20
  #PersonalInterestPoints = INT*10
end