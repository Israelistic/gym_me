document.addEventListener("DOMContentLoaded", function(){


if (document.getElementById('locationSearchField')) {
  var input = document.getElementById('locationSearchField');
    if (input !== ""){
      var autocomplete = new google.maps.places.Autocomplete(input);
      autocomplete.setFields(
        ['address_components', 'geometry', 'icon', 'name']);
    }
}
});
