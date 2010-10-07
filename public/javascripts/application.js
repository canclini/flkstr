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


$(function() {  

  $(".signin").click(function(e) {
                  e.preventDefault();
                  $("#signin_menu").toggle();
                  $(".signin").toggleClass("menu-open");
              });

              $("#signin_menu").mouseup(function() {
                  return false
              });
              $(document).mouseup(function(e) {
                  if($(e.target).parent("a.signin").length==0) {
                      $(".signin").removeClass("menu-open");
                      $("#signin_menu").hide();
                  }
              });




  $("#company_name").keydown(function(){
       updateExistingCompanies();
  });

  $("#existingcompany").live('click',function(){
    showExistingCompany($(this).attr("data-id"));
  });
  
  $('.clearme').one("focus", function(){
    $(this).val('');
  });

  $('.focus').focus();  

  $('.hide').hide();  

  $('a#settings').click(function(){
    $('#settings-menu').toggle();
  });

  //  $("#new_review").submitWithAjax();
});

function updateExistingCompanies() {
  var company_search = $('#company_name').val();
  $.getScript("/companies/exists.js?search=" + company_search)
};

function showExistingCompany(company_id) {
  $.getScript("/companies/" + company_id + "/join.js")
};