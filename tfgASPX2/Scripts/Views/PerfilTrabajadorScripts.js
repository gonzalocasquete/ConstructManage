

  function mostrarMensaje() {
    // Muestra un mensaje emergente en el navegador
    alert('El usuario se ha actualizado correctamente');

    // Recarga la p�gina despu�s de 1 segundo (1000 milisegundos)
    setTimeout(function () {
      window.location.reload();
    }, 1000);
  }

