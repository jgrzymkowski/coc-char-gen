class Dg::SkillSetsController < ApplicationController
  expose(:character) do
    params.permit(:character_id)[:character_id] &&
      Dg::Character.find(params.permit(:character_id)[:character_id])
  end

  def new
    authorize(Dg::SkillSet, :new?)
    @skill_set = Dg::SkillSet.new(YAML.load_file('app/resources/dg_skill_sets.yml'))
    @base_skills = JSON.parse(File.read('app/resources/dg_base_skills.json'))
    @skill_packages = JSON.parse(File.read('app/resources/dg_skill_packages.json'))
    @occupation_skills = JSON.parse(File.read('app/resources/dg_occupation_skills.json'))
  end

  def edit
    authorize(character.skill_set)
  end

  def update
    character.dg_skill_set.update(skill_set_params)
    redirect_to dg_character_path(character)
  end

  def create
    authorize(Dg::SkillSet, :create?)
    attributes = skill_set_params.inject({}) do |mem, k_v|
      if k_v.first =~ /_\d/ && k_v.last == 0
        mem
      else
        mem.merge(k_v.first => k_v.last)
      end
    end
    puts '*'*100
    puts attributes.inspect
    character.create_dg_skill_set(attributes)
    redirect_to dg_character_path(character)
  end

  def skill_set_params
    skill_set_params = params.require(:dg_skill_set).
      permit(:accounting,
             :alertness,
             :anthropology,
             :archeology,
             :art_1,
             :art_2,
             :art_3,
             :art_1_text,
             :art_2_text,
             :art_3_text,
             :artillery,
             :athletics,
             :bureaucracy,
             :computer_science,
             :craft_1,
             :craft_2,
             :craft_3,
             :craft_1_text,
             :craft_2_text,
             :craft_3_text,
             :criminology,
             :demolitions,
             :disguise,
             :dodge,
             :drive,
             :firearms,
             :first_aid,
             :foreign_language_1,
             :foreign_language_2,
             :foreign_language_3,
             :foreign_language_1_text,
             :foreign_language_2_text,
             :foreign_language_3_text,
             :forensics,
             :humint,
             :heavy_machinery,
             :heavy_weapons,
             :history,
             :law,
             :medicine,
             :melee_weapons,
             :military_science_1,
             :military_science_2,
             :military_science_3,
             :military_science_1_text,
             :military_science_2_text,
             :military_science_3_text,
             :navigate,
             :occult,
             :persuade,
             :pharmacy,
             :pilot_1,
             :pilot_2,
             :pilot_3,
             :pilot_1_text,
             :pilot_2_text,
             :pilot_3_text,
             :psychotherapy,
             :ride,
             :sigint,
             :science_1,
             :science_2,
             :science_3,
             :science_1_text,
             :science_2_text,
             :science_3_text,
             :search,
             :stealth,
             :surgery,
             :survival,
             :swim,
             :unarmed_combat,
             :unnatural,
             :occupation,
             :occupation_options,
             :bonus_skill_package,
             :bonds)
    skill_set_params[:bonus_skill_package_options] =
      JSON.parse(params[:dg_skill_set][:bonus_skill_package_options])
    skill_set_params
  end
end
