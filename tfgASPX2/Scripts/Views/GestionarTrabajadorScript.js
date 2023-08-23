function showErrorMessage(message) {
    document.getElementById('errorModalBody').innerText = message;
    $('#errorModal').modal('show');
}

function showSuccessMessage(message) {
    document.getElementById('successModalBody').innerText = message;
    $('#successModal').modal('show');
}
