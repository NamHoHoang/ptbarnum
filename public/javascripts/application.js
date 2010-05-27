// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

// for detecting weather or not the mouse is currently being pressed
// http://stackoverflow.com/questions/322378/javascript-check-if-mouse-button-down
var mouseDown = 0;

$(document.body).mousedown(function()
{
  ++mouseDown;
}).mouseup(function()
{
  --mouseDown;
});

window.STORY_MAPPER = {

  displayStatus : function (msg, isError)
  {
    $('#status').addClass(isError ? 'error' : '').html(msg).fadeIn(200, function()
    {
      var _that = this;
      setTimeout(function()
      {
        $(_that).fadeOut(500, function()
        {
          $(_that).removeClass(isError ? 'error' : '');
        });
      }, 2000);
    });
  },

  ajaxDefaults : {
    success : function(data, status)
    {
      STORY_MAPPER.displayStatus(data.message, false);
    },
    error : function(request, status)
    {
      STORY_MAPPER.displayStatus(status, true);
    }
  }
};

jQuery(function($)
{
  $.ajaxSetup({ dataType : 'json'});
});

// in case the user doesn't have firebug
if (!window.console || !console.firebug)
{
  var names = ["log", "debug", "info", "warn", "error", "assert", "dir", "dirxml",
    "group", "groupEnd", "time", "timeEnd", "count", "trace", "profile", "profileEnd"];

  window.console = {};
  for (var i = 0; i < names.length; ++i)
  {
    window.console[names[i]] = function()
    {};
  }
}

$(document).ajaxSend(function(event, request, settings)
{
  if (typeof(window.AUTH_TOKEN) == "undefined") return;
  // IE6 fix for http://dev.jquery.com/ticket/3155
  if (settings.type == 'GET' || settings.type == 'get') return;

  settings.data = settings.data || "";
  settings.data += (settings.data ? "&" : "") + "authenticity_token=" + encodeURIComponent(window.AUTH_TOKEN);
});

$(function()
{
  $('.post').restForm('POST', {auth_token : window.AUTH_TOKEN});
  $('.delete').restForm('DELETE', {auth_token : window.AUTH_TOKEN});

    // Align footer to bottom of window
  $('#footer').bindToWindowBottom();
});

jQuery.fn.widthByTable = function(table)
{

  var table_min_width = getMinWidth($(table));

  function getMinWidth($table)                          
  {
    var _min = 0;
    var _border_width = 0;

    var $tds = $table.find("tbody tr:first td");

    var cell_min_width = $tds.css("min-width");
    $table.find("thead tr:first th").each(function()
    {
      var bLeft = $(this).css("border-left-width").replace("px","");
      var bRight = $(this).css("border-right-width").replace("px","");
      _border_width += (new Number(bLeft) + new Number(bRight));
    });

    if (cell_min_width != "none" && cell_min_width != '')
    {
      _min = (cell_min_width.replace("px", "") * $tds.size()) + _border_width;
    }
    return _min;
  }

  $(this).each(function()
  {
    var paddingLeft = $(this).css("padding-left").replace("px","");
    var paddingRight = $(this).css("padding-right").replace("px","");
    var margin = $(this).css("margin").replace("px","");

    var min_width = table_min_width - margin - paddingLeft - paddingRight;
    
    $(this).css("min-width", (min_width + $(table).offset().left) + "px");
  });
  
  return this;
};

jQuery.fn.alignToWindowBottom = function()
{
    return $(this).each(function()
    {
        var prev = $(this).prev();
        var prevBottom = prev.offset().top + prev.outerHeight();
        if (prevBottom + $(this).outerHeight() >= $(window).height())
        {
            $(this).css('margin-top', 'auto');
        }
        else
        {
            $(this).css('margin-top', $(window).height() - prevBottom - $(this).outerHeight());
        }

    });
};

jQuery.fn.bindToWindowBottom = function()
{
    var target = $(this);
    
    // Bind after short timeout to ensure that the footer is aligned after all other resize handlers run
    setTimeout(function()
    {
        $(window).bind('resize', function()
        {
            target.alignToWindowBottom();
        }).trigger('resize');
    }, 20);


    return target;
};



