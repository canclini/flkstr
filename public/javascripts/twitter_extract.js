// first function take and modified from http://twitter.com/javascripts/blogger.js
function twitterCallback2(twitters) {
  var statusHTML = [];
  
  for (var i=0; i<twitters.length; i++){
    var username = twitters[i].user.screen_name;
    var status = twitters[i].text.replace(/((https?|s?ftp|ssh)\:\/\/[^"\s\<\>]*[^.,;'">\:\s\<\>\)\]\!])/g, function(url) {
      return '<a href="'+url+'">'+url+'</a>';
    }).replace(/\B@([_a-z0-9]+)/ig, function(reply) {
      return  reply.charAt(0)+'<a href="http://twitter.com/'+reply.substring(1)+'">'+reply.substring(1)+'</a>';
    });
    statusHTML.push('<article class= "tweet"><div class="status">'+status+'</div><div class="bubble"></div> <footer><a  href="http://twitter.com/'+username+'/statuses/'+twitters[i].id+'"><time datetime="'+twitters[i].created_at+'" pubdate>'+nice_datetime(twitters[i].created_at)+'</time></a></footer></article>');
  }
  document.getElementById('twitter_update_list').innerHTML = statusHTML.join('');
}

function nice_datetime(d) {
  var values = d.split(" ");
  var times = values[3].split(":");
  nice = values[2] + ". " + values[1] + " " + values[5] + " " + times[0] + ":" + times[1];
  return nice;
}
