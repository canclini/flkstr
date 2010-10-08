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

//signin menu on website
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

//actionbox
  $(".message").click(function(e) {
    e.preventDefault();
    $("#message_menu").toggle();
    $(".message").toggleClass("menu-open");
    updateActionboxMessages();
  });
  $("#message_menu").mouseup(function() {
    return false
  });
  $(document).mouseup(function(e) {
    if($(e.target).parent("a.message").length==0) {
      $(".message").removeClass("menu-open");
      $("#message_menu").hide();
    }
  });

  $(".contact").click(function(e) {
    e.preventDefault();
    $("#contact_menu").fadeTo("fast", 1);
    $(".contact").toggleClass("menu-open");
  });
  $("#contact_menu").mouseup(function() {
    return false
  });
  $(document).mouseup(function(e) {
    if($(e.target).parent("a.contact").length==0) {
      $(".contact").removeClass("menu-open");
      $("#contact_menu").hide();
    }
  });

  $(".lead").click(function(e) {
    e.preventDefault();
    $("#lead_menu").fadeTo("fast", 1);
    $(".lead").toggleClass("menu-open");
    updateActionboxLeads();
  });
  $("#lead_menu").mouseup(function() {
    return false
  });
  $(document).mouseup(function(e) {
    if($(e.target).parent("a.lead").length==0) {
      $(".lead").removeClass("menu-open");
      $("#lead_menu").fadeTo("fast", 0);
    }
  });

// settings-menu
  $('a#settings').click(function(){
    $('#settings-menu').toggle();
  });

/*  $("#company_name").keydown(function(){
       updateExistingCompanies();
  });

  $("#existingcompany").live('click',function(){
    showExistingCompany($(this).attr("data-id"));
  });
*/
  
  $('.clearme').one("focus", function(){
    $(this).val('');
  });

  $('.focus').focus();  

//  $('.hide').hide();  // should be done with CSS display: none;
  //  $("#new_review").submitWithAjax();
});

function updateExistingCompanies() {
  var company_search = $('#company_name').val();
  $.getScript("/companies/exists.js?search=" + company_search)
};

function showExistingCompany(company_id) {
  $.getScript("/companies/" + company_id + "/join.js")
};

// ACTIONBOX: message update on activation
function updateActionboxMessages() {
  $.getScript("/messages.js")
};

function updateActionboxLeads() {
  $.getScript("/leads.js")
};
