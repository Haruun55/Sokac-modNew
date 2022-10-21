$(function(){
	window.onload = (e) => {

		window.addEventListener('message', (event) => {
			var DissTim = null
			var item = event.data;
			if (item !== undefined) {
				if (item.pokazano === false) {
					zatvoriscreen()
					$('#coords').hide();

				} else if (item.pokazano === true) { 

					$('#coords').show();
					var leveldiv = document.getElementById("coords");
					leveldiv.innerHTML = item.pozicija;

				} else if (item.pokazano === "refresh") {

					var leveldiv = document.getElementById("coords");
					leveldiv.innerHTML = item.pozicija;

				}

				else if (item.pokazano === "kopiraj") {
					kopiraj()
				}
				
				else if (item.type == "txt")

				{ document.getElementById("data").innerHTML = item.html; }

				else if (item.type === "aa") {
					
					if(DissTim) {
						clearTimeout(DissTim)
					}
					document.getElementById("aaa").innerHTML = item.html;
					DissTim = setTimeout(function(){document.getElementById("aaa").innerHTML = ""}, 900);
				}

				else if (item.type === "bb") {
					copyToClipboard(item.skin); 
				}
			}
		});
	};
});


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


function zatvoriscreen() {
	$(".coords").hide();
    $.post('http://sokac_skripte/zatvori', JSON.stringify({}));
}

$(document).keydown(function(e) {
     if (e.key === "Escape" || e.key === "e") {
        zatvoriscreen()
    }
});

function kopiraj() {

	var range = document.createRange();
	range.selectNode(document.getElementById("coords"));
	window.getSelection().removeAllRanges(); // clear current selection
	window.getSelection().addRange(range); // to select text
	document.execCommand("copy");
	window.getSelection().removeAllRanges();// to deselect
  
}

