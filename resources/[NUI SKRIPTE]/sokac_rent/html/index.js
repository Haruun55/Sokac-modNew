window.addEventListener('message', function(event) {
  let data = event.data

  if (data.action == "open") {
    $('body').fadeIn("medium")
    $('#auto').show()
    $('#beta').show()
    $('.stanje').show()
    $("#pare").html(`` + data.pare +`$`)
  }
});


$(document).on("click", "#dzamija", function(){
  
  $('#auto').toggle("slide:right");
  $('#auto2').toggle("slide:left");
})

$(document).on("click", "#ford", function(){
  let data = $(this).data("ford")
  $.post(`https://${GetParentResourceName()}/ford`, JSON.stringify({
    data: data
  }));
  CloseMenu()
})

$(document).on("click", "#golf", function(){
  let data = $(this).data("golf")
  $.post(`https://${GetParentResourceName()}/golf`, JSON.stringify({
    data: data
  }));
  CloseMenu()
})

function CloseMenu() {
  $('body').fadeOut("medium")
  $('#auto2').hide()
  $('#beta').show()
  $('.stanje').hide()
  $.post(`https://${GetParentResourceName()}/close`, JSON.stringify({}));
}



document.onkeyup = function (data) {
  if (data.which == 27) {
    CloseMenu()
  }
};


