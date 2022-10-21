$(function(){
	window.onload = (e) => {  
		window.addEventListener('message', (event) => {
			var data = event.data;
			if (data !== undefined) {

				if (data.head) {
					$("#nemapuls").show()
					$("#myVideo").hide()
				} else {
					$("#nemapuls").hide()
					$("#myVideo").show()
				}

				switch (data.step) {
					case "Prvi":
						$("body").show()
						break;
					case "timeupdate":
						$("#text").html(data.text)
						$("#vrijeme").html(data.vrijeme)
						break;
					case "ozviljen":
						$("body").hide()
						$("#nemapuls").hide()
						$("#text").html("")
						break;
					
				}

			}
		});
	};
});
