/*

videos code and architecture:
=============================
1. when a player appears as connected, it sends an offer to everyone. 
2. When receiving an offer, (if it's from a lower ID, and connection not already exists) accept and add it to `peerConnections`, and add video.
3. Your disconnection leaving will be caught by a 'disconnected' PeerConnection event on your peer's side.
4. Future: on every move update, check the users nearby me: if we don't have a connection already, send them an offer. Destroy all other videos. 

The following is written from the perspective of the current user. 

1. Window has "cuid" (current user id) and "game" (an object with all currently present users).

1.1. On initialization we build a box for the current user, to see their own video. 

2. We call "updateConnections(window.game)". This traverses the list of present users and for each other-player with an alphabetically higher ID, the current user creates a "peerConnection", sends an offer, and starts sending ICE options. 

  > Signaling is done by sending HTTP messages to the server via the supplied "sendChat" method. The server then uses Pusher.com to push the offer to all clients. (I have seen Pusher limit some messages that exceed 10k characters, we might need to send them as separate messages and re-build on the client side to get around this).

3. Upon receiving an offer, the other-user will set up a peerConnection from the 'new' user, set local and remote descriptions, and return an answer, which the first user will set as the remote description. This should establish the RTC channel between the two users, upon which a 'track' will be emitted from the PC, enabling creating the video feed.

The above should work (and has worked once...) but needs more work to debug and make it work in the cloud. 

*/

const PEER_CONNECTION_CONFIG = {
    'iceServers': [
        {'urls': 'stun:stun.stunprotocol.org:3478'},
        {'urls': 'stun:stun.l.google.com:19302'}
    ]
};

const peerConnections = {};

function getPeerConnection(playerId) {
    if (peerConnections[playerId]) return peerConnections[playerId];

    let pc = peerConnections[playerId] = new RTCPeerConnection(PEER_CONNECTION_CONFIG);

    pc.a_player_id = playerId;

    let videoAdded = false;
    pc.addEventListener('connectionstatechange', () => {
      switch (pc.connectionState) {
        case 'connected':
          //player.setConnectionState(true); //here we can enable manual start/stop. But perhaps better to just always have a "hide" button.
          break;
        case 'disconnected':
          console.log('player has left');
          //player.stop();
          //remove their video box
          break;
    }
    });
    pc.addEventListener('track', ({streams}) => {
      if (videoAdded) return;
      addPlayerVideo(playerId, streams[0]);
      videoAdded = true;
    });
    pc.addEventListener('icecandidate', ({candidate}) => {
      if (!candidate) {
        console.log('received empty candidate', candidate)
        return;
      }
      sendChat({from: cuid, candidate: candidate, subtype: 'webrtc-ice-candidate-msg'})
        //messages.ice.candidate(player.client, player.uuid, candidate);
    });
    return pc;
}

function addPlayerVideo(player_id, stream) {
  console.log('adding player video',player_id, stream);
  $('.player_video.'+player_id).append(createVideoElement(stream));
}

function getCamStream() {
  return navigator.mediaDevices.getUserMedia({audio: true, video: true});
}

function handleWebRTCMessage(msg) {    
  var id = msg.from;
  if (id == window.cuid) return; //console.log('message from self, skipping');
  
  console.log(`received webRTC ${msg.subtype}`, msg)
  
  var pc = getPeerConnection(id);  
  
  if (msg.subtype == 'webrtc-ice-candidate-msg') {  
    pc.addIceCandidate(new RTCIceCandidate(msg.candidate));      
  } else if (msg.subtype == 'webrtc-offer') {
    pc.setRemoteDescription(new RTCSessionDescription(msg.offer)).then(() => {
      getCamStream().then(stream => {
        stream.getTracks().forEach(track => pc.addTrack(track, stream));
        pc.createAnswer().then(answer => {
          pc.setLocalDescription(answer);
          sendChat({from: cuid, to: id, answer: answer, subtype: 'webrtc-answer'})
        })
      })
    })
  } else if (msg.subtype == 'webrtc-answer') {
    window.receivedAnswer = msg.answer;
    pc.setRemoteDescription(new RTCSessionDescription(msg.answer));
  }
}

function createOffer(pc) {
  return pc.createOffer({offerToReceiveAudio: 1, offerToReceiveVideo: 1});
}

function updateConnections(game) {
  var cuid = window.cuid;
  for (id in game.users) {
    if (!peerConnections[id] && (cuid < id)) {
      var pc = getPeerConnection(id);
      
      getCamStream().then(stream => {
        stream.getTracks().forEach(track => pc.addTrack(track, stream));
        createOffer(pc).then(offer => {
          pc.setLocalDescription(offer);
          sendChat({from: cuid, to: id, offer: offer, subtype: 'webrtc-offer'});
        })  
      });
    }
  }
}

function setMyVideo() {
  navigator.mediaDevices.getUserMedia({video: true, audio: true}).then(stream => {    
    $('.player_video.me').append(createVideoElement(stream));
  });
}

setMyVideo();  
setTimeout(()=>updateConnections(window.game), 1000);  