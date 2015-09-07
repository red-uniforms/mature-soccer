$(document).on("ready page:load", function() {
  $("#copy-link").on("click", function(){
    window.prompt("복사해서 팀원들에게 공유하세요!",$("#data-copy-link").val());
  });

});