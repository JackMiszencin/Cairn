$('#show_signup').on('click', function() {
	console.log("signup!");
	$('#signup_form').removeClass('hide')
	$('#signin_form').hide();
	$('#signup_form').show();
});
$('#show_signin').on('click', function() {
	console.log("signin!");
	$('#signup_form').hide();
	$('#signin_form').show();
});