// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
$(document).ready(function(){
  $("#new_user_friendship").on("submit", function(event){
    event.preventDefault();
    var friendId = $("#user_friendship_friend_id").val();
    var _this = $(this);

    $.ajax({
      url: "/user_friendships",
      method: "POST",
      dataType: "json",
      data: _this.serialize(),
      success: function(data){
        console.log(data);
        _this.hide();
        $(".friend-request-form").html('<button class="btn btn-success" disabled="disabled" name="button" type="submit" style="background-color:green;">Friend request sent</button>');
      }
    });
  });

  // $(".edit_user_friendship").on("ajax:success", function(event, data){
  //   $tingzSon = $($(event.target).parent()[0])
  //   $tingzSon.remove();
  // });

  $(".edit_pending_user_friendship, .delete_pending_user_friendship, .edit_accepted_user_friendship").on("submit", function(event){
    event.preventDefault();
    var _this = $(this);
    var friend = _this.attr('id');

    $.ajax({
      url: "/user_friendships/"+friend,
      data: {"_method":"delete"},
      method: "POST",
      dataType: "json",
      success: function(data){
        console.log(data);
        _this.closest(".pending, .requested, .accepted").remove();
        if ($(".pending-friends").children().length === 0) {
          $(".pending-friends").html("<h4>You have no pending requests!</h4>");
        }else if($(".friend-requests").children().length < 1){
          $(".friend-requests").html("<h4>You have no pending requests!</h4>");
        }else if($(".accepted-friends").children().length < 1){
          $(".accepted-friends").html("<h4>You have no Friends!</h4>");
        }
      }
    });
  });

  $(".edit_requested_user_friendship").on("submit", function(event){
    event.preventDefault();
    var _this = $(this);
    var friend = _this.attr('id');

    $.ajax({
      url: "/user_friendships/"+friend,
      data: {'_method':'put'},
      method: "POST",
      dataType: 'script',
      success: function(data){
        console.log(data);
        _this.closest(".requested, .blocked").remove();
        if ($(".friend-requests").children().length === 0) {
          $(".friend-requests").html("<h4>You have no pending requests!</h4>")
        };
      }
    });
  });

  $(".block_requested_user_friendship").on("submit", function(event){
    event.preventDefault();
    var _this = $(this);
    var friend = _this.attr('id');

    $.ajax({
      url: "/user_friendships/"+friend+"/block",
      data: {'_method':'put'},
      dataType: 'script',
      method: "POST",
      success: function(data){
        console.log(data);
        _this.closest('.accepted').remove();
        if($(".accepted-friends").children().length < 1){
          $(".accepted-friends").html("<h4>You have no friends!</h4>");
        }
      }
    });
  });
});
