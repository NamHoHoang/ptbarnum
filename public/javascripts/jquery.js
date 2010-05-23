// modified version of: http://refactormycode.com/codes/889-restful-jquery-put-delete-links

// This plugin is intended to be used to make put, post, or delete HTTP requests with links

jQuery.fn.restForm = function(type, options)
{
    var defaults = {
        method: 'post',
        action: 'href',
        confirm: false,
        confirm_message: 'Are you sure?',
        trigger_on: 'click',
        auth_token: false
    };
    var opts = $.extend(defaults, options);

    this.each(function(index, el)
    {
        $(el).bind(opts.trigger_on, function()
        {

            var form = $('<form></form>').attr({
                method: opts.method,
                action: options.action ? opts.action : $(el).attr("href")
            }).append('<input type="hidden" name="_method" value="' + type + '" />');

            if (opts.auth_token)
            {
                form.append('<input type="hidden" name="authenticity_token" value="' + opts.auth_token + '" />');
            }

            if (opts.confirm && !confirm(opts.confirm_message))
            {
                return false;
            }

            $(this).after(form);
            form.submit();
            return false;
        });
    });
};

