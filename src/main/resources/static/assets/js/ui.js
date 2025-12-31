// Jquery Document
$(document).ready(function () {
    init();
});

function init() {
    /*
    $('.list > .btn-wrap .btn').on('click', function (e) {
        e.stopPropagation();
        $('.popup').toggle(300);
        $('.dim').fadeToggle(300);
        $('body').toggleClass('lock');
    });
    */

    $('.dim').on('click', function () {
        $('.popup').hide(300);
        $('.dim').fadeOut(300);
        $('body').removeClass('lock');
    });

    $('.user').on('click', function () {
        $('.userBox').fadeToggle(300);
    });

    $('.user, .userBox').on('click', function (e) {
        e.stopPropagation();
    }); 

    $('.sch').on('click', function (e) {
        e.stopPropagation();
        $(this).addClass('on');
        $(this).children().fadeIn(300);
    });

    $(document).on('click', function () {
        $('.sch').removeClass('on');
        $('.sch').children().hide();
        $('.userBox').fadeOut(300);
    });

    $('.item input[type="checkbox"]').on('change', function () {
        $(this).parent().children('select').toggle(300);
    });
    
    $('.btn.accordion').on('click', function () {
        $('.btn.accordion').removeClass('active');
        $(this).toggleClass('active');
        let tab = $(this).parents('td').index();
        $('.tabCont .tblBox').hide();
        $('.tabCont').children('.tblBox').eq(tab).show();
    });
}