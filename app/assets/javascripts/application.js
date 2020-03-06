// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require bootstrap-sprockets
//= require_tree .

//= require moment
//= require adminlte
//= require bootstrap-datepicker
//= require bootstrap-datepicker.ru
//= require daterangepicker
//= require bootstrap-clockpicker
//= require select2.full
//= require select2.ru
//= require jquery.jcrop
//= require papercrop
//= require jquery.remotipart
//= require cocoon
//= require filterrific/filterrific-jquery
//= require difflib
//= require diffview
//= require ekko-lightbox
//= require SocialCalc
//= require socialcalc_plugin
//= require_tree .

$(function() {
    var slideToTop = $("<div />");
    slideToTop.html('<i class="fa fa-chevron-up"></i>');
    slideToTop.css({
        position: 'fixed',
        bottom: '20px',
        right: '25px',
        width: '40px',
        height: '40px',
        color: '#eee',
        'font-size': '',
        'line-height': '40px',
        'text-align': 'center',
        'background-color': '#222d32',
        cursor: 'pointer',
        'border-radius': '5px',
        'z-index': '99999',
        opacity: '.7',
        'display': 'none'
    });
    slideToTop.on('mouseenter', function () {
        $(this).css('opacity', '1');
    });
    slideToTop.on('mouseout', function () {
        $(this).css('opacity', '.7');
    });
    $('.wrapper').append(slideToTop);
    $(window).scroll(function () {
        if ($(window).scrollTop() >= 150) {
            if (!$(slideToTop).is(':visible')) {
                $(slideToTop).fadeIn(500);
            }
        } else {
            $(slideToTop).fadeOut(500);
        }
    });
    $(slideToTop).click(function () {
        $("html, body").animate({
            scrollTop: 0
        }, '500');
    });
    $(".sidebar-menu li:not(.treeview) a").click(function () {
        var $this = $(this);
        var target = $this.attr("href");
        if (typeof target === 'string') {
            $("body").animate({
                scrollTop: ($(target).offset().top) + "px"
            }, 500);
        }
    });
});

