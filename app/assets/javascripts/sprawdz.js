function testuj() {
    var liczba = document.getElementById("pole").value;
    if (liczba > 0) document.getElementById("kupa").innerHTML = "dodatnia";
    else if (liczba < 0) document.getElementById("kupa").innerHTML = "ujemna";
    else document.getElementById("kupa").innerHTML = "zero";
}