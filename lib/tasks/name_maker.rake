require 'csv'

namespace :name_maker do
  LATEST_YEAR = 1940
  TOP_X_PER_YEAR = 200

  @first_names_file_path = "#{Rails.root}/app/resources/baby-names.csv"

  @male_file_path = "#{Rails.root}/app/resources/male.txt"
  @female_file_path = "#{Rails.root}/app/resources/female.txt"

  desc 'Deletes the name files'
  task :clear do
    sh "rm #{@male_file_path}" if File.exists? @male_file_path
    sh "rm #{@female_file_path}" if File.exists? @female_file_path
  end

  desc 'Generates the name files'
  task :generate => :clear do
    m_names = []
    f_names = []

    puts 'Reading first names file...'
    m_last_year, f_last_year = 1700, 1700
    m_year_count, f_year_count = 0, 0
    CSV.foreach(@first_names_file_path, :headers => true) do |row|
      year = row['year'].to_i
      if year < LATEST_YEAR
        if row['sex'] =~ /b/
          if year > m_last_year
            m_year_count = 0
            m_last_year = year
          end

          if m_year_count < TOP_X_PER_YEAR
            m_names << row['name']
          end
          m_year_count += 1
        else
          if year > f_last_year
            f_year_count = 0
            m_last_year = year
          end

          if f_year_count < TOP_X_PER_YEAR
            f_names << row['name']
          end
          f_year_count += 1
        end
      end
    end

    puts 'Writing male first names...'
    m_f = File.new(@male_file_path, 'w')
    SortedSet.new(m_names).each { |n| m_f.write("#{n},")}
    m_f.close

    puts 'Writing female first names...'
    f_f = File.new(@female_file_path, 'w')
    SortedSet.new(f_names).each { |n| f_f.write("#{n},")}
    f_f.close
  end

end
