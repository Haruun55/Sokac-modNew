$(window).on("load resize ", function() {
  var scrollWidth = $('.tbl-content').width() - $('.tbl-content table').width();
  $('.tbl-header').css({'padding-right':scrollWidth});
}).resize();

var GlobalPerms = {}

window.addEventListener('message', function (event) {
    let data = event.data

    if (data.action == "open") {
      $(".wrapper").show()
      $(".OrgTitle").html(`Postavke za : ${data.jobLabel}`)

      GlobalPerms = data.perms
      permsSetup(data.perms)
    }
});


function permsSetup(perms) {

  if (!perms.clanovi) {
    $("#clanovi_Headerbutton").addClass("disabledButt");
  } else {
    $("#clanovi_Headerbutton").removeClass("disabledButt");
  }

  if (!perms.zaposljavanje) {
    $("#zaposljavanje_Headerbutton").addClass("disabledButt");
  } else {
    $("#zaposljavanje_Headerbutton").removeClass("disabledButt");
  }

  if (!perms.uplacivanje) {
    $("#ilegal_uplati").addClass("disabledButt");
    $("#legal_uplati").addClass("disabledButt");

  } else {
    $("#ilegal_uplati").removeClass("disabledButt");
    $("#legal_uplati").removeClass("disabledButt");
  }

  if (!perms.podizanje) {
    $("#legal_podigni").addClass("disabledButt");
    $("#ilegal_podigni").addClass("disabledButt");

  } else {
    $("#ilegal_podigni").removeClass("disabledButt").attr("title", "");
    $("#legal_podigni").removeClass("disabledButt").attr("title", "");
  }

  if (!perms.podizanje) {
    $("#legal_podigni").addClass("disabledButt");
    $("#ilegal_podigni").addClass("disabledButt");

  } else {
    $("#ilegal_podigni").removeClass("disabledButt").attr("title", "");
    $("#legal_podigni").removeClass("disabledButt").attr("title", "");
  }

  if (!perms.permisije) {
    $("#permisije_Headerbutton").addClass("disabledButt");

  } else {
    $("#permisije_Headerbutton").removeClass("disabledButt").attr("title", "");
  }

  if (!perms.plate) {
    $(".promijeni_platu").addClass("disabledButt");

  } else {
    $(".promijeni_platu").removeClass("disabledButt").attr("title", "");
  }

}


$("#plate_Headerbutton").off("click").on("click", function(){

  if ($(this).hasClass("disabledButt")) return;

  $(".activeContainer").removeClass("activeContainer");
  $(".plate_div").addClass("activeContainer")

  function SetupPlate(){

   $(".plate_div .tbl-content tbody").html(``)

    fetch(`https://${GetParentResourceName()}/fetchAllPlate`, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json; charset=UTF-8',
        },
        body: JSON.stringify({
        })
    }).then(resp => resp.json()).then(function(resp){

      resp.sort(function (x, y) {
          return x.grade - y.grade;
      });

      resp.forEach(function(item){
        $(".plate_div .tbl-content tbody").append(`
          <tr plataID = ${item.grade}>
            <td>${item.label}</td>
            <td>${item.salary}</td>
            <td><input type = "number" class = "promjena_plate"/></td>
            <td><div class = "in_tableButton promijeni_platu">Osvjezi</div></td>
          </tr>
        `)

        if (!GlobalPerms.plate) {
            $(".in_tableButton").addClass("disabledButt")
        } else {
            $(".in_tableButton").removeClass("disabledButt")
        }

      })

      $(".promijeni_platu").off("click").on("click", function(){
        if ($(this).hasClass("disabledButt")) return;

        let grade = $(this).closest("tr").attr("plataID")
        let novaplata = $(this).closest('tr').find("input").val()

        $.post(`https://${GetParentResourceName()}/promijeniPlatu`, JSON.stringify({
            grade: grade,
            novaplata: novaplata
        }));

        setTimeout(function(){
            $.post(`https://${GetParentResourceName()}/refreshMeni`, JSON.stringify({}));
            SetupPlate()
        }, 500)
      })

    })
  }

  SetupPlate()
})


$("#clanovi_Headerbutton").off("click").on("click", function(){

  if ($(this).hasClass("disabledButt")) return;

  $(".activeContainer").removeClass("activeContainer");
  $(".clanovi_div").addClass("activeContainer")

  function SetupClanovi(){

   $(".clanovi_div .tbl-content tbody").html(``)

    fetch(`https://${GetParentResourceName()}/fetchAllMembers`, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json; charset=UTF-8',
        },
        body: JSON.stringify({
        })
    }).then(resp => resp.json()).then(function(resp){

      resp.sort(function (x, y) {
          return x.grade_number - y.grade_number;
      });

      resp.forEach(function(item){
        $(".clanovi_div .tbl-content tbody").append(`
          <tr personID = ${item.identifier} grade = ${item.grade_number}>
            <td>${item.firstname}</td>
            <td>${item.lastname}</td>
            <td>${item.grade_label + " (" + item.grade_number + ")"}</td>
            <td><div class = "in_tableButton unaprijedi_clana" id = "unaprijedi_clana"><i class="fas fa-arrow-alt-circle-up"></i> Promoviraj</div></td>
            <td><div class = "in_tableButton spusti_clana" id = "spusti_clana"><i class="fas fa-arrow-alt-circle-down"></i> Degradiraj</div></td>
            <td><div class = "in_tableButton otpusti_clana" id = "otpusti_clana"><i class="fas fa-times-circle"></i> Otkaz</div></td>
          </tr>
        `)

        if (!GlobalPerms.rankovi) {
            $(".in_tableButton").addClass("disabledButt")
        } else {
            $(".in_tableButton").removeClass("disabledButt")
        }

      })

      $(".unaprijedi_clana").off("click").on("click", function(){
        if ($(this).hasClass("disabledButt")) return;

        let osoba = $(this).closest("tr").attr("personID")

        $.post(`https://${GetParentResourceName()}/unaprijediClana`, JSON.stringify({
            identifier: osoba,
            grade: $(this).closest("tr").attr("grade")

        }));

        setTimeout(function(){
            $.post(`https://${GetParentResourceName()}/refreshMeni`, JSON.stringify({}));
            SetupClanovi()
        }, 500)
      })

      $(".spusti_clana").off("click").on("click", function(){
        if ($(this).hasClass("disabledButt")) return;

        let osoba = $(this).closest("tr").attr("personID")
        $.post(`https://${GetParentResourceName()}/spustiClana`, JSON.stringify({
            identifier: osoba,
            grade: $(this).closest("tr").attr("grade")
        }));

        setTimeout(function(){
            $.post(`https://${GetParentResourceName()}/refreshMeni`, JSON.stringify({}));
            SetupClanovi()
        }, 500)
      })

      $(".otpusti_clana").off("click").on("click", function(){
        if ($(this).hasClass("disabledButt")) return;

        let osoba = $(this).closest("tr").attr("personID")
        $.post(`https://${GetParentResourceName()}/otpustiClana`, JSON.stringify({
            identifier: osoba,
            grade: $(this).closest("tr").attr("grade")
        }));

        setTimeout(function(){
            $.post(`https://${GetParentResourceName()}/refreshMeni`, JSON.stringify({}));
            SetupClanovi()
        }, 500)
      })

    })
  }

  SetupClanovi()
})

$("#zaposljavanje_Headerbutton").off("click").on("click", function(){

  if ($(this).hasClass("disabledButt")) return;

  $(".activeContainer").removeClass("activeContainer");
  $(".zaposljavanje_div").addClass("activeContainer")
    function ZaposliSetup() {

      $(".zaposljavanje_div .tbl-content tbody").html('')

      fetch(`https://${GetParentResourceName()}/getClosestPlayers`, {
          method: 'POST',
          headers: {
              'Content-Type': 'application/json; charset=UTF-8',
          },
          body: JSON.stringify({
          })
      }).then(resp => resp.json()).then(function(resp){

          resp.forEach(function(item){
            $(".zaposljavanje_div .tbl-content tbody").append(`
              <tr identifier = ${item.identifier} >
                <td>${item.name}</td>
                <td>${item.lastname}</td>
                <td><div class = "in_tableButton"><i class="fas fa-sign-in-alt"></i> Zaposli</div></td>
              </tr>
            `)
          })

          $(".zaposljavanje_div .tbl-content tbody td .in_tableButton").off("click").on("click", function(){

            $.post(`https://${GetParentResourceName()}/zaposliOsobu`, JSON.stringify({
                identifier: $(this).closest("tr").attr("identifier"),
            }));

            setTimeout(function(){
              $.post(`https://${GetParentResourceName()}/refreshMeni`, JSON.stringify({}));
              ZaposliSetup()
            }, 500)

          })
      })

    }

    ZaposliSetup()
})

$("#permisije_Headerbutton").off("click").on("click", function(){

  if ($(this).hasClass("disabledButt")) return;

  $(".activeContainer").removeClass("activeContainer");
  $(".permisije_div").addClass("activeContainer")

  function RankPermSetup() {

      $(".permisije_div .tbl-content tbody").html('')

    fetch(`https://${GetParentResourceName()}/getRankPerms`, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json; charset=UTF-8',
        },
        body: JSON.stringify({
        })
    }).then(resp => resp.json()).then(function(resp){

      resp.sort(function (x, y) {
          return x.grade - y.grade;
      });

        resp.forEach(function(item){
          $(".permisije_div .tbl-content tbody").append(`
            <tr ovajRank = ${item.grade} >
              <td>${item.label}</td>
              <td vrsta = "uplacivanje">${item.uplacivanje ? "Dozvoljeno" : "Nije dozvoljeno"}</td>
              <td vrsta = "podizanje">${item.podizanje ? "Dozvoljeno" : "Nije dozvoljeno"}</td>
              <td vrsta = "rankovi">${item.rankovi ? "Dozvoljeno" : "Nije dozvoljeno"}</td>
              <td vrsta = "clanovi">${item.clanovi ? "Dozvoljeno" : "Nije dozvoljeno"}</td>
              <td vrsta = "zaposljavanje">${item.zaposljavanje ? "Dozvoljeno" : "Nije dozvoljeno"}</td>
              <td vrsta = "permisije">${item.permisije ? "Dozvoljeno" : "Nije dozvoljeno"}</td>
              <td vrsta = "plate">${item.plate ? "Dozvoljeno" : "Nije dozvoljeno"}</td>
            </tr>
          `)
        })

        $(".permisije_div .tbl-content tbody td").off("click").on("click", function(){
          let vrsta = $(this).attr("vrsta")

          if (vrsta) {
            $.post(`https://${GetParentResourceName()}/updatePerm`, JSON.stringify({
                rank: $(this).closest("tr").attr("ovajRank"),
                vrsta: vrsta
            }));

            setTimeout(function(){
              $.post(`https://${GetParentResourceName()}/refreshMeni`, JSON.stringify({}));
              RankPermSetup()
            }, 500)
          }

        })
    })

  }

  RankPermSetup()

})

$("#finansije_Headerbutton").off("click").on("click", function(){

  if ($(this).hasClass("disabledButt")) return;

  $(".activeContainer").removeClass("activeContainer");
  $(".finansije_div").addClass("activeContainer")

  function SetupTrezor() {
    fetch(`https://${GetParentResourceName()}/getOrgMoney`, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json; charset=UTF-8',
        },
        body: JSON.stringify({
        })
    }).then(resp => resp.json()).then(function(resp){

        $("#UkupnoKolicina-Legalno").html(resp.money);
        $("#UkupnoKolicina-Ilegalno").html(resp.black);

        $("#legal_uplati").off("click").on("click", function(){
          if ($(this).hasClass("disabledButt")) return;

          $.post(`https://${GetParentResourceName()}/orgUplati`, JSON.stringify({
              vrsta: "money",
              kolicina: $("#legalno").val()
          }));

        })

        $("#legal_podigni").off("click").on("click", function(){
          if ($(this).hasClass("disabledButt")) return;

          $.post(`https://${GetParentResourceName()}/orgPodigni`, JSON.stringify({
              vrsta: "money",
              kolicina: $("#legalno").val()
          }));

        })

        $("#ilegal_uplati").off("click").on("click", function(){
          if ($(this).hasClass("disabledButt")) return;

          $.post(`https://${GetParentResourceName()}/orgUplati`, JSON.stringify({
              vrsta: "black",
              kolicina: $("#ilegalno").val()
          }));

        })

        $("#ilegal_podigni").off("click").on("click", function(){
          if ($(this).hasClass("disabledButt")) return;
          
          $.post(`https://${GetParentResourceName()}/orgPodigni`, JSON.stringify({
              vrsta: "black",
              kolicina: $("#ilegalno").val()
          }));

        })

        setTimeout(function(){
          SetupTrezor()
        }, 500)
    })

  }

  SetupTrezor()

})

$(document).keydown(function(e) {
  if (e.key === "Escape") {
    $(".wrapper").hide()
    $.post(`https://${GetParentResourceName()}/zatvoriMeni`, JSON.stringify({}));
  }
});
