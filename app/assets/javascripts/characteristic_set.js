$(window).load(function() {

  $('#submit').click(function() {
    var order = _.reduce($('div.characteristic-order-box'), function(memo, item) {
      memo.push($(item).attr('characteristic'));
      return memo;
    }, []).join(',');
    $('#characteristic_set_order').val(order);
    CoC.submitForm();
  });

  $('#no').click(function() {
    CoC.submitForm();
  });

  $('#yes').click(function() {
    $('#sortable').sortable();
    $('#characteristic_set_arranged').val(true);
    movable();
    _.each($('.characteristic-order-item'), function(item) {
      $(item).removeClass('characteristic-order-item');
      $(item).addClass('characteristic-orderable-item');
    });
  });

  $('#no-order').click(function() {
    $('#characteristic_set_arranged').val(false);
    notMovable();
    _.each($('.characteristic-orderable-item'), function(item) {
      $(item).removeClass('characteristic-orderable-item');
      $(item).addClass('characteristic-order-item');
    });
  });

  var movable = function() {
    $('.movable').show();
    $('.not-movable').hide();
  }

  var notMovable = function() {
    $('.movable').hide();
    $('.not-movable').show();
  }
  notMovable();
});