if( !('Dg' in window ) ) { Dg = {}; }
if( !Dg.OccupationSkill ) { Dg.OccupationSkill= {}; }
if( !Dg.BaseSkillValues ) { Dg.BaseSkillValues= {}; }
if( !Dg.OccupationSkills ) { Dg.OccupationSkills= {}; }

Dg.OccupationSkill = function() {
  this.occupation = {}
  this.skillPackage = {}
  this.chosenOptions = []
}

Dg.OccupationSkill.prototype = {
  setOccupation: function(occupationId) {
    this.occupation = Dg.OccupationSkills[occupationId] || {}
    this.chosenOptions = []
  },

  selectOption: function(option) {
    if(event.target.checked) {
      this.chosenOptions.push(option)
      if(this.chosenOptions.length > this.occupation.choose) {
        const unselected = this.chosenOptions.shift()
        $(`#option-${unselected}`).prop('checked', false)
      }
    } else {
      this.chosenOptions = _.without(this.chosenOptions, option)
    }
  },

  getValues: function() {
    const baseSkills = _.reduce(Dg.BaseSkillValues, (mem, percentage, id) => {
      mem[id] = { additions: [], value: percentage }
      return mem
    }, {})

    $(this.occupation.skills).each( (i, skill) => {
      //baseSkills[skill.id].name = skill.skill
      baseSkills[skill.id].additions.push(skill.percentage)
      if(skill.id.match(/_\d/)) {
        baseSkills[skill.id].type = skill.type
      }
    })

    $(this.chosenOptions).each( (i, id) => {
      const chosenOption = _.find(this.occupation.options, (o) => o.id == id)
      baseSkills[chosenOption.id].additions.push(chosenOption.percentage)
      if(chosenOption.id.match(/_\d/)) {
        baseSkills[chosenOption.id].type = chosenOption.type
      }
    })

    $(this.skillPackage.skills).each( (i, skill) => {
      //baseSkills[skill.id].name = skill.skill
      baseSkills[skill.id].additions.push(skill.percentage)
      if(skill.id.match(/_\d/)) {
        baseSkills[skill.id].type = skill.type
      }
    })

    return {
      skills: baseSkills,
      //occupationAddition: occupationAdditions,
      //packageAdditions: packageAdditions,
      occupation: this.occupation,
      skillPackage: this.skillPackage,
      chosenOptions: this.chosenOptions
    }
  }
}

Dg.BaseSkillValues = {
  "accounting": 10,
  "alertness": 20,
  "anthropology": 0,
  "archeology": 0,
  "art_1": 0,
  "art_2": 0,
  "art_3": 0,
  //"art_1_text": null,
  //"art_2_text": null,
  //"art_3_text": null,
  "artillery": 0,
  "athletics": 30,
  "bureaucracy": 10,
  "computer_science": 0,
  "craft_1": 0,
  "craft_2": 0,
  "craft_3": 0,
  //"craft_1_text": null,
  //"craft_2_text": null,
  //"craft_3_text": null,
  "criminology": 10,
  "demolitions": 0,
  "disguise": 10,
  "dodge": 30,
  "drive": 20,
  "firearms": 20,
  "first_aid": 10,
  "forensics": 0,
  "humint": 10,
  "heavy_machinery": 10,
  "heavy_weapons": 0,
  "history": 10,
  "law": 0,
  "medicine": 0,
  "melee_weapons": 30,
  "military_science_1": 0,
  "military_science_2": 0,
  "military_science_3": 0,
  //"military_science_1_text": null,
  //"military_science_2_text": null,
  //"military_science_3_text": null,
  "navigate": 10,
  "occult": 10,
  "persuade": 20,
  "pharmacy": 0,
  "pilot_1": 0,
  "pilot_2": 0,
  "pilot_3": 0,
  //"pilot_1_text": null,
  //"pilot_2_text": null,
  //"pilot_3_text": null,
  "psychotherapy": 10,
  "ride": 10,
  "sigint": 0,
  "science_1": 0,
  "science_2": 0,
  "science_3": 0,
  //"science_1_text": null,
  //"science_2_text": null,
  //"science_3_text": null,
  "search": 20,
  "stealth": 10,
  "surgery": 0,
  "survival": 10,
  "swim": 20,
  "unarmed_combat": 40,
  "unnatural": 0,
  "foreign_language_1": 0,
  "foreign_language_2": 0,
  "foreign_language_3": 0,
  //"foreign_language_1_text": null,
  //"foreign_language_2_text": null,
  //"foreign_language_3_text": null
}

Dg.OccupationSkills = {"historian":{"id":"anthropologist","name":"Anthropologist","skills":[{"id":"anthropology","skill":"Anthropology","percentage":50},{"id":"bureaucracy","skill":"Bureaucracy","percentage":40},{"id":"foreign_language_1","skill":"Foreign Language","percentage":50,"type":""},{"id":"foreign_language_2","skill":"Foreign Language","percentage":40,"type":""},{"id":"history","skill":"History","percentage":60},{"id":"occult","skill":"Occult","percentage":40},{"id":"persuade","skill":"Persuade","percentage":40}],"options":[{"id":"anthropology","skill":"Anthropology","percentage":40},{"id":"archeology","skill":"Archeology","percentage":40},{"id":"humint","skill":"HUMINT","percentage":50},{"id":"navigate","skill":"Navigate","percentage":50},{"id":"ride","skill":"Ride","percentage":50},{"id":"search","skill":"Search","percentage":60},{"id":"survival","skill":"Survival","percentage":50}],"recommended_stats":"INT","choose":2,"bonds":4},"computer_engineer":{"id":"historian","name":"Historian","skills":[{"id":"archeology","skill":"Archeology","percentage":50},{"id":"bureaucracy","skill":"Bureaucracy","percentage":40},{"id":"foreign_language_1","skill":"Foreign Language","percentage":50,"type":""},{"id":"foreign_language_2","skill":"Foreign Language","percentage":40,"type":""},{"id":"history","skill":"History","percentage":60},{"id":"occult","skill":"Occult","percentage":40},{"id":"persuade","skill":"Persuade","percentage":40}],"options":[{"id":"anthropology","skill":"Anthropology","percentage":40},{"id":"archeology","skill":"Archeology","percentage":40},{"id":"humint","skill":"HUMINT","percentage":50},{"id":"navigate","skill":"Navigate","percentage":50},{"id":"ride","skill":"Ride","percentage":50},{"id":"search","skill":"Search","percentage":60},{"id":"survival","skill":"Survival","percentage":50}],"recommended_stats":"INT","choose":2,"bonds":4},"federal_agent":{"id":"computer_engineer","name":"Computer Engineer","skills":[{"id":"computer_science","skill":"Computer Science","percentage":60},{"id":"craft_1","skill":"Craft","percentage":30,"type":"Electrician"},{"id":"craft_2","skill":"Craft","percentage":30,"type":"Mechanic"},{"id":"craft_3","skill":"Craft","percentage":40,"type":"Microelectronics"},{"id":"science_1","skill":"Science","percentage":40,"type":"Mathematics"},{"id":"sigint","skill":"SIGINT","percentage":40}],"options":[{"id":"accounting","skill":"Accounting","percentage":50},{"id":"bureaucracy","skill":"Bureaucracy","percentage":50},{"id":"craft_4","skill":"Craft","percentage":40,"type":""},{"id":"foreign_language_1","skill":"Foreign Language","percentage":40,"type":""},{"id":"heavy_machinery","skill":"Heavy Machinery","percentage":50},{"id":"law","skill":"Law","percentage":40},{"id":"science_2","skill":"Science","percentage":40,"type":""}],"recommended_stats":"INT","choose":4,"bonds":3},"physician":{"id":"federal_agent","name":"Federal Agent","skills":[{"id":"alertness","skill":"Alertness","percentage":50},{"id":"bureaucracy","skill":"Bureaucracy","percentage":40},{"id":"criminology","skill":"Criminology","percentage":50},{"id":"drive","skill":"Drive","percentage":50},{"id":"firearms","skill":"Firearms","percentage":50},{"id":"forensics","skill":"Forensics","percentage":30},{"id":"humint","skill":"HUMINT","percentage":60},{"id":"law","skill":"Law","percentage":30},{"id":"persuade","skill":"Persuade","percentage":50},{"id":"search","skill":"Search","percentage":50},{"id":"unarmed_combat","skill":"Unarmed Combat","percentage":60}],"options":[{"id":"accounting","skill":"Accounting","percentage":60},{"id":"computer_science","skill":"Computer Science","percentage":50},{"id":"foreign_language_1","skill":"Foreign Language","percentage":50,"type":""},{"id":"heavy_weapons","skill":"Heavy Weapons","percentage":50},{"id":"pharmacy","skill":"Pharmacy","percentage":50}],"recommended_stats":"CON, POW, CHA","choose":1,"bonds":3},"scientist":{"id":"physician","name":"Physician","skills":[{"id":"bureaucracy","skill":"Bureaucracy","percentage":50},{"id":"first_aid","skill":"First Aid","percentage":60},{"id":"medicine","skill":"Medicine","percentage":60},{"id":"persuade","skill":"Persuade","percentage":40},{"id":"pharmacy","skill":"Pharmacy","percentage":50},{"id":"science_1","skill":"Science","percentage":60,"type":"Biology"},{"id":"search","skill":"Search","percentage":40}],"options":[{"id":"forensics","skill":"Forensics","percentage":50},{"id":"psychotherapy","skill":"Psychotherapy","percentage":60},{"id":"science_2","skill":"Science","percentage":50,"type":""},{"id":"surgery","skill":"Surgery","percentage":50}],"recommended_stats":"INT, POW, DEX","choose":2,"bonds":3},"special_operator":{"id":"scientist","name":"Scientist","skills":[{"id":"bureaucracy","skill":"Bureaucracy","percentage":40},{"id":"computer_science","skill":"Computer Science","percentage":40},{"id":"science_1","skill":"Science","percentage":60,"type":""},{"id":"science_2","skill":"Science","percentage":50,"type":""},{"id":"science_3","skill":"Science","percentage":50,"type":""}],"options":[{"id":"accounting","skill":"Accounting","percentage":50},{"id":"craft_1","skill":"Craft","percentage":40,"type":""},{"id":"foreign_language_1","skill":"Foreign Language","percentage":40,"type":""},{"id":"forensics","skill":"Forensics","percentage":40},{"id":"law","skill":"Law","percentage":40},{"id":"pharmacy","skill":"Pharmacy","percentage":40}],"recommended_stats":"INT","choose":3,"bonds":4}}
