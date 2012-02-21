$(function() {
	
	var container = $('#container'),
			li = container.find('li');
	
	container.shutterize({
		imgSrc: 'assets/jquery.shutter/shutter.png',
		
		closeCallback: function() {
			li.filter(':visible:first').hide();
			
			if (li.filter(':visible').length == 0) {
				li.show();
			}
			
			setTimeout(function() {
				container.trigger('shutterOpen')
			}, 100);
		},
		
		loadCompleteCallback: function() {
			setInterval(function() {
				container.trigger('shutterClose');
			}, 4000);
			
			container.trigger('shutterClose');
		}
	})
	
});