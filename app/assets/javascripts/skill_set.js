if( !('CoC' in window ) ) { CoC = {}; }
if( !CoC.SkillTable ) { CoC.SkillTable= {}; }
if( !CoC.OccupationalSkillList ) { CoC.OccupationalSkillList= {}; }
if( !CoC.SkillPointTracker ) { CoC.SkillPointTracker= {}; }

//$(window).load(function() {
//  _.each($('input.skill-input'), function(input) {
//    $(input).change(updateSkill);
//  });
//});
//
//var updateSkill = function(event) {
//  var input = $(event.target);
//  var inputTd = input.parent('td');
//  var titleTd = inputTd.siblings('td.' + skill + '-title')
//  var skill = titleTd.attr('skill');
//  var totalTd = inputTd.siblings('td.' + skill + '-total');
//  if( input.val() ) {
//    totalTd.html(Number(input.val()) + Number(titleTd.attr('base')));
//  } else {
//    totalTd.html('');
//  }
//};
//
//var updateOccupation = function(event) {
//
//};

CoC.SkillPointTracker = function(options) {
  this.occupationalSkillTableId = options.occupationalSkillTableId
  this.skillTableId = options.skillTableId;
  this.occTotalId = options.occTotalId;
  this.piTotalId = options.piTotalId;
};

CoC.SkillPointTracker.prototype = {
  update: function() {
    var self = this;
    var occupationalSkillTable = $('#'+self.occupationalSkillTableId);
    var skillTable = $('#'+self.skillTableId );
    var occTotal = $('#'+self.occTotalId);
    var piTotal = $('#'+self.piTotalId);
    var occupationalSkills = _.map(
      $('td', occupationalSkillTable), function(td) {
        return $(td).attr('skill')
      }
    );

    var spentSkillInputs = _.filter($('input.skill-input', skillTable), function(input) {
      return $(input).val() != '';
    });

    occTotal.html(occTotal.attr('original'));
    piTotal.html(piTotal.attr('original'));

    _.each(spentSkillInputs, function(input) {
      var skill = $(input).parents('td').attr('skill');
      if(_.include(occupationalSkills, skill)) {
        occTotal.html(
          parseInt(occTotal.html()) - parseInt($(input).val())
        );
      } else {
        piTotal.html(
          parseInt(piTotal.html()) - parseInt($(input).val())
        );
      }
    } );
  }
};

CoC.SkillTable = function(options) {
  this.table = $('#'+options.tableId);
  this.allSkills = options.allSkills;
  this.skillCategories = options.skillCategories;
  this.pointTracker = options.pointTracker;
  this.buildTable();
};

CoC.SkillTable.prototype = {
  buildTable: function() {
//    var self = this;
//    var skillCategoryNames = _.map(self.skillCategories, function(sc) { return sc[0]} );
//    _.each(self.allSkills, function( skillPair ) {
//      var skillName = skillPair[0];
//      var skillBase = skillPair[1];
//      var skillNameTd = $('<td>').append(CoC.humanize_sym(skillName));
//      var skillBaseTd = $('<td class="skill_base">').append(skillBase);
//      var skillTotalTd = $('<td class="skill_total">');
//
//      if(_.contains(skillCategoryNames, skillName)) {
//        self.table.append( $('<tr>').append(skillNameTd ));
//        var skillInputTd = $('<td>').
//          append($('<input class="skill" name="skill_set['+skillName+'][]" type="text"/>'));
//
//        var subCatTd = $('<td>').append($('<input type="text" name="skill_set[sub_'+skillName+'][]">'));
//        _.each([1,2,3], function(i) {
//          var tr = $('<tr skill="'+skillName+'">').
//            append( subCatTd.clone()).
//            append( skillBaseTd.clone() ).
//            append( skillInputTd.clone()).
//            append( skillTotalTd.clone() );
//          self.table.append(tr);
//        });
//      } else {
//        var skillInputTd = $('<td>').
//          append($('<input class="skill" name="skill_set['+skillName+']" type="text"/>'));
//        var tr = $('<tr skill="'+skillName+'">').
//          append( skillNameTd ).
//          append( skillBaseTd).
//          append( skillInputTd ).
//          append( skillTotalTd );
//        self.table.append( tr );
//      }
//    });

    var self = this;
    $('input.skill-input').change( function(event) {

      var input = $(event.target);
      var inputTd = input.parent('td');
      var skill = inputTd.attr('skill');
      var titleTd = inputTd.siblings('td.' + skill + '-title')
      var totalTd = inputTd.siblings('td.' + skill + '-total');
      if( input.val() ) {
        totalTd.html(Number(input.val()) + Number(titleTd.attr('base')));
      } else {
        totalTd.html('');
      }
      self.pointTracker.update();
    });
  }
};

CoC.OccupationalSkillList = function(properties) {
  var self = this;
  self.properties = properties;
  self.pointTracker = properties.pointTracker;

  $('#'+self.properties.skill_occupation).
    change( function() {
      self.updateOccupation();
      self.pointTracker.update();
    } );

};

CoC.OccupationalSkillList.prototype = {

  updateOccupation: function() {
    var self = this;
    self.occupationSkillList().html('');
    if(self.occupation()) {
      self.updateOccupationSkillList();
      self.updateOccupationSkillOptions();
    }
  },

  occupation: function() {
    return $('#'+this.properties.skill_occupation).val();
  },

  occupationSkillList: function() {
    return $('#'+this.properties.occupational_skill_table);
  },

  updateOccupationSkillList: function() {
    var self = this;
    var skills = self.properties.occupations[self.occupation()].set;
    _.each(skills, function(skill) {
      self.occupationSkillList().append($('<tr>').
        append('<td skill="'+skill+'">' + CoC.humanize_sym(skill) + '</td>') );
    });
  },

  updateOccupationSkillOptions: function() {
    var self = this;
    var options = self.properties.occupations[self.occupation()].options
    _.each(options, function(option) {
      var skillOptions;
      if(option == 'any') {
        skillOptions = self.properties.all_skills;
      } else {
        skillOptions = _.filter(self.properties.all_skills, function(skill) {
          return _.contains(option, skill[0]);
        });
      }

      var select = $('<select>');
      _.each(skillOptions, function(skill) {
        select.append($('<option>').
          val(skill[0]).
          append(CoC.humanize_sym(skill[0]))
        );
      });

      var td = $('<td skill="'+$('option:selected', select).val()+'">');
      select.change(function(event) {
        td.attr('skill', $('option:selected', event.target).val());
        self.pointTracker.update();
      });
      self.occupationSkillList().append($('<tr>').
        append(td.append(select)));
    });

  }
};