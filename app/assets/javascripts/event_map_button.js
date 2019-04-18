document.addEventListener("DOMContentLoaded", function(){

  var mapButton = document.querySelector('#map-button');
  var mapDisplay = document.querySelector('#eventsMap');
  var mapDescHide = document.querySelector('#hide-map-desc');
  var mapDescshow = document.querySelector('#show-map-desc');


  mapButton.addEventListener("click", function(e) {
    $('#eventsMap').slideToggle();
    $('#map').toggleClass('hidden');
    $('#hide-map-desc').toggleClass('hidden');
    $('#show-map-desc').toggleClass('hidden');

  });








});
