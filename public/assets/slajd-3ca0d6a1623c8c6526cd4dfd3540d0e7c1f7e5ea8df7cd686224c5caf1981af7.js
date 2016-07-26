/**
 * Created by vladimir on 19.07.16.
 */

var numer = Math.floor(Math.random() * 5 + 1);

function ustawslajd(nrslajdu){
    clearTimeout(timer1);
    clearTimeout(timer2);

    numer = nrslajdu-1;

    schowaj();
    setTimeout("slajd()",500);

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


    document.getElementById("slider").innerHTML = plik;
    timer1 = setTimeout("slajd()", 5000);
    timer2 = setTimeout("schowaj()",4500);

}
