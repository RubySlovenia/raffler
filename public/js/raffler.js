$(function() {
  $('#show-events').click(function(e){
    e.preventDefault();
    $('#events').html('');
    $.post('/events', { name: $('#group-name').val() }, function(data) {
      events = '';
      data.forEach(function(entry) {
        events +=
          '<li class="list-group-item">' +
            '<span class="badge">' +
              entry['yes_rsvp_count'] +
            '</span>' +
            '<a href="event/' + entry['id'] + '">' +
              entry['name'] +
            '</a>'
          '</li>';
      });
      $('#events').html(events);
    });
  })

  //$("input:checkbox:not(:checked)").map(function(){return $(this).val()})


});
