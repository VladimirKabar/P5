/**
 * Created by vladimir on 19.07.16.
 */

var numer = Math.floor(Math.random() * 5 + 1);
var myVar1 = setTimeout("slajd()", 5000);
var myVar2 = setTimeout("schowaj()", 4500);

function ustawslajd(nrslajdu) {
    zegarOFF();

    numer = nrslajdu - 1;

    schowaj();
    setTimeout("slajd()", 500);

}
function schowaj() {
    $("#slider").fadeOut(500);
}

function slajd() {
    numer++;
    if (numer > 5)
        numer = 1;


    var plik = "<img src=\"images/slajd" + numer + ".png\"/>";
    $("#slider").fadeIn(500);

    var nazwa = "slider";
    var value = plik;

    var elem = document.getElementById(nazwa);
    if (typeof elem !== 'undefined' && elem !== null) {
        zegarOFF();
        document.getElementById(nazwa).innerHTML = value;

    }
    zegarON();
}

function zegarON() {
    myVar1 = setTimeout("slajd()", 5000);
    //console.log("dupa dziala");
    myVar2 = setTimeout("schowaj()", 4500);
    //console.log("dupa nie dziala");

}

function zegarOFF() {
    clearTimeout(myVar1);
    clearTimeout(myVar2);
}
