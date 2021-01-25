import consumer from "./consumer"
function scroll_bottom(){
  if($('#message-scroll').length >0)
  {
    $('#message-scroll').scrollTop($('#message-scroll')[0].scrollHeight);
  }
}
function submit_message() {
  document.getElementById('message-body').value='';
};
consumer.subscriptions.create("ChatroomChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    
    $('#message-containner').append(data.mod_message)
    scroll_bottom();
    submit_message();
  }
});
