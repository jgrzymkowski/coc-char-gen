class Dg::SkillSetsController < ApplicationController
  expose(:character) do
    params.permit(:character_id)[:character_id] &&
      Dg::Character.find(params.permit(:character_id)[:character_id])
  end

  def new
    authorize(Dg::SkillSet, :new?)
    @skill_set = Dg::SkillSet.new(YAML.load_file('app/resources/dg_skill_sets.yml'))
    @skill_occupations = JSON.parse(File.read('app/resources/dg-occupation-skills.json'))
  end

  def create
    authorize(Dg::SkillSet, :create?)
    character.create_dg_skill_set(skill_set_params)
    redirect_to dg_character_path(character)
  end

  #count = 0
  #YAML.load_file('app/resources/dg_skill_sets.yml').keys.each do |attr|
    #count += 1
    #if attr =~ /_1/
      #count += 1
      #str = <<STR
     #<tr>
        #<td>
      ##{attr.split('_')[0].humanize.capitalize}
        #</td>
        #<td></td>
      #</tr>
     #<tr>
        #<td id="#{attr}_text">
      ##{attr.humanize.capitalize}
          #<%= f.hidden_field :#{attr} %>
          #<%= f.hidden_field :#{attr}_text %>
        #</td>
        #<td id="#{attr}">
          #<%= skill_set.#{attr} %>%
        #</td>
      #</tr>
#STR
    #elsif attr =~ /_2/ || attr =~ /_3/
      #str = <<STR
      #<tr>
        #<td id="#{attr}_text">
      ##{attr.humanize.capitalize}
          #<%= f.hidden_field :#{attr} %>
          #<%= f.hidden_field :#{attr}_text %>
        #</td>
        #<td id="#{attr}">
          #<%= skill_set.#{attr} %>%
        #</td>
      #</tr>
#STR
    #else
      #str = <<STR
     #<tr>
        #<td>
      ##{attr.humanize.capitalize}
          #<%= f.hidden_field :#{attr} %>
        #</td>
        #<td id="#{attr}">
          #<%= skill_set.#{attr} %>%
        #</td>
      #</tr>
#STR
    #end


      #puts str
    #end

    def skill_set_params
      params.require(:skill_set).permit(:accounting,
                                        :alertness,
                                        :anthropology,
                                        :archeology,
                                        :art,
                                        :artillery,
                                        :athletics,
                                        :bureaucracy,
                                        :computer_science,
                                        :craft,
                                        :criminology,
                                        :demolitions,
                                        :disguise,
                                        :dodge,
                                        :drive,
                                        :firearms,
                                        :first_aid,
                                        :forensics,
                                        :humint,
                                        :heavy_machinery,
                                        :heavy_weapons,
                                        :history,
                                        :law,
                                        :medicine,
                                        :melee_weapons,
                                        :military_science,
                                        :navigate,
                                        :occult,
                                        :persuade,
                                        :pharmacy,
                                        :pilot,
                                        :psychotherapy,
                                        :ride,
                                        :sigint,
                                        :science,
                                        :search,
                                        :stealth,
                                        :surgery,
                                        :survival,
                                        :swim,
                                        :unarmed_combat,
                                        :unnatural)
    end
  end
