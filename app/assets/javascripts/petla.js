/**
 * Created by vladimir on 19.07.16.
 */
function petla() {
    var liczba1 = document.getElementById("pole1").value;
    var liczba2 = document.getElementById("pole2").value;
    var x = 0;

    if (liczba1 > liczba2) {
        document.getElementById("if").innerHTML = "true";
        var x = liczba2;
        liczba2 = liczba1;
        liczba1 = x;
    }
    else
        document.getElementById("if").innerHTML = "false";

    document.getElementById("petlax").innerHTML = "X : " +x;
    document.getElementById("petla1").innerHTML = "Liczba1 :" + liczba1;
    document.getElementById("petla2").innerHTML = "Liczba2 :" + liczba2;
    x="";
    for (var i = liczba1; i <= liczba2; i++) {
        x = x + i + " ";
    }
    document.getElementById("petla").innerHTML = "Wynik petli : " +x;
}