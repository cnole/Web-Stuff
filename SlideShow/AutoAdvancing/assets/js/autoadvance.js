$(function() {
	var timeOut = null;
	
	$('#slideshow .arrow').click(function(e, simulated) {
		
		if (!simulated) {
			clearTimeout(timeOut);
		}
		
	});
	
	(function autoAdvance() {
		$('slideshow .next').trigger('click', [true]);
		
		timeOut = setTimeout(autoAdvance, 5000);
	})();
});