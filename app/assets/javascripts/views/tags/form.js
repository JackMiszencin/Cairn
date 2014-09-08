var radiusDefault = Number($("#tag_radius").val());

function setDefaults(realmLat, realmLng, mapScope) {
	var radiusDegreesY = Number($("#hidden_realm_radius").val() || 90);
	var radiusDegreesX = Number($("#hidden_realm_radius").val() || 180);
	realmLat = Number($("#hidden_realm_lat").val() || 0);
	realmLng = Number($("#hidden_realm_lng").val() || 0);
	var NE = new google.maps.LatLng((realmLat + radiusDegreesY), (realmLng + radiusDegreesX));
	var SW = new google.maps.LatLng((realmLat - radiusDegreesY), (realmLng - radiusDegreesX));
	mapScope = new google.maps.LatLngBounds(SW, NE);
}

function addCircle(map, markerPoint, markerCircle){
	markerCircle = new google.maps.Circle({
		map:map,
		center:markerPoint,
		radius:radiusDefault,
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
	$("#tag_lat").val(newLatLng.lat());
	$("#tag_lng").val(newLatLng.lng());				
};

function addMarker(event, map){
	var markerCircle;
	var markerPoint = event.latLng;
	var marker = new google.maps.Marker({
		map:map,
		draggable:true,
		position:markerPoint,
		animation: null
	});
	$("#tag_lat").val(markerPoint.lat());
	$("#tag_lng").val(markerPoint.lng());				
	$("#submit_tag").attr("type", "submit") // TODO: Do we need this? What the fuck is this for?

	google.maps.event.addListenerOnce(map, 'click',
		function() {
			addCircle(map, markerPoint, markerCircle);
		}
	);
	google.maps.event.trigger(map, 'click')
	google.maps.event.addListener(marker, 'drag', function() {
		recenterCircle(marker, markerCircle);
	});
	$("#tag_radius").on("click", function(){
		newRadius = Number($(this).val());
		markerCircle.setRadius(newRadius);
	});
	$("#tag_radius").on("keyup", function(){
		rFeed = String($(this).val());
		newRadius = Number(rFeed);
		markerCircle.setRadius(newRadius);
	});
};


function initialize() {
	var realmLat, realmLng, mapScope;

	// setDefaults
	setDefaults();

	var mapOptions = {
	    center: new google.maps.LatLng(realmLat, realmLng),
	    zoom: 8,
	    mapTypeId: google.maps.MapTypeId.HYBRID
	};
	var map = new google.maps.Map(document.getElementById("map-canvas"), mapOptions);

	google.maps.event.addListenerOnce(map, 'click',
		function (e) {
			addMarker(e, map);
		}
	);

	$("#types").on('click', function(){
		var typeId = String($("#types").val());
		typeId = "#" + typeId;
		radiusDefault = Number($(typeId).val());
		$("#tag_radius").val(radiusDefault);
	});
	map.fitBounds(mapScope);
};

google.maps.event.addDomListener(window, 'load', initialize);
