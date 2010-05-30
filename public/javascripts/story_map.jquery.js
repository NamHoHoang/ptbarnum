(function($)
{
    $.fn.story_map = function()
    {

        return $(this).each(function()
        {
            var story_map = $(this);

            // Handle story map that extends right past window edge
            $('#body,#sub_header').removeClass('container_12');
            $(window).bind('resize', function()
            {
                if ($('table:first', story_map).outerWidth() > $(this).width())
                {
                    story_map.width($('table:first', story_map).outerWidth() + 5);
                    story_map.closest('body').width(story_map.outerWidth());
                    $('#header,#footer > p').width($(this).width());
                    $('#sub_header').width($(this).width() - 40);
                }
                else
                {
                    story_map.css('width', '100%');
                    story_map.closest('body').css('width', '100%');
                    $('#header,#footer > p').css('width', '100%');
                    $('#sub_header').width($(this).width() - 40);
                }
            });

            // Add hover class to stories and release markers
            $('.story, .release-marker', story_map).hover(function()
            {
                $(this).addClass('hover');
            }, function()
            {
                $(this).removeClass('hover');
            }).find('.description').pivotalMarkdown();

        });

    };

    $.fn.story_map_controls = function(options)
    {
        var story_map = $(this);

        $('li.story', story_map).addClass('visible');

        $(options.prioritize).each(function()
        {
            var control = this;
            $('input', control).attr('checked', 'checked');
            $('label', control).text('On');
            $('input', control).click(function()
            {
                story_map.story_map_dragdrop('option', 'prioritize', $(this).is(':checked'));
                $('label', control).text($(this).is(':checked') ? 'On' : 'Off');
            });
        });

        $(options.filters).each(function()
        {
            // #chores -> .chore, #bugs => .bug
            var target = $(this.id.replace(/(.*)?s$/, '.$1'));

            // Remember initial height before hiding to avoid slide animation jump
            target.each(function()
            {
                $(this).data('height', $(this).outerHeight()).height(0).removeClass('visible').hide();
            });

            $(this).click(function()
            {
                // Slide down when checked
                if ($(this).is(':checked'))
                {
                    target.addClass('visible').each(function()
                    {
                        $(this).animate({"height" : $(this).data('height') + "px"}, "slow");
                    });
                }
                // Slide up
                else
                {
                    target.removeClass('visible').animate({"height" : "0px"}, "slow", function()
                    {
                        $(this).hide();
                    });
                }
            });
        });

        return $(this);
    };

    $.fn.story_map_dragdrop = function(options)
    {
        // Handle resetting prioritization enabled or not
        if (typeof options == 'string' && options == 'option' && arguments[1] == 'prioritize')
        {
            var enabled = arguments[2];
            return $(this).each(function()
            {
                var story_map = $(this);
                story_map.data('prioritize', enabled);
                $('li.story.unstarted', story_map).each(function()
                {
                    var story = $(this);
                    story.draggable('option', 'containment', enabled ? story_map : story.closest('table'));
                });
            });
        }

        var defaults = {
            prioritize : false
        };

        var settings = $.extend({}, defaults, options);

        return $(this).each(function()
        {
            var story_map = $(this);
            
        });

        function findAction(droppable, draggable, prioritize)
        {
            droppable = $(droppable);

            var action = null;

            if (prioritize && draggable.unstarted())
            {
                if (droppable.unstarted())
                {
                    action = { target: droppable, name: 'prioritize_after' };
                }
                else
                {
                    if ($('li.story.visible', droppable.td()).size() == 0) // No stories in column
                    {
                        var target = $($('li.story.visible:first,div.placeholder', droppable.td())[0]);

                        if (droppable.closest('.release')[0] == draggable.closest('.release')[0]) // Same release
                        {
                            action = { target: target, name: 'drop_before' };
                        }
                        else
                        {
                            action = { target: target, name: 'prioritize_before' };
                        }
                    }
                    else
                    {
                        if ($('li.story.visible.unstarted', droppable.td()).size() == 0) // No unstarted stories in column
                        {
                            action = { target: $('li.story.visible:last', droppable.td()), name: 'prioritize_after' };
                        }
                        else
                        {
                            if (droppable.hasClass('placeholder'))
                            {
                                if ($('li.visible:last', droppable.td()).attr('id') != draggable.attr('id'))
                                {
                                    action = { target: $('li.visible:last', droppable.td()), name: 'prioritize_after' };
                                }
                            }
                            else
                            {
                                action = { target: $('li.visible.unstarted:first', droppable.td()), name: 'prioritize_before' };
                            }
                        }
                    }
                }
            }
            else
            {
                if (draggable.activity() != droppable.activity())
                {
                    var after_story = $('li.story.visible:lt(' + droppable.td().priority_index(draggable) + '):last', droppable.td());
                    if (after_story.size() != 0)
                    {
                        action = { target: after_story, name: 'drop_after' };
                    }
                    else
                    {
                        action = { target: $($('li.story.visible:first,div.placeholder', droppable.td())[0]), name: 'drop_before' }
                    }
                }
            }

            return action;
        }
    };

    // finds the table header for the element column
    $.fn.th = function()
    {
        var headers = [];
        $(this).each(function()
        {

            if (this.tagName == 'TH')
            {
                headers.push(this);
                return false;
            }

            var cell = this.tagName == 'TD' ? $(this) : $(this).closest('td');
            if (cell.data('th')) // Cached so we don't have to look for it again
            {
                headers.push(cell.data('th'));
                return false;
            }

            var index = cell.closest('tr').find('td').index(cell);
            cell.closest("table").find("tr th:eq(" + index + "):first").each(function()
            {
                cell.data('th', this);
                headers.push(this);
            });
        });
        return $(headers);
    };

    // finds the activity name for the element column
    $.fn.activity = function()
    {
        return $(this).th().find('.data.activity-name').text();
    };

    // finds the first table cell for the header column
    $.fn.td = function()
    {
        var cells = [];
        $(this).each(function()
        {

            if (this.tagName == 'TD')
            {
                cells.push(this);
                return false;
            }

            if (this.tagName == 'TH')
            {
                var index = $(this).closest('tr').find('th').index(this);
                $(this).closest("table").find("tr td:eq(" + index + ")").each(function()
                {
                    cells.push(this);
                    return false;
                });
            }
            else
            {
                cells.push($(this).closest('td')[0]);
            }
        });
        return $(cells);
    };

    $.fn.resize_placeholders = function()
    {

        $('tbody tr', this).each(function()
        {
            var heights = $('td', this).map(function()
            {
                return { td: this, height: $('ol.story_list', this).outerHeight() };
            }).sort(function(a, b)
            { return b.height - a.height; });

            var maxHeight = heights[0].height;
            $.each(heights, function()
            {
                $('div.placeholder', this.td).height(maxHeight - this.height + 24);
            });
        });
    };

    $.fn.unstarted = function()
    {
        return $(this).hasClass('unstarted');
    };

    $.fn.accepted = function()
    {
        return $(this).hasClass('accepted');
    };

    $.fn.tracker_id = function()
    {
        return $('> .data .id', this).text();
    };

    $.fn.iteration = function(number)
    {
        if (number != undefined)
        {
            $('> .data .iteration', this).text(number);
        }

        return $('> .data .iteration', this).text();
    };

    $.fn.priority = function()
    {
        return parseInt($('> .data .priority', this).text());
    };

    $.fn.priority_index = function(story)
    {
        var stories = $('li.story', this);
        if (stories.index(story) != -1)
        {
            return stories.index(story);
        }
        var index = stories.length;
        stories.each(function(i)
        {
            if ($(story).priority() < $(this).priority())
            {
                index = i;
                return false;
            }
        });
        return index;
    };

    $.fn.sort_by_priority = function()
    {
        return $(this.sort(function(a, b)
        {
            return $(a).priority() - $(b).priority();
        }));
    };

    /*
     http://community.pivotaltracker.com/pivotal/topics/does_pivotal_use_a_3rd_party_library_gem_for_the_markdown_functionality_in_tracker
     */
    $.fn.pivotalMarkdown = function()
    {
        $(this).each(function()
        {
            $(this).html($.fn.pivotalMarkdown.translate($(this).html()));
        });
        return this;
    };

    $.fn.pivotalMarkdown.translate = function(text)
    {
        return text.replace(/(^|\W)\*([^\n*]+)\*($|\W)/g, "$1<strong>$2</strong>$3")
                .replace(/(^|\W)_([^_]+)_($|\W)/g, "$1<em>$2</em>$3")
                .replace(/[ \t]*\n/g, "<br/>")
                .replace(/(<br\/>)\s*/mg, "$1");
    };

})(jQuery);