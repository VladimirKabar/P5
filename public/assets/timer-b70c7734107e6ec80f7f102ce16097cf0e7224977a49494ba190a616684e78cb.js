function odliczanie() {
    var today = new Date();
    var day = today.getDate();
    var month = today.getMonth() + 1;
    var year = today.getFullYear();
    var hour = today.getHours();
    var minute = today.getMinutes();
    var sec = today.getSeconds();

    if (day < 9) day = "0" + today.getDate();
    if (month < 9) month = "0" + (today.getMonth()+1);
    if (sec < 9) sec = "0" + today.getSeconds();
    if (minute < 9) minute = "0" + today.getMinutes();
    if (hour < 9) hour = "0" + today.getHours();

    document.getElementById("zegar").innerHTML = day + "/" + month + "/" + year + " | " + hour + ":" + minute + ":" + sec;
    setTimeout("odliczanie()", 1000);
}
