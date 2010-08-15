// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

jQuery.ajaxSetup({ 
  'beforeSend': function(xhr) {xhr.setRequestHeader("Accept", "text/javascript")}
})

jQuery.fn.submitWithAjax = function() {
  this.submit(function() {
    $.post(this.action, $(this).serialize(), null, "script");
    return false;
  })
  return this;
};

$(document).ready(function() {
  $('.clearme').one("focus", function(){
    $(this).val('');
  });

  $('.focus').focus();  

  $('div.hide').hide();  

  $('a#signinshow').click(function(){
    $('#signin-menu').show();
  });

  $('a#signinclose').click(function(){
    $('#signin-menu').hide();
  });

  //  $("#new_review").submitWithAjax();
});

