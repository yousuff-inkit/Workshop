$(document).ready(function () {

    $('body').append(
        '<div id="global-spinner-overlay" style="display:none; position:fixed; top:0; left:0;' +
        'width:100%; height:100%; background:rgba(255,255,255,0.6); z-index:9999;' +
        'align-items:center; justify-content:center;">' +
        '<div class="global-spinner"></div>' +
        '</div>'
    );

    $(document).ajaxStart(function () {
        $("#global-spinner-overlay").css("display", "flex");
		
    }).ajaxStop(function () {
		$("#global-spinner-overlay").css("display", "none");
    });

});

function showSpinner() {
    $("#global-spinner-overlay").css("display", "flex");
}

function hideSpinner() {
    $("#global-spinner-overlay").css("display", "none");
}