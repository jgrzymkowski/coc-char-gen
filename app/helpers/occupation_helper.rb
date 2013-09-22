module OccupationHelper

  def sym_to_title sym
    sym.to_s.split('_').collect { |t| t.capitalize}.join(' ')
  end

  def occupations
    YAML.load_file(Rails.root.join 'app/resources', 'occupation_skills.yaml')
  end

  def occupations_json
    occupations.to_json.html_safe
  end
end