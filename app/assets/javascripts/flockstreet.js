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
		numTweets: 3,
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
    $(".actionbox.messages").toggle();
    $("message.dropdown").toggleClass("menu-open");
    updateActionboxMessages();
  });
  $(".actionbox.messages").mouseup(function() {
    return false
  });
  $(document).mouseup(function(e) {
    if($(e.target).parent("a.message").length==0) {
      $(".message.dropdown").removeClass("menu-open");
      $(".actionbox.messages").hide();
    }
  });

  $(".contact.dropdown").click(function(e) {
    e.preventDefault();
    $(".actionbox.contacts").toggle();
    $(".contact.dropdown").toggleClass("menu-open");
  });
  $(".actionbox.contacts").mouseup(function() {
    return false
  });
  $(document).mouseup(function(e) {
    if($(e.target).parent("a.contact").length==0) {
      $(".contact.dropdown").removeClass("menu-open");
      $(".actionbox.contacts").hide();
    }
  });

  $(".lead.dropdown").click(function(e) {
    e.preventDefault();
    $(".actionbox.leads").toggle();
    $(".lead.dropdown").toggleClass("menu-open");
    updateActionboxLeads();
  });
  $(".actionbox.leads").mouseup(function() {
    return false
  });
  $(document).mouseup(function(e) {
    if($(e.target).parent("a.lead").length==0) {
      $(".lead.dropdown").removeClass("menu-open");
      $(".actionbox.leads").hide();
    }
  });
  
  // BULK ACTION STUFF
  $('input[name=select_all]').click(function(e) {
    if($(this).is(':checked')) {
      $("#items_form :checkbox").attr('checked', true);
      $('input[name=select_all]').attr('checked', true);
    }  
    else {
      $("#items_form :checkbox").attr('checked', false);
      $('input[name=select_all]').attr('checked', false);
      }
    //$(".actions").toggle();    
  });

  $(".select").click(function(e) {
    $('input[name=select_all]').attr('checked', false);
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
  
  $('#request_duedate').datepicker({dateFormat: 'dd.mm.yy', showAnim: 'fade'});

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