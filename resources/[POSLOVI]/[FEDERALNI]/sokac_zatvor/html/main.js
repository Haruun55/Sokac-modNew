$(function(){
	window.onload = (e) => {  
		notifID = 0
		window.addEventListener('message', (event) => {
			var data = event.data;
			if (data !== undefined) {
				if (data.akcija == "pokazi") {
					$("#glavno").show()
					$("#info").show()
				} else if(data.akcija == "infoclose") {
					$("#info").hide()
				} else if(data.akcija == "update") {
					$("#mins").html(data.min)
					$("#secs").html(data.secs)
				} else if (data.akcija == "Notifikacija") {
					notifID = notifID + 1
					$("#NotifList").append(`
						<div class = "TestInner" id = "notifID`+ notifID +`">
							<span class = "titleZatvor">Drzavni Zatvor</span>
							<div class = "doubleZatvor">
								<img class = "textImage" src="https://i.imgur.com/S2Vc5yM.png">
								<div class = "textZatvor">Osoba <span style ="color:white;">`+ data.ime +`</span> je sprovedena u drzavni zatvor na odsluzivanje kazne od <span style ="color:white;">`+ data.vrijeme +`</span> mjeseci/a zbog: <span style ="color:white;">`+data.razlog+`</span></div>
							</div>
						</div>
					`)

					$("#notifID"+notifID).show("slide", {direction: "left"}, 700);
					setTimeout(SakrijNotifZatvor, 10000, notifID);

				} else if (data.akcija == "zatvori") {
					$("#glavno").hide()
					$("#info").hide()
				} else {
					$("#glavno").hide()
					$("#info").hide()
				}
			}
		});

	};
});

function SakrijNotifZatvor(notifID) {
	$("#notifID"+notifID).hide("slide", {direction: "left"}, 700);
}