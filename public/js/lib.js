log = function(s) { console.log(s)}

goToPath = function(path) { 
  window.location.href = path;
}

nicePrompt = function(title,cb) {
  swal({
    title: title,
    html: '<p><input id="swal-prompt-input-field">',
  },
  function() {
    var val = $('#swal-prompt-input-field').val();
    if (val && cb) { cb(val); }    
  });
}

screenToast = function(val) {
  alert(val);
}

$.fn.serializeObject = function()
{
    var o = {};
    var a = this.serializeArray();
    $.each(a, function() {
        if (o[this.name] !== undefined) {
            if (!o[this.name].push) {
                o[this.name] = [o[this.name]];
            }
            o[this.name].push(this.value || '');
        } else {
            o[this.name] = this.value || '';
        }
    });
    return o;
};

window.gulp = function getUrlParameter(sParam) {
    var sPageURL = decodeURIComponent(window.location.search.substring(1)),
        sURLVariables = sPageURL.split('&'),
        sParameterName,
        i;

    for (i = 0; i < sURLVariables.length; i++) {
        sParameterName = sURLVariables[i].split('=');

        if (sParameterName[0] === sParam) {
            return sParameterName[1] === undefined ? true : sParameterName[1];
        }
    }
};

//console.log('defining onEnter');
function onInputEnter(el, cb) {
  $(el).keydown(e => {
    if ($(el).val() && (event.keyCode == 13)) {
      cb(el);
    }
  });
}


function setEndOfContenteditableHelper(id) {
  var elem = document.getElementById(id);
  setEndOfContenteditable(elem);
}

function setEndOfContenteditable(contentEditableElement)
{
  var range,selection;
  range = document.createRange();//Create a range (a range is a like the selection but invisible)
  range.selectNodeContents(contentEditableElement);//Select the entire contents of the element with the range
  range.collapse(false);//collapse the range to the end point. false means collapse to end rather than the start
  selection = window.getSelection();//get the selection object (allows you to change selection)
  selection.removeAllRanges();//remove any selections already made
  selection.addRange(range);//make the range you have just created the visible selection
}

function uploadImg(file, cb) {
  var settings = {
    async: false, crossDomain: true, processData: false, contentType: false,
    type: 'POST', url: 'https://api.imgur.com/3/image',

    headers: {Authorization: 'Client-ID 3fe190ba92e9bed', Accept: 'application/json' },
    mimeType: 'multipart/form-data'
  };

  var formData = new FormData();
  formData.append("image", file);
  settings.data = formData;

  $.ajax(settings).done(cb) // link at response.data.link
}

function sortElemsList(containerSelector, itemSelector, data_attr) {
  var list = $(itemSelector);
  list.sort(function(a, b){
    var res =  ($(a).data(data_attr)-$(b).data(data_attr)) * -1;
    console.log(res);
    return res;
  });
  
  $(containerSelector).html(list);  
}


function postJSON(url, data) {
  data = data || {};
  data.ajax = true;
  //console.log('posting JSON', data)
  return fetch(url, {
    method: 'post',
    headers: {'Content-Type': 'application/json'},
    body: JSON.stringify(data)
  }).then(res => {
    //console.log('postJSON response: ', res);
    return res.json();
  }).catch(err => {
    console.log('failed parsing response from ',url,'err is',err);
    return {err: err}
  });
}

function timeAgo(time) {
  var secs_passed  = (new Date - time)/1000;
  
  var unit = "second";
  if (secs_passed > 1) unit+= "s";
  if (secs_passed < 5) return `just now`
  if (secs_passed < 60) return `${secs_passed} ${unit} ago`
  
  var mins_passed  = Math.round(secs_passed / 60)
  unit = "minute";
  if (mins_passed > 1) unit+= "s";
  if (mins_passed < 60) return `${mins_passed} ${unit} ago`
  
  var hours_passed = Math.round(mins_passed / 60);
  unit = "hour";
  if (hours_passed > 1) unit+= "s";
  if (hours_passed < 24) return `${hours_passed} ${unit} ago`

  var days_passed  = Math.round(hours_passed / 24);
  unit = "day";
  if (days_passed > 1) unit+= "s" 
  return `${days_passed} ${unit} ago`;
}

function scrollDown($el) {
  $el.scrollTop($el.get(0).scrollHeight);
}

Date.prototype.addHours = function(h) {
  this.setTime(this.getTime() + (h*60*60*1000));
  return this;
}

Date.prototype.addMins = function(h) {
  this.setTime(this.getTime() + (h*60*1000));
  return this;
}

function nextDowDate(dow) { //nextDowDate('mon')
  var ret = new Date();
  ret.setHours(0,0,0,0);
  ret.setDate(ret.getDate() + (dowsIndex[dow] - 1 - ret.getDay() + 7) % 7 + 1);
  return ret;
}

Number.prototype.mod = function(n) {
    return ((this%n)+n)%n;
};

function createVideoElement(stream) {
    let videoElement = document.createElement('video');

    videoElement.classList.add('video');
    videoElement.setAttribute('autoplay', '');
    videoElement.setAttribute('muted', '');
    videoElement.setAttribute('width', '200');
    videoElement.setAttribute('height', '200');
    videoElement.srcObject = stream;

    return videoElement;
}

function replaceAll(str, substr, newSub) {
  var re = new RegExp(substr,"g");
  return str.replace(re, newSub);
}

function titleCase(str) {
   var splitStr = str.toLowerCase().split(' ');
   for (var i = 0; i < splitStr.length; i++) {
       // You do not need to check if i is larger than splitStr length, as your for does that for you
       // Assign it back to the array
       splitStr[i] = splitStr[i].charAt(0).toUpperCase() + splitStr[i].substring(1);     
   }
   // Directly return the joined string
   return splitStr.join(' '); 
}

function getCaretCharacterOffsetWithin(element) {
    var caretOffset = 0;
    var doc = element.ownerDocument || element.document;
    var win = doc.defaultView || doc.parentWindow;
    var sel;
    if (typeof win.getSelection != "undefined") {
        sel = win.getSelection();
        if (sel.rangeCount > 0) {
            var range = win.getSelection().getRangeAt(0);
            var preCaretRange = range.cloneRange();
            preCaretRange.selectNodeContents(element);
            preCaretRange.setEnd(range.endContainer, range.endOffset);
            caretOffset = preCaretRange.toString().length;
        }
    } else if ( (sel = doc.selection) && sel.type != "Control") {
        var textRange = sel.createRange();
        var preCaretTextRange = doc.body.createTextRange();
        preCaretTextRange.moveToElementText(element);
        preCaretTextRange.setEndPoint("EndToEnd", textRange);
        caretOffset = preCaretTextRange.text.length;
    }
    return caretOffset;
}

function createRange(node, chars, range) {
    if (!range) {
        range = document.createRange()
        range.selectNode(node);
        range.setStart(node, 0);
    }

    if (chars.count === 0) {
        range.setEnd(node, chars.count);
    } else if (node && chars.count >0) {
        if (node.nodeType === Node.TEXT_NODE) {
            if (node.textContent.length < chars.count) {
                chars.count -= node.textContent.length;
            } else {
                 range.setEnd(node, chars.count);
                 chars.count = 0;
            }
        } else {
            for (var lp = 0; lp < node.childNodes.length; lp++) {
                range = createRange(node.childNodes[lp], chars, range);

                if (chars.count === 0) {
                   break;
                }
            }
        }
   } 

   return range;
};

function setCurrentCursorPosition(chars) {
    if (chars >= 0) {
        var selection = window.getSelection();

        range = createRange(document.getElementById("code").parentNode, { count: chars });

        if (range) {
            range.collapse(false);
            selection.removeAllRanges();
            selection.addRange(range);
        }
    }
};