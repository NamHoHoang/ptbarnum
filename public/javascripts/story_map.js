STORY_MAPPER.controller = (function()
{

    function updateActivity(story, activity)
    {
        if (activity == $(story).activity())
        {
            return false;
        }

        return updateStory(story, activity ? { 'activity[label]' : activity } : { 'activity' : '' });
    }

    function updatePosition(story, move, target, activity, success_handler)
    {
        var params = { 'move[move]' : move, 'move[target]' : $(target).tracker_id() };
        if (activity != undefined && activity != '')
        {
            params['activity[label]'] = activity;
        }
        else
        {
            params['activity'] = '';
        }

        return updateStory(story, params, success_handler);
    }

    function updateStory(story, params, success_handler)
    {
        var data = $.extend({}, { _method: 'PUT', project_id: $('#project_id').text() }, params);
        $(story).addClass('ajax-loading');
        $.ajax({
            type: 'POST',
            url: "/stories/" + $(story).tracker_id(),
            dataType : "json",
            data: data,
            success: function(data, status)
            {
                $(story).removeClass('ajax-loading');
                STORY_MAPPER.ajaxDefaults.success(data, status);
                if (success_handler)
                {
                    success_handler(data, status);
                }
            },
            error: function(request, status)
            {
                $(story).removeClass('ajax-loading');
                var response = eval("(" + request.responseText + ")");
                STORY_MAPPER.ajaxDefaults.error(request, response.message);
            }
        });
        return data;
    }

    function getRelease(release, success_handler)
    {
        var data = {
            project_id: $('#project_id').text(),
            id: $(release).tracker_id(),
            iteration_number: $(release).iteration()
        };

        $.ajax({
            type: 'GET',
            url: "/projects/" + data.project_id + "/releases/" + data.id,
            dataType : "json",
            data: data,
            success: function(data, status)
            {
                success_handler(release, data);
            },
            error: function(request, status)
            {
                var response = eval("(" + request.responseText + ")");
                STORY_MAPPER.ajaxDefaults.error(request, response.message);
            }
        });
        return data;
    }

    return {
        updateActivity : updateActivity,
        updatePosition : updatePosition,
        getRelease     : getRelease
    };

})();

// init
$(function()
{
    // See story_map.jquery.js, story_detail.jquery.js
    $('#story_map').story_map().story_map_controls({ filters: '#bugs,#chores', prioritize: '#enable_prioritize' }).story_map_dragdrop({
        prioritize : true
    }).bind('update_activity', function(event, data)
    {
        STORY_MAPPER.controller.updateActivity(data.story, data.activity);
    }).bind('update_position', function(event, data)
    {
        STORY_MAPPER.controller.updatePosition(data.story, data.move, data.target, data.activity, function()
        {
            $('#story_map').trigger('position_updated', data);
        });
    }).bind('refresh_release', function(event, data)
    {
        STORY_MAPPER.controller.getRelease(data.release, data.handle_update);
    });
    $("img.storyDetailIcon").story_detail();
});

