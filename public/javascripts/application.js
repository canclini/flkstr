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
  $(".new_company").keydown(function(){
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

  $('a#signinshow').click(function(){
    $('#signin-menu').show();
  });

  $('a#signinclose').click(function(){
    $('#signin-menu').hide();
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