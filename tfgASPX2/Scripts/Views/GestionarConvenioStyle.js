function validarFechaMaxima(input) {
    var fechaSeleccionada = new Date(input.value);
    var fechaActual = new Date();

    if (fechaSeleccionada > fechaActual) {
        var diaActual = fechaActual.getDate();
        var mesActual = fechaActual.getMonth() + 1;
        var anioActual = fechaActual.getFullYear();

        // Formateamos la fecha actual como "yyyy-MM-dd"
        var fechaFormateada = anioActual + '-' + (mesActual < 10 ? '0' : '') + mesActual + '-' + (diaActual < 10 ? '0' : '') + diaActual;
        input.value = fechaFormateada;
    }
}