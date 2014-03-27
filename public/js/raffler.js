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
            entry['name'] +
          '</li>';
      });
      $('#events').html(events);
    });
  })
});
