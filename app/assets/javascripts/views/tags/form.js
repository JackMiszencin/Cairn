var radiusDefault, latLngDefault;
var mapScope, realmLat, realmLng, markerCircle;

function setDefaults() {
	var radiusDegreesDefault;
	if ($("#tag_radius").val()) {
		radiusDefault = Number($("#tag_radius").val());
	}
	if ($("#hidden_tag_radius_degrees").val()) {
		radiusDegreesDefault = Number($("#hidden_tag_radius_degrees").val());
	}
	var latDefault = $("#hidden_tag_lat").val();
	var lngDefault = $("#hidden_tag_lng").val();
	if (latDefault && lngDefault) {
		latLngDefault = new google.maps.LatLng(Number(latDefault), Number(lngDefault));
	}
	var radiusDegreesY = Number(radiusDegreesDefault || $("#hidden_realm_radius").val() || 55);
	var radiusDegreesX = Number(radiusDegreesDefault || $("#hidden_realm_radius").val() || 100);
	realmLat = Number(latDefault || $("#hidden_realm_lat").val() || 0);
	realmLng = Number(lngDefault || $("#hidden_realm_lng").val() || 0);
	var NE = new google.maps.LatLng((realmLat + radiusDegreesY), (realmLng + radiusDegreesX));
	var SW = new google.maps.LatLng((realmLat - radiusDegreesY), (realmLng - radiusDegreesX));
	mapScope = new google.maps.LatLngBounds(SW, NE);
}

function addCircle(map, markerPoint){
	markerCircle = new google.maps.Circle({
		map:map,
		center:markerPoint,
		radius:(radiusDefault || 0),
		fillColor:"#EEEEEE",
		fillOpacity:0.5,
		strokeColor:"#EEEEEE",
		strokeOpacity:1.0
	});
	$("#tag_type_id").on('click', function(){
		var typeId = String($("#tag_type_id").val());
		typeId = "#" + typeId;
		markerCircle.setRadius(Number($(typeId).val()));
	});
};

function recenterCircle(marker, markerCircle){
	var newLatLng = marker.getPosition();
	markerCircle.setCenter(newLatLng);
	var lngLatString = 'POINT(' + String(newLatLng.lng()) + ' ' + String(newLatLng.lat()) + ')';
	$("#tag_center").val(lngLatString);
};

function addMarker(event, map){
	var markerPoint = event.latLng;
	var marker = new google.maps.Marker({
		map:map,
		draggable:true,
		position:markerPoint,
		animation: null
	});
	var lngLatString = 'POINT(' + String(markerPoint.lng()) + ' ' + String(markerPoint.lat()) + ')';
	$("#tag_center").val(lngLatString);

	addCircle(map, markerPoint);
	google.maps.event.trigger(map, 'click')
	google.maps.event.addListener(marker, 'drag', function() {
		recenterCircle(marker, markerCircle);
	});
};

// Creates and returns a google map object;
function createMap() {
	var mapOptions = {
	    center: new google.maps.LatLng(realmLat, realmLng),
	    zoom: 8,
	    mapTypeId: google.maps.MapTypeId.HYBRID
	};
	var map = new google.maps.Map(document.getElementById("map-canvas"), mapOptions);	
	return map;
}

function setRadiusListeners() {
	function tagCallback() {
		radiusDefault = Number($("#tag_radius").val());
		if (markerCircle) {
			markerCircle.setRadius(radiusDefault);
		}
	}
	$("#tag_radius").on('click', tagCallback);
	$("#tag_radius").on('keyup', tagCallback);	
}

function setTagTypeListener() {
	function tagTypeCallback() {
		var typeId = String($("#tag_tag_type_id").val());
		typeId = "#tag_type_" + typeId;
		if ($(typeId).val()) {
			radiusDefault = Number($(typeId).val());
			$("#tag_radius").val(radiusDefault);
			if (markerCircle) {
				markerCircle.setRadius(radiusDefault);
			}
		}
	}
	$("#tag_tag_type_id").on('click', tagTypeCallback);
	$("#tag_tag_type_id").on('keyup', tagTypeCallback);
}

function initialize() {
	setDefaults();
	var map = createMap();
	setRadiusListeners();
	setTagTypeListener();
	map.fitBounds(mapScope);

	if (radiusDefault && latLngDefault) {
		var obj = {
			latLng: latLngDefault
		}
		addMarker(obj, map);
	} else {
		google.maps.event.addListenerOnce(map, 'click', function (e) { addMarker(e, map); });
	}

};

function waitForScript() {
	console.log("waitForScript");
	if (typeof google !== 'undefined') {
		google.maps.event.addDomListener(window, 'load', initialize);
		return true;
	} else {
		setTimeout(waitForScript, 50);
	}
};

waitForScript();