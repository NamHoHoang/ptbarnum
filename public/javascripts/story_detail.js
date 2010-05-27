(function($)
{
    $.fn.story_detail = function(options)
    {
        var defaults = {
            popupFinder: function(source) {
                return $(source).siblings('.story_card');
            },
            delay: 400
        };

        var settings = $.extend({}, defaults, options);

        function showPopup(event)
        {
            var icon = $(event.target);
            var popup = $(settings.popupFinder(this));

            popup.bind('mouseenter', function() {
                popup.addClass('over');
            });

            popup.bind('mouseleave', function() {
                popup.removeClass('over');
            });

            popup.addClass('show');
            if (icon.offset().left + icon.width() + popup.outerWidth() > window.outerWidth) {
                popup.addClass('left');
                popup.offset({left: (icon.offset().left - popup.outerWidth()), top: icon.offset().top });
            }
            else {
                popup.addClass('right');
                popup.offset({left: (icon.offset().left + icon.outerWidth()), top: icon.offset().top });
            }
        }

        function hidePopup(event)
        {
            var popup = $(settings.popupFinder(this));
            popup.removeClass('show').removeClass('left').removeClass('right')
        }

        return $(this).each(function()
        {
            $.event.special.hover.delay = settings.delay;
            $(this).hover(showPopup, hidePopup);
        });
    };
})(jQuery);