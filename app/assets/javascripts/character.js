if( !('CoC' in window ) ) { CoC = {}; }
if( !CoC.Character ) { CoC.Character = {}; }

CoC.Character.randomFirstName = function(gameSystemId, nameInputId, gender) {
  $.ajax('/name_maker/first/' + gender, {
    data: { gender: gender, game_system_id: gameSystemId },
    success: function(data, textStatus, jqXHR) {
      $('#'+nameInputId).val(data);
    },
    error: function() {
      //todo errorhandling
    }
  });
};

CoC.Character.randomLastName = function(gameSystemId, nameInputId) {
  $.ajax('/name_maker/surname', {
    data: { game_system_id: gameSystemId },
    success: function(data, textStatus, jqXHR) {
      $('#'+nameInputId).val(data);
    },
    error: function() {
      //todo errorhandling
    }
  });
};

CoC.Character.randomCity= function(birthplaceInputId) {
  $.ajax('/name_maker/city', {
    success: function(data, textStatus, jqXHR) {
      $('#'+birthplaceInputId).val(data);
    },
    error: function() {
      //todo errorhandling
    }
  });
};

CoC.Character.randomSelect = function(selectInputId) {
  $('#' + selectInputId).val(_.shuffle(
    _.filter(
      _.map(
        $('#' + selectInputId + ' option'), function(o) {
          return $(o).attr('value');}), function(o) {
        return !!o;}))[0]);
};

CoC.Character.dateOfBirth= function(dateOfBirthId, complete) {
  $.ajax('/name_maker/date_of_birth', {
    success: function(data, textStatus, jqXHR) {
      $('#'+dateOfBirthId).val(data);
      complete()
    },
    error: function() {
      //todo errorhandling
    }
  });
};
