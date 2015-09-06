$(document).on("ready page:load", function() {
  $("#copy-link").on("click", function(){
    window.prompt("복사해서 팀원들에게 공유하세요!",$("#data-copy-link").val());
  });

  $("#new_user_info").on("submit", function(e) {
    console.log($(this).attr("action"));
    console.log(document.location.pathname);

    var action = $(this).attr("action").replace("/join","");
    console.log(action);

    if ( action != document.location.pathname ) {
      e.preventDefault();
      alert("Don't change form action!!");
    }
  });

});