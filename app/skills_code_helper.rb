def parse_skill(line, ms)
  parts = line.split(' ')
  percentage = parts.pop
  type = nil
  if parts.last.last == ')'
    type = parts.pop
    if type == '(choose)'
      type = ''
    else
      type = type[1,type.length-2]
    end
  end
  skill = parts.join(' ')
  id = skill.parameterize.underscore
  if ms.has_key?(id)
    ms[id] += 1
    id = "#{id}_#{ms[id]}"
  end
  sk = {
    id: id,
    skill: skill,
    percentage: percentage.to_i
  }
  sk[:type] = type if type
  sk
end

def multi_skills
  {
    'art' => 0,
    'craft' => 0,
    'military_science' => 0,
    'pilot' => 0,
    'science' => 0,
    'foreign_language' => 0
  }
end

def do_thing
  occupations = {}
  occ = nil
  professional = false
  ms = multi_skills

  File.readlines('occupations.txt').each do |line|
    if line.starts_with?('NAME')
      name = line.split('NAME: ').last.strip
      id = name.parameterize.underscore
      occupations[id] = occ if occ
      ms = multi_skills
      occ = {
        id: id,
        name: name,
        skills: [],
        options: []
      }
    elsif line.starts_with?('RECOMMENDED')
      occ[:recommended_stats] = line.split('RECOMMENDED STATS: ').last.strip
    elsif line.starts_with?('BONDS')
      occ[:bonds] = line.split('BONDS: ').last.strip.to_i
    elsif line.starts_with?('PROFESSIONAL')
      professional = true
    elsif line.starts_with?('CHOOSE')
      occ[:choose] = line.split('CHOOSE: ').last.strip.to_i
      professional = false
    elsif professional
      occ[:skills] << parse_skill(line, ms)
    else
      occ[:options] << parse_skill(line, ms)
    end
  end
  puts JSON.pretty_generate(occupations)
  puts occupations.to_json
end
