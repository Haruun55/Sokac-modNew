function ClearAllClases(ob) {
	ob.removeClass("green")
	ob.removeClass("yellow")
	ob.removeClass("red")
  }
  
$(function() {
	window.addEventListener('message', function(event) {
		switch (event.data.action) {
			case 'open':
				console.log("otvorio1")
				$("#stats").fadeIn(800)
				break;
			case 'close':
				console.log("zatvorio")
				$("#stats").fadeOut(800)
				break;
			case 'updatePlayerJobs':
				var jobs 		= event.data.jobs;
/* 				var setJob      = event.data.data;
				var setRank     = event.data.data2; */
				var payPal      = event.data.data3;


				$('#player_count').html(jobs.player_count);
				$('#policecircle').html(jobs.police);
				$('#mechaniccircle').html(jobs.mechanic);
				$('#ambulance').html(jobs.ambulance);
				$('#jobless').html(jobs.jobless);
/* 				$('#jobs').text(setJob);
				$('#ranks').text(setRank); */
				$('#ids').text(payPal);

				

			break;
		}
	}, false);

	window.addEventListener('message', function(event) {
		 if (event.data.message == "updateMoney") {
			$("#kes").html(event.data.kes + "$")
			$("#banka").html(event.data.banka + "$")
		
		  }
	})

	document.onkeyup = function (data) {
		if (data.which == 8) { // Escape key
			$.post(`https://${GetParentResourceName()}/escape`, JSON.stringify({}));
		}
	};

});

