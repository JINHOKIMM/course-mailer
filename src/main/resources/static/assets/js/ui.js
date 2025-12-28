// Jquery Document
$(document).ready(function () {
    init();
});

function init() {
    $('.list > .btn-wrap .btn').on('click', function () {
        $('.popup').toggle(300);
    })
}