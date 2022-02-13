import consumer from "channels/consumer"

const getUserIds = (originalCookie) => {
  const allCookiesArray = originalCookie.split(";");
  let loginUserId = '';
  let talkedToUserId = '';
  for (let c of allCookiesArray) {
    const cArray = c.split("=");
    if (cArray[0].trim() === "login_user_id") {
      loginUserId = cArray[1];
    } else if (cArray[0].trim() === "talked_to_user_id") {
      talkedToUserId = cArray[1];
    }
  }

  let formerUserId = '';
  let latterUserId = '';

  if (loginUserId > talkedToUserId) {
    [latterUserId, formerUserId] = [loginUserId, talkedToUserId];
  } else {
    [formerUserId, latterUserId] = [loginUserId, talkedToUserId];
  }

  return `${formerUserId}_${latterUserId}`
}

consumer.subscriptions.create({ channel: "RoomChannel", userIds: getUserIds(document.cookie) }, {
  connected() {
    console.log(getUserIds(document.cookie))
    document.querySelector('input[data-behavior="room_speaker"]')
        .addEventListener('keypress', (event) => {
          if (event.key === 'Enter') {
            this.speak(event.target.value);
            event.target.value = '';
            return event.preventDefault();
          }
        })
  },

  disconnected() {
  },

  received(data) {
    const element = document.querySelector('#messages')
    element.insertAdjacentHTML('beforeend', data['message'])
  },

  speak: function(message) {
    return this.perform('speak', { message: message });
  }
});
