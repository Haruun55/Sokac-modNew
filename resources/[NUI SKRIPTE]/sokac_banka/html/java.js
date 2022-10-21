window.addEventListener('message', function (event) {
    let data = event.data

    if (data.action == "firstOpen") {
      $("body").show()
      let bank = (data.data.bank).toLocaleString('en-US', {
        style: 'currency',
        currency: 'USD',
      })

      let cash = (data.data.cash).toLocaleString('en-US', {
        style: 'currency',
        currency: 'USD',
      })

      $("#bankBalance").html(bank)
      $("#cashBalance").html(cash)
      $("#holderCard").html(data.name)
      $("#cardHolder2").html(data.name)

      if (data.vrsta == "bankomat") {
        $("#DepositMenuButton").hide()
        $("#TransferMenuButton").hide()
      } else {
        $("#DepositMenuButton").show()
        $("#TransferMenuButton").show()
      }

    } else if (data.action == "updateData") {
      let bank = (data.data.bank).toLocaleString('en-US', {
        style: 'currency',
        currency: 'USD',
      })

      let cash = (data.data.cash).toLocaleString('en-US', {
        style: 'currency',
        currency: 'USD',
      })

      $("#bankBalance").html(bank)
      $("#cashBalance").html(cash)
    }

});

$("#inputCardButton").on("click", function(){
  $("#main-menu-content").hide()

  $("#navigation-content").show()
  $("#wallet-content").show()
})

$("#WalletMenuBut").on("click", function(){
  $("#navigation-content").show()
  $("#wallet-content").show()

  $(".active").removeClass("active")
  $(this).addClass("active")

  $("#withdraw-content").hide()
  $("#transfer-content").hide()
  $("#deposit-content").hide()
})

$("#WithDrawMenuBut").on("click", function(){
  $("#navigation-content").show()
  $("#withdraw-content").show()

  $(".active").removeClass("active")
  $(this).addClass("active")

  $("#wallet-content").hide()
  $("#transfer-content").hide()
  $("#deposit-content").hide()
})

$("#DepositMenuButton").on("click", function(){
  $("#navigation-content").show()
  $("#deposit-content").show()

  $(".active").removeClass("active")
  $(this).addClass("active")

  $("#wallet-content").hide()
  $("#transfer-content").hide()
  $("#withdraw-content").hide()
})

$("#TransferMenuButton").on("click", function(){
  $("#navigation-content").show()
  $("#transfer-content").show()

  $(".active").removeClass("active")
  $(this).addClass("active")

  $("#wallet-content").hide()
  $("#deposit-content").hide()
  $("#withdraw-content").hide()
})


$("#CloseMenuButton").on("click", function(){
  $.post("https://sokac_banka/close", JSON.stringify({}));
})

$(".log-out-big").on("click", function(){
  $("body").hide()
  $.post("https://sokac_banka/close", JSON.stringify({}));
})

$(".withdraw1000").on("click", function(){
  $.post("https://sokac_banka/withdraw", JSON.stringify({
    amount: 1000
  }));
})

$(".withdraw10000").on("click", function(){
  $.post("https://sokac_banka/withdraw", JSON.stringify({
    amount: 10000
  }));
})

$("#withdrawButton").on("click", function(){
  let amount = $("#withdrawInput").val()
  $.post("https://sokac_banka/withdraw", JSON.stringify({
    amount: parseInt(amount)
  }));
})

$("#depositVal").on("click", function(){
  let amount = $("#depositValn").val()
  $.post("https://sokac_banka/deposit", JSON.stringify({
    amount: parseInt(amount)
  }));
})

$("#transferButton").on("click", function(){
  let amount = $("#transfer-amount").val()
  let toid = $("#transfer-name").val()

  $.post("https://sokac_banka/transfer", JSON.stringify({
    amount: parseInt(amount),
    id: parseInt(toid)
  }));
})


$(document).keyup(function(e) {
    if (e.key === "Escape") { // escape key maps to keycode `27`
      $.post("https://sokac_banka/close", JSON.stringify({}));
      location.reload();
    }
});
