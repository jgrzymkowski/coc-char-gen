module OccupationHelper

  def occupations
    YAML.load_file(Rails.root.join 'app/resources', 'occupation_skills.yaml')
  end
end