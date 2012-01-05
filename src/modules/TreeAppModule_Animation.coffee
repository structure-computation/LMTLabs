class TreeAppModule_Animation extends TreeAppModule
    constructor: ->
        super()
        
        @current_picture = 0    
        @play_state = false
        @timer = 0
        @img_per_sec = 3
        

        @actions.push
            ico: "img/first_24.png"
            txt: "Go to First Image (Shift+1)"
            fun: ( evt, app ) =>
                #
                ds = @get_display_settings_item app
                ds.anim_time.set ds.anim_time._min
                @clear_timer()
            key: [ "Shift+1" ]
                
        @actions.push
            ico: "img/rewind_24.png"
            txt: "Rewind (Shift+2)"
            fun: ( evt, app ) =>
                #
                ds = @get_display_settings_item app
                if ds.anim_time.get() > 0
                    ds.anim_time.set ds.anim_time.get() - 1
                    @clear_timer()
            key: [ "Shift+2" ]
                
        @actions.push
            ico: "img/play_24.png"
            txt: "Play (Shift+3 or Space Bar)"
            fun: ( evt, app ) =>
                #
                @play_state = true
                ds = @get_display_settings_item app
                if ds.anim_time.get() == ds.anim_time._max.get() # If play button is clicked when the last picture is selected
                    ds.anim_time.set 0                           # Rewind to the first picture
                
                setTimeout @run_timer, 1 / @img_per_sec, app
            key: [ "Shift+3", "Space" ]
                
        @actions.push
            ico: "img/pause_24.png"
            txt: "Pause (Shift+4)"
            fun: ( evt, app ) =>
                #
                @clear_timer()
            key: [ "Shift+4" ]
                
                
        @actions.push
            ico: "img/forward_24.png"
            txt: "Forward (Shift+5)"
            fun: ( evt, app ) =>
                #
                ds = @get_display_settings_item app
                if ds.anim_time.get() < ds.anim_time._max.get()
                    ds.anim_time.set ds.anim_time.get() + 1
                    @clear_timer()
            key: [ "Shift+5" ]
                
                
        @actions.push
            ico: "img/last_24.png"
            txt: "Go to Last Image (Shift+6)"
            fun: ( evt, app ) =>
                #
                ds = @get_display_settings_item app
                ds.anim_time.set ds.anim_time._max.get()
                @clear_timer()
            key: [ "Shift+6" ]
                
                    
    run_timer : ( app ) =>
        ds = @get_display_settings_item app
        if ds.anim_time.get() < ds.anim_time._max.get() and @play_state == true
            
            if ds.anim_time.get() == ds.anim_time._max.get()
                @clear_timer()
            else
                ds.anim_time.set ds.anim_time.get() + 1
                setTimeout @run_timer, 1 / @img_per_sec, app
        else
            @clear_timer()
            
    clear_timer : () =>
        clearTimeout @timer
        @play_state = false

        