module NameMaker

  def self.male_name_2010
    find_name 'male-2010.txt'
  end

  def self.female_name_2010
    find_name 'female-2010.txt'
  end

  def self.surname_2010
    find_name 'surname-2010.txt'
  end

  def self.male_name_1920
    find_name 'male-1920.txt'
  end

  def self.female_name_1920
    find_name 'female-1920.txt'
  end

  def self.surname_1920
    find_name 'surname-1920.txt'
  end

  def self.city
    lines = IO.read( self.file_path( 'cities.txt' ) ).split(';')
    lines[(lines.count*rand).to_i]
  end

  def self.date_of_birth
    max_age = 75
    min_age = 18
    days = 365*(max_age-min_age) + (max_age-min_age/4).to_i
    ((rand*days).to_i.days.ago - min_age.years).to_date
  end

  def self.find_name( filename )
    lines = IO.read( self.file_path( filename ) ).split(',')
    lines[(lines.count*rand).to_i]
  end

  def self.file_path( filename )
    "#{Rails.root}/app/resources/#{filename}"
  end

  #def self.generate_names( end_year, upper_bound )
  #  file = File.new( file_path( 'baby-names.csv' ), 'r')
  #  male_names = []
  #  female_names = []
  #  file.gets
  #
  #  m_last_year = 1870
  #  m_year_count = 0
  #  f_last_year = 1870
  #  f_year_count = 0
  #
  #  while (line = file.gets)
  #    els = line.split(',')
  #    name = els[1].gsub(/"/, '')
  #
  #    year = els[0].to_i
  #    if year < end_year
  #
  #      if els[3] =~ /g/
  #        if year > f_last_year
  #          f_last_year = year
  #          f_year_count = 0
  #        end
  #        f_year_count += 1
  #        if f_year_count < upper_bound
  #          female_names << name
  #        end
  #
  #      else
  #        if year > m_last_year
  #          m_last_year = year
  #          m_year_count = 0
  #        end
  #        m_year_count += 1
  #        if m_year_count < upper_bound
  #          male_names << name
  #        end
  #      end
  #    end
  #  end
  #  file.close
  #
  #  male_file = File.new(file_path('male.txt'), 'w')
  #  SortedSet.new( male_names ).each do |name|
  #    male_file.write( "#{name},")
  #  end
  #  male_file.close
  #
  #  female_file = File.new( file_path('female.txt'), 'w')
  #  SortedSet.new( female_names ).each do |name|
  #    female_file.write( "#{name},")
  #  end
  #  female_file.close
  #end


end
