Pol = ""
function izaberi_pol(self,broj){
    if (self.checked == true){
        document.getElementById(broj).checked = false
    }
    if (self.checked == false){
        self.checked = true
    }
}


$(function() {
    window.addEventListener('message', function(event) {
        if (event.data.type == "enableui") {
            document.body.style.display = event.data.enable ? "flex" : "none";
        }
    });

    document.onkeyup = function (data) {
        if (data.which == 27) { // Escape key
            $.post('http://sokac_register/escape', JSON.stringify({}));
        }
    };
    
    $("#register").submit(function(event) {
        event.preventDefault(); // Prevent form from submitting
        
        // Verify date
        var date = $("#dateofbirth").val();
        var dateCheck = new Date($("#dateofbirth").val());

        if (dateCheck == "Invalid Date") {
            date == "invalid";
        }

        if (document.getElementById("1").checked){
            Pol = "m"
        }
        else{
            Pol = "f"
        }

        $.post('http://sokac_register/register', JSON.stringify({
            firstname: $("#firstname").val(),
            lastname: $("#lastname").val(),
            dateofbirth: date,
            sex: Pol,
            height: $("#height").val()
        }));
    });
});

$(".txtb input").on("focus",function(){
$(this).addClass("focus");
});

$(".txtb input").on("blur",function(){
if($(this).val() == "")
$(this).removeClass("focus");
});

function showHelp() {
  var x = document.getElementById("pomoc");
  if (x.style.display === "none") {
    x.style.display = "flex";
  } else {
    x.style.display = "none";
  }
}

document.getElementById("1").click()