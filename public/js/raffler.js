(function ($) {
  'use strict';
  $(function () {
    $('#show-events').click(function (e) {
      e.preventDefault();
      $('#events').html('');
      $.post('/events', { name: $('#group-name').val() }, function (data) {
        var events = '';
        data.forEach(function (entry) {
          events +=
            '<li class="list-group-item">' +
            '<span class="badge">' +
            entry.yes_rsvp_count +
            '</span>' +
            '<a href="event/' + entry.id + '">' +
            entry.name +
            '</a>' +
            '</li>';
        });
        $('#events').html(events);
      });
    });

    $('#raffle').click(function (e) {
      e.preventDefault();
      var reject = $('input:checkbox:not(:checked)').map(function () { return $(this).val(); }).get();
      $.post('/raffle', { event: event_id, number: $('#raffle-number').val(), reject: reject }, function (data) {
        var raffle = '<hr><row>';
        data.forEach(function (entry) {
          var image = ''
          if (entry.member_photo) {
            image = entry.member_photo.photo_link
          }
          raffle +=
            '<div class="col-md-6">' +
            '<div class="thumbnail">' +
            '<img style="background-image:url(' + image + ')" alt="' + entry.member.name + '">' +
            '<h4 class="text-center">' + entry.member.name + '</h4>' +
            '</div>' +
            '</div>';
        });
        raffle += '</row>';
        $('#raffle-results').html(raffle);
      });
    });
  });
}(jQuery));
