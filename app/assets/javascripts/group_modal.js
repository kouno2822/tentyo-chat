$(function(){
  $('#group_modal').on('click', function(){
    $("#group_create-modal").fadeIn("slow");
    $(".group__create__box").fadeIn("slow");
    console.log('ok');
    
  });
  $(".group__create__box-cross,#group_create-modal").unbind().click(function(){    
    $('#group_create-modal').fadeOut('slow');
    $('.group__create__box').fadeOut('slow');
  });
});