const dowsHash = {
	mon: 'Mondays',
	tue: 'Tuesdays',
	wed: 'Wednesdays',
	thu: 'Thursdays',
	fri: 'Fridays',
	sat: 'Saturdays',
	sun: 'Sundays'
}

const dowsOrder = ['mon','tue','wed','thu','fri','sat','sun'];
const dowsIndex = {
	mon: 0, tue: 1, wed: 2, thu: 3, fri: 4, sat: 5, sun: 6
}

function nextDow(dow) { return dowsOrder[(dowsIndex[dow]+1).mod(7)] }
function prevDow(dow) { return dowsOrder[(dowsIndex[dow]-1).mod(7)] } 

function convertTimesToLocal() {
	console.log('converting times to local')
	//if (window.timesConvertedToLocal) return;
	window.timesConvertedToLocal = true;

	
	$('.cast_time_single').each((idx,el) => {
		el = $(el);
		var ownerID     = el.attr('data-owner_id');
		if (ownerID == window.cuid) return;
		var origDate    = el.attr('data-orig_datetime');
		var ownerOffset = parseInt(el.attr('data-owner_offset'));
		
		var curOffset   = (new Date).getTimezoneOffset()/-60;
		origDateNoTZ    = origDate.substring(0,16);
		var hoursDiff   = curOffset-ownerOffset;
		var localTime   = (new Date(origDateNoTZ)).addHours(hoursDiff).toString();

		var localTime2  = localTime.substring(4,21);
		localTime2 = localTime2.replace(' 2020 ',', ')
		var tzName      = (new Date).toString().substring(34);
		var creatorName = el.attr('data-owner_name');
		var tooltip     = (hoursDiff > 0) ? `There is a ${Math.abs(hoursDiff)} hours difference between your local time and ${creatorName}.` : '';
		var origHTML    = $(el).html().trim();	
		var html        = `<span><span class="localConvertedTime">${localTime2} </span><span class="your_time"></span></span>
												<div><span class="origTime" data-placement=bottom data-toggle="${tooltip ? "tooltip" : ''}" data-title='${tooltip}'>
													(which is ${origHTML} for ${creatorName})</span></div>`
		
		$(el).html(html);	
		// console.log('localTime single',localTime)
		//$(el).closest('.cast_box_li').attr('sortable_time',localTime)
	});

	$('.cast_time_recurring').each((idx,el) => {
		el = $(el);
		
		var ownerID     = el.attr('data-owner_id');
		if (ownerID == window.cuid) return;
		var origDow     = el.attr('data-orig_dow');
		var origHour    = parseInt(el.attr('data-orig_hour'));
		var origMins    = parseInt(el.attr('data-orig_mins'));
		if (origMins<10){ origMins = `0${origMins}`; }
		var ownerOffset = parseInt(el.attr('data-owner_offset'));
		var curOffset   = (new Date).getTimezoneOffset()/-60;
		//debugger
		var hoursDiff   = curOffset - ownerOffset;
		var newHour     = (origHour + hoursDiff) 
		var dow         = origDow;

		if      (newHour > 24) { dow = nextDow(origDow); }
		else if (newHour < 0)  { dow = prevDow(origDow); }

		newHour         = newHour.mod(24);
		suffix          = newHour > 12 ? 'pm' : 'am'
		newHour         = newHour > 12 ? (newHour.mod(12)) : newHour;
		
		var dowName     = dowsHash[dow];
		var localTime   = nextDowDate(dow).addHours(hoursDiff).addMins(origMins);
		var localTime2  = `${dowName} at ${newHour}:${origMins}${suffix}`;		
		var tzName      = (new Date).toString().substring(34);
		var creatorName = el.attr('data-owner_name');
		var tooltip     = (hoursDiff > 0) ? `There is a ${Math.abs(hoursDiff)} hours time difference between you and ${creatorName}.` : '';
		var origHTML    = $(el).html().trim();	
		var html        = `<span><span class="localConvertedTime">${localTime2}</span><span class="your_time"></span></span>
												<div><span class="origTime" data-placement=bottom data-toggle="${tooltip ? "tooltip" : ''}" data-title='${tooltip}'>
												(which is ${origHTML} for ${creatorName})</span></div>`
		

		//$(el).closest('.cast_box_li').attr('sortable_time',localTime)
		$(el).html(html);		
	});


	//$('[data-toggle="tooltip"]').tooltip();
	return 'ok'
}

function onLoadMain() {
	
}

$(document).ready(function() {
	$.material.init(); //init material design
	
	onLoadMain();
	console.log('main.js: done on-document-ready')
}); 