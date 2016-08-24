function link() {
    var licznik = 0;
    var test = 0;
    var suma =""
    for (var i = 0; i < 10; i++) {
        var element = document.getElementById("pole" + licznik);
        if (element.value != '') {
            //test++;
            suma = suma + "[img]" + element.value + "?.jpg[/img]"
        }
        licznik++;
        //window.prompt("Skopiuj link ponizej", test + " "+licznik);
    }
    //var suma = document.getElementById("pole" + licznik).value;
    //suma = "[img]" + suma + "?.jpg[/img]"

    window.prompt("Skopiuj (wciśnij CRTL + C) zawartość ", suma);
}
