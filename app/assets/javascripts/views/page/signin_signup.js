$(document).ready(function() {
	$('#show_signup').on('click', function() {
		$('#signup_form').removeClass('hide')
		$('#signin_form').hide();
		$('#signup_form').show();
	});
	$('#show_signin').on('click', function() {
		$('#signup_form').hide();
		$('#signin_form').show();
	});
});