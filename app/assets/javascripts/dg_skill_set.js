if( !('Dg' in window ) ) { Dg = {}; }
if( !Dg.OccupationSkill ) { Dg.OccupationSkill= {}; }
if( !Dg.BaseSkillValues ) { Dg.BaseSkillValues= {}; }
if( !Dg.SkillPackages ) { Dg.SkillPackages= {}; }
if( !Dg.OccupationSkills ) { Dg.OccupationSkills= {}; }

Dg.OccupationSkill = function() {
  this.occupation = {}
  this.skillPackage = []
  this.chosenOptions = []
  this.packageOptions = {}
}

Dg.OccupationSkill.prototype = {
  setOccupation: function(occupationId) {
    this.occupation = Dg.OccupationSkills[occupationId] || {}
    this.chosenOptions = []
  },

  setSkillPackage: function(skillPackageName) {
    this.skillPackage = Dg.SkillPackages[skillPackageName] || []
    this.packageOptions = {}
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

  selectPackageOption(i, option) {
    this.packageOptions[i] = option
  },

  getValues: function() {
    const baseSkills = _.reduce(Dg.BaseSkillValues, (mem, percentage, id) => {
      mem[id] = { additions: [], value: percentage }
      return mem
    }, {})

    $(this.occupation.skills).each( (i, skill) => {
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

    $(_.map(this.skillPackage, (sp) => sp.id).concat(_.values(this.packageOptions))).each( (index, skill) => {
      if(baseSkills[`${skill}_1`]) {
        const level = _.min([1,2,3], (i) => {
          return baseSkills[`${skill}_${i}`].additions.length
        })
        baseSkills[`${skill}_${level}`].additions.push(20)
      } else if(baseSkills[skill]) {
        baseSkills[skill].additions.push(20)
      } else {
        console.log("Found: " + skill)
      }
    })

    return {
      skills: baseSkills,
      occupation: this.occupation,
      skillPackage: this.skillPackage,
      chosenOptions: this.chosenOptions,
      packageOptions: this.packageOptions
    }
  }
}

Dg.BaseSkillValues = { "accounting": 10, "alertness": 20, "anthropology": 0, "archeology": 0, "art_1": 0, "art_2": 0, "art_3": 0, "artillery": 0, "athletics": 30, "bureaucracy": 10, "computer_science": 0, "craft_1": 0, "craft_2": 0, "craft_3": 0, "criminology": 10, "demolitions": 0, "disguise": 10, "dodge": 30, "drive": 20, "firearms": 20, "first_aid": 10, "forensics": 0, "humint": 10, "heavy_machinery": 10, "heavy_weapons": 0, "history": 10, "law": 0, "medicine": 0, "melee_weapons": 30, "military_science_1": 0, "military_science_2": 0, "military_science_3": 0, "navigate": 10, "occult": 10, "persuade": 20, "pharmacy": 0, "pilot_1": 0, "pilot_2": 0, "pilot_3": 0, "psychotherapy": 10, "ride": 10, "sigint": 0, "science_1": 0, "science_2": 0, "science_3": 0, "search": 20, "stealth": 10, "surgery": 0, "survival": 10, "swim": 20, "unarmed_combat": 40, "unnatural": 0, "foreign_language_1": 0, "foreign_language_2": 0, "foreign_language_3": 0 }

Dg.SkillPackages = {"Artist, actor, or musician":[{"skill":"Alertness","id":"alertness"},{"skill":"Craft","id":"craft"},{"skill":"Disguise","id":"disguise"},{"skill":"Persuade","id":"persuade"},{"skill":"Art","id":"art"},{"skill":"Art","id":"art"},{"skill":"Art","id":"art"},{"skill":"Humint","id":"humint"}],"Athlete":[{"skill":"Alertness","id":"alertness"},{"skill":"Athletics","id":"athletics"},{"skill":"Dodge","id":"dodge"},{"skill":"First Aid","id":"first_aid"},{"skill":"Humint","id":"humint"},{"skill":"Persuade","id":"persuade"},{"skill":"Swim","id":"swim"},{"skill":"Unarmed Combat","id":"unarmed_combat"}],"Author, editor, or journalist":[{"skill":"Anthropology","id":"anthropology"},{"skill":"Art","id":"art"},{"skill":"Bureaucracy","id":"bureaucracy"},{"skill":"History","id":"history"},{"skill":"Law","id":"law"},{"skill":"Occult","id":"occult"},{"skill":"Persuade","id":"persuade"},{"skill":"Humint","id":"humint"}],"“black bag” training":[{"skill":"Alertness","id":"alertness"},{"skill":"Athletics","id":"athletics"},{"skill":"Craft","id":"craft"},{"skill":"Craft","id":"craft"},{"skill":"Criminology","id":"criminology"},{"skill":"Disguise","id":"disguise"},{"skill":"Search","id":"search"},{"skill":"Stealth","id":"stealth"}],"Blue-collar worker":[{"skill":"Alertness","id":"alertness"},{"skill":"Craft","id":"craft"},{"skill":"Craft","id":"craft"},{"skill":"Drive","id":"drive"},{"skill":"First Aid","id":"first_aid"},{"skill":"Heavy Machinery","id":"heavy_machinery"},{"skill":"Navigate","id":"navigate"},{"skill":"Search","id":"search"}],"Bureaucrat":[{"skill":"Accounting","id":"accounting"},{"skill":"Bureaucracy","id":"bureaucracy"},{"skill":"Computer Science","id":"computer_science"},{"skill":"Criminology","id":"criminology"},{"skill":"Humint","id":"humint"},{"skill":"Law","id":"law"},{"skill":"Persuade","id":"persuade"},{"skill":"+1","id":"1"}],"Clergy":[{"skill":"Foreign Language","id":"foreign_language"},{"skill":"Foreign Language","id":"foreign_language"},{"skill":"Foreign Language","id":"foreign_language"},{"skill":"History","id":"history"},{"skill":"Humint","id":"humint"},{"skill":"Occult","id":"occult"},{"skill":"Persuade","id":"persuade"},{"skill":"Psychotherapy","id":"psychotherapy"}],"Combat veteran":[{"skill":"Alertness","id":"alertness"},{"skill":"Dodge","id":"dodge"},{"skill":"Firearms","id":"firearms"},{"skill":"First Aid","id":"first_aid"},{"skill":"Heavy Weapons","id":"heavy_weapons"},{"skill":"Melee Weapons","id":"melee_weapons"},{"skill":"Stealth","id":"stealth"},{"skill":"Unarmed Combat","id":"unarmed_combat"}],"Computer enthusiast or hacker":[{"skill":"Computer Science","id":"computer_science"},{"skill":"Craft","id":"craft"},{"skill":"Science","id":"science"},{"skill":"Sigint","id":"sigint"},{"skill":"+4","id":"4"}],"Counselor":[{"skill":"Bureaucracy","id":"bureaucracy"},{"skill":"First Aid","id":"first_aid"},{"skill":"Foreign Language","id":"foreign_language"},{"skill":"Humint","id":"humint"},{"skill":"Law","id":"law"},{"skill":"Persuade","id":"persuade"},{"skill":"Psychotherapy","id":"psychotherapy"},{"skill":"Search","id":"search"}],"Criminalist":[{"skill":"Accounting","id":"accounting"},{"skill":"Bureaucracy","id":"bureaucracy"},{"skill":"Computer Science","id":"computer_science"},{"skill":"Criminology","id":"criminology"},{"skill":"Forensics","id":"forensics"},{"skill":"Law","id":"law"},{"skill":"Pharmacy","id":"pharmacy"},{"skill":"Search","id":"search"}],"Firefighter":[{"skill":"Alertness","id":"alertness"},{"skill":"Demolitions","id":"demolitions"},{"skill":"Drive","id":"drive"},{"skill":"First Aid","id":"first_aid"},{"skill":"Forensics","id":"forensics"},{"skill":"Heavy Machinery","id":"heavy_machinery"},{"skill":"Navigate","id":"navigate"},{"skill":"Search","id":"search"}],"Gangster or deep cover":[{"skill":"Alertness","id":"alertness"},{"skill":"Criminology","id":"criminology"},{"skill":"Dodge","id":"dodge"},{"skill":"Drive","id":"drive"},{"skill":"Persuade","id":"persuade"},{"skill":"Stealth","id":"stealth"},{"skill":"+2","id":"2"}],"Interrogator":[{"skill":"Criminology","id":"criminology"},{"skill":"Foreign Language","id":"foreign_language"},{"skill":"Foreign Language","id":"foreign_language"},{"skill":"Humint","id":"humint"},{"skill":"Law","id":"law"},{"skill":"Persuade","id":"persuade"},{"skill":"Pharmacy","id":"pharmacy"},{"skill":"Search","id":"search"}],"Liberal arts degree":[{"skill":"Anthropology","id":"anthropology"},{"skill":"Art","id":"art"},{"skill":"Foreign Language","id":"foreign_language"},{"skill":"History","id":"history"},{"skill":"Persuade","id":"persuade"},{"skill":"+3","id":"3"}],"Military officer":[{"skill":"Bureaucracy","id":"bureaucracy"},{"skill":"Firearms","id":"firearms"},{"skill":"History","id":"history"},{"skill":"Military Science","id":"military_science"},{"skill":"Navigate","id":"navigate"},{"skill":"Persuade","id":"persuade"},{"skill":"Unarmed Combat","id":"unarmed_combat"},{"skill":"+1","id":"1"}],"Mba":[{"skill":"Accounting","id":"accounting"},{"skill":"Bureaucracy","id":"bureaucracy"},{"skill":"Humint","id":"humint"},{"skill":"Law","id":"law"},{"skill":"Persuade","id":"persuade"},{"skill":"+3","id":"3"}],"Nurse, paramedic, or pre-med":[{"skill":"Alertness","id":"alertness"},{"skill":"First Aid","id":"first_aid"},{"skill":"Medicine","id":"medicine"},{"skill":"Persuade","id":"persuade"},{"skill":"Pharmacy","id":"pharmacy"},{"skill":"Psychotherapy","id":"psychotherapy"},{"skill":"Science","id":"science"},{"skill":"Search","id":"search"}],"Occult investigator or conspiracy theorist":[{"skill":"Anthropology","id":"anthropology"},{"skill":"Archeology","id":"archeology"},{"skill":"Computer Science","id":"computer_science"},{"skill":"Criminology","id":"criminology"},{"skill":"History","id":"history"},{"skill":"Occult","id":"occult"},{"skill":"Persuade","id":"persuade"},{"skill":"Search","id":"search"}],"Outdoorsman":[{"skill":"Alertness","id":"alertness"},{"skill":"Athletics","id":"athletics"},{"skill":"Firearms","id":"firearms"},{"skill":"Navigate","id":"navigate"},{"skill":"Ride","id":"ride"},{"skill":"Search","id":"search"},{"skill":"Stealth","id":"stealth"},{"skill":"Survival","id":"survival"}],"Photographer":[{"skill":"Alertness","id":"alertness"},{"skill":"Art","id":"art"},{"skill":"Computer Science","id":"computer_science"},{"skill":"Persuade","id":"persuade"},{"skill":"Search","id":"search"},{"skill":"Stealth","id":"stealth"},{"skill":"+2","id":"2"}],"Pilot or sailor":[{"skill":"Alertness","id":"alertness"},{"skill":"Craft","id":"craft"},{"skill":"First Aid","id":"first_aid"},{"skill":"Foreign Language","id":"foreign_language"},{"skill":"Navigate","id":"navigate"},{"skill":"Pilot","id":"pilot"},{"skill":"Survival","id":"survival"},{"skill":"Swim","id":"swim"}],"Police officer":[{"skill":"Alertness","id":"alertness"},{"skill":"Criminology","id":"criminology"},{"skill":"Drive","id":"drive"},{"skill":"Firearms","id":"firearms"},{"skill":"Humint","id":"humint"},{"skill":"Law","id":"law"},{"skill":"Melee Weapons","id":"melee_weapons"},{"skill":"Unarmed Combat","id":"unarmed_combat"}],"Science grad student":[{"skill":"Bureaucracy","id":"bureaucracy"},{"skill":"Computer Use","id":"computer_use"},{"skill":"Craft","id":"craft"},{"skill":"Foreign Language","id":"foreign_language"},{"skill":"Science","id":"science"},{"skill":"Science","id":"science"},{"skill":"Science","id":"science"},{"skill":"+1","id":"1"}],"Social worker or criminal justice degree":[{"skill":"Bureaucracy","id":"bureaucracy"},{"skill":"Criminology","id":"criminology"},{"skill":"Forensics","id":"forensics"},{"skill":"Foreign Language","id":"foreign_language"},{"skill":"Humint","id":"humint"},{"skill":"Law","id":"law"},{"skill":"Persuade","id":"persuade"},{"skill":"Search","id":"search"}],"Soldier or marine":[{"skill":"Alertness","id":"alertness"},{"skill":"Artillery","id":"artillery"},{"skill":"Athletics","id":"athletics"},{"skill":"Drive","id":"drive"},{"skill":"Firearms","id":"firearms"},{"skill":"Heavy Weapons","id":"heavy_weapons"},{"skill":"Military Science","id":"military_science"},{"skill":"Unarmed Combat","id":"unarmed_combat"}],"Translator":[{"skill":"Anthropology","id":"anthropology"},{"skill":"Foreign Language","id":"foreign_language"},{"skill":"Foreign Language","id":"foreign_language"},{"skill":"Foreign Language","id":"foreign_language"},{"skill":"History","id":"history"},{"skill":"Humint","id":"humint"},{"skill":"Persuade","id":"persuade"},{"skill":"+1","id":"1"}],"Urban explorer":[{"skill":"Alertness","id":"alertness"},{"skill":"Athletics","id":"athletics"},{"skill":"Craft","id":"craft"},{"skill":"Law","id":"law"},{"skill":"Navigate","id":"navigate"},{"skill":"Persuade","id":"persuade"},{"skill":"Search","id":"search"},{"skill":"Stealth","id":"stealth"}]}

Dg.OccupationSkills = {"historian":{"id":"anthropologist","name":"Anthropologist","skills":[{"id":"anthropology","skill":"Anthropology","percentage":50},{"id":"bureaucracy","skill":"Bureaucracy","percentage":40},{"id":"foreign_language_1","skill":"Foreign Language","percentage":50,"type":""},{"id":"foreign_language_2","skill":"Foreign Language","percentage":40,"type":""},{"id":"history","skill":"History","percentage":60},{"id":"occult","skill":"Occult","percentage":40},{"id":"persuade","skill":"Persuade","percentage":40}],"options":[{"id":"anthropology","skill":"Anthropology","percentage":40},{"id":"archeology","skill":"Archeology","percentage":40},{"id":"humint","skill":"HUMINT","percentage":50},{"id":"navigate","skill":"Navigate","percentage":50},{"id":"ride","skill":"Ride","percentage":50},{"id":"search","skill":"Search","percentage":60},{"id":"survival","skill":"Survival","percentage":50}],"recommended_stats":"INT","choose":2,"bonds":4},"computer_engineer":{"id":"historian","name":"Historian","skills":[{"id":"archeology","skill":"Archeology","percentage":50},{"id":"bureaucracy","skill":"Bureaucracy","percentage":40},{"id":"foreign_language_1","skill":"Foreign Language","percentage":50,"type":""},{"id":"foreign_language_2","skill":"Foreign Language","percentage":40,"type":""},{"id":"history","skill":"History","percentage":60},{"id":"occult","skill":"Occult","percentage":40},{"id":"persuade","skill":"Persuade","percentage":40}],"options":[{"id":"anthropology","skill":"Anthropology","percentage":40},{"id":"archeology","skill":"Archeology","percentage":40},{"id":"humint","skill":"HUMINT","percentage":50},{"id":"navigate","skill":"Navigate","percentage":50},{"id":"ride","skill":"Ride","percentage":50},{"id":"search","skill":"Search","percentage":60},{"id":"survival","skill":"Survival","percentage":50}],"recommended_stats":"INT","choose":2,"bonds":4},"federal_agent":{"id":"computer_engineer","name":"Computer Engineer","skills":[{"id":"computer_science","skill":"Computer Science","percentage":60},{"id":"craft_1","skill":"Craft","percentage":30,"type":"Electrician"},{"id":"craft_2","skill":"Craft","percentage":30,"type":"Mechanic"},{"id":"craft_3","skill":"Craft","percentage":40,"type":"Microelectronics"},{"id":"science_1","skill":"Science","percentage":40,"type":"Mathematics"},{"id":"sigint","skill":"SIGINT","percentage":40}],"options":[{"id":"accounting","skill":"Accounting","percentage":50},{"id":"bureaucracy","skill":"Bureaucracy","percentage":50},{"id":"craft_4","skill":"Craft","percentage":40,"type":""},{"id":"foreign_language_1","skill":"Foreign Language","percentage":40,"type":""},{"id":"heavy_machinery","skill":"Heavy Machinery","percentage":50},{"id":"law","skill":"Law","percentage":40},{"id":"science_2","skill":"Science","percentage":40,"type":""}],"recommended_stats":"INT","choose":4,"bonds":3},"physician":{"id":"federal_agent","name":"Federal Agent","skills":[{"id":"alertness","skill":"Alertness","percentage":50},{"id":"bureaucracy","skill":"Bureaucracy","percentage":40},{"id":"criminology","skill":"Criminology","percentage":50},{"id":"drive","skill":"Drive","percentage":50},{"id":"firearms","skill":"Firearms","percentage":50},{"id":"forensics","skill":"Forensics","percentage":30},{"id":"humint","skill":"HUMINT","percentage":60},{"id":"law","skill":"Law","percentage":30},{"id":"persuade","skill":"Persuade","percentage":50},{"id":"search","skill":"Search","percentage":50},{"id":"unarmed_combat","skill":"Unarmed Combat","percentage":60}],"options":[{"id":"accounting","skill":"Accounting","percentage":60},{"id":"computer_science","skill":"Computer Science","percentage":50},{"id":"foreign_language_1","skill":"Foreign Language","percentage":50,"type":""},{"id":"heavy_weapons","skill":"Heavy Weapons","percentage":50},{"id":"pharmacy","skill":"Pharmacy","percentage":50}],"recommended_stats":"CON, POW, CHA","choose":1,"bonds":3},"scientist":{"id":"physician","name":"Physician","skills":[{"id":"bureaucracy","skill":"Bureaucracy","percentage":50},{"id":"first_aid","skill":"First Aid","percentage":60},{"id":"medicine","skill":"Medicine","percentage":60},{"id":"persuade","skill":"Persuade","percentage":40},{"id":"pharmacy","skill":"Pharmacy","percentage":50},{"id":"science_1","skill":"Science","percentage":60,"type":"Biology"},{"id":"search","skill":"Search","percentage":40}],"options":[{"id":"forensics","skill":"Forensics","percentage":50},{"id":"psychotherapy","skill":"Psychotherapy","percentage":60},{"id":"science_2","skill":"Science","percentage":50,"type":""},{"id":"surgery","skill":"Surgery","percentage":50}],"recommended_stats":"INT, POW, DEX","choose":2,"bonds":3},"special_operator":{"id":"scientist","name":"Scientist","skills":[{"id":"bureaucracy","skill":"Bureaucracy","percentage":40},{"id":"computer_science","skill":"Computer Science","percentage":40},{"id":"science_1","skill":"Science","percentage":60,"type":""},{"id":"science_2","skill":"Science","percentage":50,"type":""},{"id":"science_3","skill":"Science","percentage":50,"type":""}],"options":[{"id":"accounting","skill":"Accounting","percentage":50},{"id":"craft_1","skill":"Craft","percentage":40,"type":""},{"id":"foreign_language_1","skill":"Foreign Language","percentage":40,"type":""},{"id":"forensics","skill":"Forensics","percentage":40},{"id":"law","skill":"Law","percentage":40},{"id":"pharmacy","skill":"Pharmacy","percentage":40}],"recommended_stats":"INT","choose":3,"bonds":4}}
