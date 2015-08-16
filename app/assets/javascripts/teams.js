$(document).on("ready page:load", function() {
  $("#copy-link").on("click", function(){
    window.prompt("Copy and share to teammates!",$("#data-copy-link").val());
  });
});