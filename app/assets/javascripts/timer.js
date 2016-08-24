myVar1 = setTimeout("odliczanie()", 1000);

function odliczanie() {
    var today = new Date();
    var day = today.getDate();
    var month = today.getMonth() + 1;
    var year = today.getFullYear();
    var hour = today.getHours();
    var minute = today.getMinutes();
    var sec = today.getSeconds();
    var timer1 = setTimeout("odliczanie()", 1000);

    if (day < 10) day = "0" + today.getDate();
    if (month < 10) month = "0" + (today.getMonth() + 1);
    if (sec < 10) sec = "0" + today.getSeconds();
    if (minute < 10) minute = "0" + today.getMinutes();
    if (hour < 10) hour = "0" + today.getHours();

    var nazwa = "zegar";
    var value = day + "/" + month + "/" + year + " | " + hour + ":" + minute + ":" + sec;

    var elem = document.getElementById(nazwa);
    if (typeof elem !== 'undefined' && elem !== null) {
        zegarOFF();
        document.getElementById(nazwa).innerHTML = value;
    }
    zegarON();
}

function zegarON() {
    myVar1 = setTimeout("odliczanie()", 1000);
}

function zegarOFF() {
    clearTimeout(myVar1);

}
