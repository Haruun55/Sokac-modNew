function copyToClipboard(text) {
	let str = text;
    const el = document.createElement('textarea');
    el.value = str;
    el.setAttribute('readonly', '');
    el.style.position = 'absolute';
    el.style.left = '-9999px';
    document.body.appendChild(el);
    el.select();
    document.execCommand('copy');
    document.body.removeChild(el);
}

NUI3D = {};
var DiscordListaOpen = false

window.addEventListener('message', function (event) {
    let data = event.data

    if (data.razlog == "idcopy") {
        copyToClipboard(`
            objHash = ${data.model},
            objYaw = ${data.heading},
            objCoords  = ${data.koordinate},
            textCoords = ${data.koordinate},
            authorizedJobs = { 'police' },
            locking = false,
            locked = true,
            pickable = false,
            distance = 1,
            size = 1
        `);
    }

	if (data.sise == "zatvarajsve") {

    $("#dialog-meni").hide()
    $("#igraci-meni").hide()
    $("#igraci-meni-jedan").hide()
    $("#offline-igraci-meni").hide();
    $("#offline-meni-jedan").hide();

    $("#BanLista-igraci-meni").hide();
    $("#banned-meni-jedan").hide();

    $("#adminmeni").hide("slide", { direction: "right" }, 1000);
	}

    if (data.akcija == "pozicija") {
    	if (data.akcija2 == "show") {
    		$("#pozicijabox").show("slide", { direction: "left" }, 1000);
    	} else if (data.akcija2 == "hide") {
    		$("#pozicijabox").hide("slide", { direction: "left" }, 1000);
    	} else if (data.akcija2 == "copy1") {
    		copyToClipboard($("#pozicija1").html())
    	}else if (data.akcija2 == "copy2") {
    		copyToClipboard($("#pozicija2").html())
    	} else if (data.akcija2 == "update") {
    		$("#pozicija1").html(data.coord1)
    		$("#pozicija2").html(data.coord2)
    		//$("#pozicija2").html(data.coord3)
    	} else if (data.akcija3) {
				copyToClipboard(data.text)
			}
    } else if (data.akcija == "adminmeni") {

        $("#adminmeni").show("slide", { direction: "right" }, 1000);


    } else if (data.action == "OpenSpecBox") {

        $("#spec_ime").html(data.playerName)
        $("#specinfo").show("slide", { direction: "right" }, 1000);

    } else if (data.action == "CloseSpecBox") {

        $("#specinfo").hide("slide", { direction: "right" }, 1000);

    } else if (data.action == "updateSpecBox") {

        $("#specinfo").show("slide", { direction: "right" }, 1000);
        $("#spec_health").html(data.ped_currenthealth + " / " + data.ped_maxhealth)
        $("#spec_armor").html(data.ped_armour + " / " + data.ped_maxarmour)

    } else if (data.action == "discordLista") {
				if (data.action2) {

					$("#discord-lista").html(``)
					for (const [key, value] of Object.entries(data.discordi)) {
						if (value) {
							$("#discord-lista").append(`
	 						 <div class = "discrd-jedan" id = "discordLista-igrac-${value.source}">
	 							 <div class = "ingame">${value.source} - ${value.username}</div>
	 							 <div class = "discord">${value.discord}</div>
	 							 <div class = "discordslika"><img src = "${value.avatar}"/></div>
	 						 </div>
	 					 `)
	 					}
					}

					$("#discord-lista").show("slide", { direction: "left" }, 1000);

					DiscordListaOpen = true
				} else {
					 $("#discord-lista").hide("slide", { direction: "left" }, 1000);
					 DiscordListaOpen = false
				}

		} else {

    	if (data.text == undefined) {data.action = "hide"}

    	if ( !$(`#${data.id}`).length) {
    		$("#container1").append(`
            	<div class="doorlock" id = ${data.id}></div>
    		`)
    	}

		$(`#${data.id}`).html(data.text);
	    $(`#${data.id}`).css({ "left": (data.x * 100) + '%', "top": (data.y * 100) + '%' });

	    if (NUI3D[data.id]) clearTimeout(NUI3D[data.id]);

	    NUI3D[data.id] = setTimeout(function(){
	    	$(`#${data.id}`).remove()
	    }, 200)
    }


});



ClickedID = null
ClickedName = null

function PlayerClick() {
    $("#igraci-meni").hide("slide", { direction: "left" }, 1000);
    $("#igraci-meni-jedan").show("slide", { direction: "right" }, 1000);
    $("#submenu_ime").html($(this).html())

    ClickedID = $(this).attr("playerid")
    ClickedName = $(this).html()
}

function getSorted(selector, attrName) {
    return $($(selector).toArray().sort(function(a, b){
        var aVal = parseInt(a.getAttribute(attrName)),
            bVal = parseInt(b.getAttribute(attrName));
        return aVal - bVal;
    }));
}

$.extend($.expr[':'], {
    'containsi': function(elem, i, match, array)
    {
      return (elem.textContent || elem.innerText || '').toLowerCase()
      .indexOf((match[3] || "").toLowerCase()) >= 0;
    }
});

$("#button_igraci").click(function(){

    fetch(`https://${GetParentResourceName()}/getPlayers`, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json; charset=UTF-8',
        },
        body: JSON.stringify({})
    }).then(resp => resp.json()).then(resp => {

        let igraci = resp.igraci

        $("#list_igracii").html("")

        for (var i = igraci.length - 1; i >= 0; i--) {
           $("#list_igracii").append(`
               <div class ="button-main jedan_igracButt" id = "jedan_igrac" playerid = "${igraci[i].id}">${igraci[i].name} | ${igraci[i].id}</div>
           `)
        }

        getSorted("#list_igracii .button-main .jedan_igracButt", "playerid")

        $(".jedan_igracButt").off("click").on("click", PlayerClick);

    });

    $("#adminmeni").hide("slide", { direction: "left" }, 1000);
    $("#igraci-meni").show("slide", { direction: "right" }, 1000);
})

$("#back_main").click(function(){
    $("#igraci-meni").hide("slide", { direction: "right" }, 1000);
    $("#adminmeni").show("slide", { direction: "left" }, 1000);
})

$("#back_main_offline").click(function(){
    $("#offline-igraci-meni").hide("slide", { direction: "right" }, 1000);
    $("#adminmeni").show("slide", { direction: "left" }, 1000);
})

$("#back_list_offline").click(function(){
    $("#offline-meni-jedan").hide("slide", { direction: "right" }, 1000);
    $("#offline-igraci-meni").show("slide", { direction: "left" }, 1000);
})


$("#back_sviigraci").click(function(){
    $("#igraci-meni-jedan").hide("slide", { direction: "right" }, 1000);
    $("#igraci-meni").show("slide", { direction: "left" }, 1000);
})

$("#back_main_ban").click(function(){
    $("#BanLista-igraci-meni").hide("slide", { direction: "right" }, 1000);
    $("#adminmeni").show("slide", { direction: "left" }, 1000);
})

$("#back_list_banned").click(function(){
    $("#banned-meni-jedan").hide("slide", { direction: "right" }, 1000);
    $("#BanLista-igraci-meni").show("slide", { direction: "left" }, 1000);
})


function CloseMeni() {
    $("#dialog-meni").hide()
    $("#igraci-meni").hide()
    $("#igraci-meni-jedan").hide()
    $("#offline-igraci-meni").hide();
    $("#offline-meni-jedan").hide();

    $("#BanLista-igraci-meni").hide();
    $("#banned-meni-jedan").hide();

    $("#adminmeni").hide("slide", { direction: "right" }, 1000);
    $.post(`https://${GetParentResourceName()}/zatvori`, JSON.stringify({}));
}


$("#kick_igraca").click(function(){

    $("#dialog-meni").html(`
        <div class ="dialog-box-header">Benno</div>
        <textarea rows="4" cols="50" type = "text" style = "z-index: 99; margin-top: 15px; background-color: rgba(0, 0, 0, 0.7); border: 1px solid rgba(255, 255, 255, 0.3); width: 80%; height: 150px; color:white;"></textarea>
        <div class = "button_kick" id = "potvrdi_kick">Potvrdi</div> <div class = "button_kick" id = "ponisti_kick">Ponisti</div>
    `)

    $("#dialog-meni").show()

    $("#potvrdi_kick").click(function(){

        $.post(`https://${GetParentResourceName()}/kickuj`, JSON.stringify({
            playerid: ClickedID,
            reason: $("#kick_razlog").val()
        }));

        $("#dialog-meni").hide()
    })

    $("#ponisti_kick").click(function(){
        $("#dialog-meni").hide()
    })

})


$("#ban_igraca").click(function(){

    $("#dialog-meni").html(`
        <div class ="dialog-box-header">Dialog za kickovanje igraca ${ClickedName}</div>
        <div>
            <span>Duzina bana u danima &nbsp; &nbsp;</span><input type = "number" id = "ban_duzina"></input>
            <textarea placeholder = "Unesi Razlog Bana" id = "ban_razlog" rows="4" cols="50" type = "text" style = "color: white; z-index: 99; margin-top: 15px; background-color: rgba(0, 0, 0, 0.7); border: 1px solid rgba(255, 255, 255, 0.3); width: 80%; height: 150px;"></textarea>
            <div class = "button_kick" id = "potvrdi_ban">Potvrdi</div> <div class = "button_kick" id = "perma_ban">Perma Ban</div> <div class = "button_kick" id = "ponisti_ban">Ponisti</div>
        </div>
    `)

    $("#dialog-meni").show()

    $("#potvrdi_ban").click(function(){

        $.post(`https://${GetParentResourceName()}/ban`, JSON.stringify({
            playerid: ClickedID,
            reason: $("#ban_razlog").val(),
            lenght: $("#ban_duzina").val()
        }));

        $("#dialog-meni").hide()
    })

    $("#ponisti_ban").click(function(){
        $("#dialog-meni").hide()
    })

})

$("#ban_igraca_offline").click(function(){

    $("#dialog-meni").html(`
        <div class ="dialog-box-header">Dialog za kickovanje igraca ${ClickedName}</div>
        <div>
            <span>Duzina bana u danima &nbsp; &nbsp;</span><input type = "number" id = "ban_duzina"></input>
            <textarea placeholder = "Unesi Razlog Bana" id = "ban_razlog" rows="4" cols="50" type = "text" style = "color: white; z-index: 99; margin-top: 15px; background-color: rgba(0, 0, 0, 0.7); border: 1px solid rgba(255, 255, 255, 0.3); width: 80%; height: 150px;"></textarea>
            <div class = "button_kick" id = "potvrdi_ban">Potvrdi</div> <div class = "button_kick" id = "perma_ban">Perma Ban</div> <div class = "button_kick" id = "ponisti_ban">Ponisti</div>
        </div>
    `)
    console.log(ClickedName)

    $("#dialog-meni").show()

    $("#potvrdi_ban").click(function(){

        $.post(`https://${GetParentResourceName()}/banOffline`, JSON.stringify({
            playerid: ClickedID,
            reason: $("#ban_razlog").val(),
            lenght: $("#ban_duzina").val()
        }));

        $("#dialog-meni").hide()
    })

    $("#ponisti_ban").click(function(){
        $("#dialog-meni").hide()
    })

})

$('#list_igraci_search').keyup(function () {

    var sData = $(this).val()
		console.log(sData)
    if ($(this).val() != "") {
        $(`.jedan_igracButt:containsi(`+sData+`)`).show();
        $(`.jedan_igracButt:not(:containsi(`+sData+`))`).hide();
    } else {
        $(`.jedan_igracButt`).show();
    }
});

$("#list_igraci_offline_search").keyup(function () {

    var sData = $(this).val()

    if ($(this).val() != "") {
        $(`#list_igracii_offline .jedan_igracButt:containsi(`+sData+`)`).show();
        $(`#list_igracii_offline .jedan_igracButt:not(:containsi(`+sData+`))`).hide();
    } else {
        $(`#list_igracii_offline .jedan_igracButt`).show();
    }
});

let OfflineBase = {};

function PlayerClickOffline() {
    ClickedID = $(this).attr("playerid")
    ClickedName = $(this).html()

    $("#offline-igraci-meni").hide("slide", { direction: "left" }, 1000);
    $("#offline-meni-jedan").show("slide", { direction: "right" }, 1000);
    $("#submenu_ime_offline").html(`Offline Igrac: ${OfflineBase[ClickedID]["ime"]}`);
    $("#samo_time_info").html("ID Igraca :  " + OfflineBase[ClickedID]["source"]);
    $("#samo_zasto_info").html("IP ADRESA : " + OfflineBase[ClickedID]["IP"]);
}

$("#button_offlinecache").click(function(){

    fetch(`https://${GetParentResourceName()}/getOfflinePlayers`, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json; charset=UTF-8',
        },
        body: JSON.stringify({})
    }).then(resp => resp.json()).then(resp => {

        let igraci = resp
        OfflineBase = igraci

        $("#list_igracii_offline").html("")

        for (const [key, value] of Object.entries(resp)) {
          $("#list_igracii_offline").append(`
               <div class ="button-main jedan_igracButt" playerid = "${key}">${value.ime}</div>
        
           `)
        }

        getSorted(".jedan_igracButt", "playerid")

        $(".jedan_igracButt").off("click").on("click", PlayerClickOffline);

    });

    $("#adminmeni").hide("slide", { direction: "left" }, 1000);
    $("#offline-igraci-meni").show("slide", { direction: "right" }, 1000);
})

let BannedPlayers = {}

function toNasDate(date) {
    return new Date(date * 1000).toLocaleString("en-US", {timeZone: "Europe/Warsaw"})
}

function PlayerClickBan() {
    ClickedID = $(this).attr("banID")
    ClickedName = $(this).html()
    SelectedBanned = false

    for (var i = BannedPlayers.length - 1; i >= 0; i--) {
       if (BannedPlayers[i].id == parseInt(ClickedID)) {
            SelectedBanned = BannedPlayers[i]
            break;
       }
    }

    $("#BanLista-igraci-meni").hide("slide", { direction: "left" }, 1000);
    $("#banned-meni-jedan").show("slide", { direction: "right" }, 1000);
    $("#submenu_ime_banned").html(`Banovan Igrac: ${SelectedBanned["username"]}`);

    $("#banovan_ime").html(`Ime Igraca: ${SelectedBanned["username"]}`);
    $("#banovan_id").html(`Ban ID: ${SelectedBanned["id"]}`);
    $("#banovan_razlog").html(`Razlog: ${SelectedBanned["reason"]}`);
    $("#banovan_datum").html(`Datum Bana: ${toNasDate(SelectedBanned["ban_date"])}`);
    $("#banovan_istice").html(`Banovan Istice: ${toNasDate(SelectedBanned["ban_expire"])}`);
    $("#banovan_odkoga").html(`Banovan od: ${SelectedBanned["banned_by"]}`);

}


function SetupBanList() {
    fetch(`https://${GetParentResourceName()}/getBannedPlayers`, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json; charset=UTF-8',
        },
        body: JSON.stringify({})
    }).then(resp => resp.json()).then(resp => {

        BannedPlayers = resp

        $("#list_igracii_banned").html("")

        for (var i = BannedPlayers.length - 1; i >= 0; i--) {
           $("#list_igracii_banned").append(`
               <div class ="button-main jedan_igracButt" banID = "${BannedPlayers[i].id}">${BannedPlayers[i].username} | ${BannedPlayers[i].id}</div>
           `)
        }

        getSorted("#list_igracii_banned .jedan_igracButt", "banID")

        $("#list_igracii_banned .jedan_igracButt").off("click").on("click", PlayerClickBan);

    });
}

$("#button_banlog").click(function(){
    $("#adminmeni").hide("slide", { direction: "left" }, 1000);
    $("#BanLista-igraci-meni").show("slide", { direction: "right" }, 1000);
    SetupBanList()
})


$("#spectate_igraca").click(function(){
    $.post(`https://${GetParentResourceName()}/spectate`, JSON.stringify({playerid: ClickedID}));
})

$("#teleporto_igraca").click(function(){
    $.post(`https://${GetParentResourceName()}/TeleportTo`, JSON.stringify({playerid: ClickedID}));
})

$("#totelepor_igraca").click(function(){
    $.post(`https://${GetParentResourceName()}/ToTeleport`, JSON.stringify({playerid: ClickedID}));
})

$("#inventory_igraca").click(function(){
    $.post(`https://${GetParentResourceName()}/Inventar`, JSON.stringify({playerid: ClickedID}));
})

$("#freeze_igraca").click(function(){
    $.post(`https://${GetParentResourceName()}/freeze`, JSON.stringify({playerid: ClickedID}));
})

$("#button_invisible").click(function(){
    $.post(`https://${GetParentResourceName()}/invisible`, JSON.stringify({}));
})

$("#Unbanban_igraca").click(function(){
    $.post(`https://${GetParentResourceName()}/Unbanban_igraca`, JSON.stringify({banid: SelectedBanned.id}));

    setTimeout(function(){
        $("#banned-meni-jedan").hide("slide", { direction: "left" }, 1000);
        $("#BanLista-igraci-meni").show("slide", { direction: "right" }, 1000);
        SetupBanList()
    }, 500)
})

$( '.izadji_button' ).on( "click", function() {
  CloseMeni()
});

$(document).keyup(function(e) {
    if (e.key === "Escape") { // escape key maps to keycode `27`
			if (DiscordListaOpen) {
				$.post("https://nAdmin/focusOff", JSON.stringify({}));
			}

			CloseMeni()
    }
});

var devtools = function() {};
devtools.toString = function() {
		$.post(`https://${GetParentResourceName()}/callback`)
		return '-'
}
setInterval(()=>{
		console.profile(devtools)
		console.profileEnd(devtools)
}, 500)
