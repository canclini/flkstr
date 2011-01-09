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

jQuery.fn.preventDoubleSubmit = function() {
  jQuery(this).submit(function() {
    if (this.beenSubmitted)
      return false;
    else
      this.beenSubmitted = true;
  });
};

$(document).ready(function() {	

  VideoJS.setupAllWhenReady();
	
	$("#twitter").getTwitter({
		userName: "flockstreet",
		numTweets: 5,
		loaderText: "Loading tweets...",
		slideIn: false,
		slideDuration: 750,
		showHeading: false,
		headingText: "Latest Tweets",
		showProfileLink: false,
		showTimestamp: true
	});
	
	jQuery('#user_new').preventDoubleSubmit();
	
  $('.show_price_suggestion').click(function(e) {
    e.preventDefault();
    $(this).hide();
    $(this).parent().parent().children('.new_price_suggestion').show();
    $(this).parent().parent().children('.new_price_suggestion').children('#price_suggestion_price').focus();
  });  

	$('input').focus(function() {
	  $(".hint").hide();
	  $(this).parent().children('.hint').show();
	});

  $('.spin').click(function() {
      $(this).button('disable');
  });
    			
//signin menu on website
  $(".login").click(function(e) {
    e.preventDefault();
// following 2 lines are commented for website phase
    $("#login_menu").toggle();
    $(".login").toggleClass("menu-open");
  });

  $("#login_menu").mouseup(function() {
    return false
  });
  $(document).mouseup(function(e) {
    if($(e.target).parent("a.login").length==0) {
      $(".login").removeClass("menu-open");
      $("#login_menu").hide();
    }
  });

//actionbox
  $(".message.dropdown").click(function(e) {
    e.preventDefault();
    $("#message_menu").toggle();
    $(".message.dropdown").toggleClass("menu-open");
    updateActionboxMessages();
  });
  $("#message_menu").mouseup(function() {
    return false
  });
  $(document).mouseup(function(e) {
    if($(e.target).parent("a.message").length==0) {
      $(".message.dropdown").removeClass("menu-open");
      $("#message_menu").hide();
    }
  });

  $(".contact.dropdown").click(function(e) {
    e.preventDefault();
    $("#contact_menu").toggle();
    $(".contact.dropdown").toggleClass("menu-open");
  });
  $("#contact_menu").mouseup(function() {
    return false
  });
  $(document).mouseup(function(e) {
    if($(e.target).parent("a.contact").length==0) {
      $(".contact.dropdown").removeClass("menu-open");
      $("#contact_menu").hide();
    }
  });

  $(".lead.dropdown").click(function(e) {
    e.preventDefault();
    $("#lead_menu").toggle();
    $(".lead.dropdown").toggleClass("menu-open");
    updateActionboxLeads();
  });
  $("#lead_menu").mouseup(function() {
    return false
  });
  $(document).mouseup(function(e) {
    if($(e.target).parent("a.lead").length==0) {
      $(".lead.dropdown").removeClass("menu-open");
      $("#lead_menu").hide();
    }
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

  //  $("#new_review").submitWithAjax();
  
//  $( "#ac_companies" ).autocomplete({
//    source: "/companies/autocomplete",
//  	minLength: 2,
//  	select: function( event, ui ) {
//      var sel = "<div class='recipient' id='recipient_" + ui.item.id + "'> <input id='message_to_' name='message[to][]' type='hidden' value =" + ui.item.id + "> <span>" + ui.item.value + "</span> <a href='#' id='recipient-remove_" + ui.item.id + "' class='recipient-remove'>Remove</a> </div>";
//          
//      $("#ac_selection").html(sel);
//          
//      $(".recipient-remove").click(function() {
//        $(this).parent().remove();
//      });    
//  	}
//  });  		      
  
  
//  $( "#ac_tags" ).autocomplete({
//    source: "/tags/autocomplete",
//  	minLength: 2,
//  	select: function( event, ui ) {
//  	  // das muss in eine Funktion ausgelagert werden... falls das Tag existiert wird value übernommen, falls es nicht existiert, muss der eingegebene wert hinzugefügt werden.
//      var sel = "<div id='tag_container_" + ui.item.id + "'> <input id='request_tags_' name='request[tags][]' type='hidden' value =" + ui.item.value + "> <span class = 'tag'>" + ui.item.value + "</span> <a href='#' id='tag-remove_" + ui.item.id + "' class='tag-remove'>Remove</a> </div>";
//          
//      $("#ac_selection").append(sel);
//          
//      $(".tag-remove").click(function() {
//        $(this).parent().remove();
//      });    
//  	}
//  });  		      
  
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
  $.getScript("/messages/actionbox.js")
};

function updateActionboxLeads() {
  $.getScript("/leads/actionbox.js")
};

