module Coc::OccupationHelper
  def occupations
    YAML.load_file(Rails.root.join 'app/resources', 'occupation_skills.yml')
  end

  def occupations_json
    occupations.to_json.html_safe
  end
end
