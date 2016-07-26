var haslo = "Bez pracy nie ma kołaczy".toUpperCase();
var haslo1 = "";
var dlugosc = haslo.length;
var ile_bledow = 0;


for (var i = 0; i < dlugosc; i++) {
    //if (haslo[i]==" ") haslo1 = haslo1 + " ";
    if (haslo.charAt(i) == " ") haslo1 = haslo1 + " ";
    else haslo1 = haslo1 + "-";
}

function wypisz_haslo() {
    var nazwa = "plansza";
    var value = haslo1;
    var elem = document.getElementById(nazwa);
    if (typeof elem !== 'undefined' && elem !== null) {
        document.getElementById(nazwa).innerHTML = value;
    }
}

window.onload = start;


var litery = ["a", "ą", "b", "c", "ć", "d", "e", "ę", "f", "g", "h", "i", "j", "k", "l", "ł", "m", "n", "ń", "o", "ó", "p", "q", "r", "s", "ś", "t", "u", "v", "w", "x", "y", "z", "ź", "ż"];


function start() {
    var nazwa = "alfabet";
    var value = "";
    var licznik = 0;
    for (var i = 0; i < 5; i++) {
        for (var j = 0; j < 7; j++) {
            var element = "lit" + licznik;
            value = value + '<div class = "litera" onclick="sprawdz(' + licznik + ')" id="' + element + '">' + litery[licznik].toUpperCase() + '</div>';
            licznik++;
        }
        value = value + '<div style="clear: both;"> </div>';
    }
    var elem = document.getElementById(nazwa);
    if (typeof elem !== 'undefined' && elem !== null) {
        document.getElementById(nazwa).innerHTML = value;
    }

    wypisz_haslo();
}

String.prototype.podmien = function (pozycja, znak) {
    if (pozycja > this.length - 1)
        return this.toString();
    else return this.substr(0, pozycja) + znak + this.substr(pozycja + 1);

};


function sprawdz(arg) {

    var trafiony = false;
    //alert(arg);
    for (var i = 0; i < dlugosc; i++) {
        if (haslo.charAt(i) == litery[arg].toUpperCase()) {
            haslo1 = haslo1.podmien(i, litery[arg]).toUpperCase();
            trafiony = true;
        }
    }
    var element = "lit" + arg;

    if (trafiony == true) {

        document.getElementById(element).style.background = "#003300";
        document.getElementById(element).style.color = "00C00";
        document.getElementById(element).style.border = "3px solid #00C00";
        document.getElementById(element).style.cursor = "default";
        wypisz_haslo();
    }

    else {
        document.getElementById(element).style.background = "#330000";
        document.getElementById(element).style.color = "#C00000";
        document.getElementById(element).style.border = "3px solid #C00000";
        document.getElementById(element).style.cursor = "default";
        document.getElementById(element).setAttribute("onclick", ";");

        //pudlo z literka
        ile_bledow++;
        var nazwa1 = "szubienica";
        var obraz = "/images/img/s" + ile_bledow + ".jpg";
        //var obraz = "<%= image_tag(\"img/s"+ile_bledow+".jpg\") %>";


        document.getElementById(nazwa1).innerHTML = '<img src="' + obraz + '" alt="" />';
        ;
    }
    //wygrana
    if (haslo == haslo1)
        document.getElementById("alfabet").innerHTML = "Tak jest! Podano prawidłowe hasło: " + haslo +
            '<br /><br /><span class="reset" onclick="location.reload()">JESZCZE RAZ?</span>';

    //przegrana
    if (ile_bledow >= 9)
        document.getElementById("alfabet").innerHTML = "Przegrana! Prawidłowe hasło: " + haslo +
            '<br /><br /><span class="reset" onclick="location.reload()">JESZCZE RAZ?</span>';
}