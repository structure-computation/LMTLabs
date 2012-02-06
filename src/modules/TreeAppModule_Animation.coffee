class TreeAppModule_Animation extends TreeAppModule
    constructor: ( app_data ) ->
        super()
        
        @current_picture = 0    
        @play_state = false
        @timer = 0
        @img_per_sec = 3
        
        @name = 'Time'
        

        @actions.push
            ico: "img/first_24.png"
            siz: 1
            ord: false
            txt: "Go to First Image"
            fun: ( evt, app ) =>
                #
#                 anim_module = @get_animation_module app
#                 anim_time = anim_module.get_anim_time()
                app.data.set anim_time._min
#                 ds = @get_display_settings_item app
#                 ds.anim_time.set ds.anim_time._min
                @clear_timer()
            key: [ "Shift+1" ]
                
        @actions.push
            ico: "img/rewind_24.png"
            siz: 1
            ord: false
            txt: "Rewind"
            fun: ( evt, app ) =>
                #
                anim_module = @get_animation_module app
                anim_time = anim_module.get_anim_time()
                if anim_time.get() > 0
                    anim_time.set anim_time.get() - 1
                    @clear_timer()
#                 if ds.anim_time.get() > 0
#                     ds.anim_time.set ds.anim_time.get() - 1
#                     @clear_timer()
            key: [ "Shift+2" ]
                
        @actions.push
            ico: "img/play_24.png"
            siz: 1
            ord: false
            txt: "Play"
            fun: ( evt, app ) =>
                #
                @play_state = true
                anim_module = @get_animation_module app
                anim_time = anim_module.get_anim_time()
                if anim_time.get() == anim_time._max.get() # If play button is clicked when the last picture is selected
                    anim_time.set 0                        # Rewind to the first picture
                    
#                 ds = @get_display_settings_item app
#                 if ds.anim_time.get() == ds.anim_time._max.get() # If play button is clicked when the last picture is selected
#                     ds.anim_time.set 0                           # Rewind to the first picture
#                 
                setTimeout @run_timer, 1 / @img_per_sec, app
            key: [ "Shift+3", "Space" ]
                
        @actions.push
            ico: "img/pause_24.png"
            siz: 1
            ord: false
            txt: "Pause"
            fun: ( evt, app ) =>
                #
                @clear_timer()
            key: [ "Shift+4" ]
                
                
        @actions.push
            ico: "img/forward_24.png"
            siz: 1
            ord: false
            txt: "Forward"
            fun: ( evt, app ) =>
                #
                anim_module = @get_animation_module app
                anim_time = anim_module.get_anim_time()
                if anim_time.get() < anim_time._max.get()
                    anim_time.set anim_time.get() + 1
                    @clear_timer()
#                 ds = @get_display_settings_item app
#                 if ds.anim_time.get() < ds.anim_time._max.get()
#                     ds.anim_time.set ds.anim_time.get() + 1
#                     @clear_timer()
            key: [ "Shift+5" ]
                
                
        @actions.push
            ico: "img/last_24.png"
            siz: 1
            txt: "Go to Last Image"
            fun: ( evt, app ) =>
                #
#                 ds = @get_display_settings_item app
#                 ds.anim_time.set ds.anim_time._max.get()
                
                anim_module = @get_animation_module app
                anim_time = anim_module.get_anim_time()
                anim_time.set anim_time._max.get()
                @clear_timer()
            key: [ "Shift+6" ]
        
        # constrained value
        @actions.push
            mod: app_data.time
            #                 anim_time: new ConstrainedVal( 0,
            #                     min: 0
            #                     max: -1
            #                     div: 0
            #                 )
            siz: 1
            fun: ( evt, app ) =>
                #
                
                    
    run_timer : ( app ) =>
        anim_module = @get_animation_module app
        anim_time = anim_module.get_anim_time()
        if anim_time.get() < anim_time._max.get() and @play_state == true
            
            if anim_time.get() == anim_time._max.get()
                @clear_timer()
            else
                anim_time.set anim_time.get() + 1
                setTimeout @run_timer, 1 / @img_per_sec, app
        else
            @clear_timer()
#         ds = @get_display_settings_item app
#         if ds.anim_time.get() < ds.anim_time._max.get() and @play_state == true
#             
#             if ds.anim_time.get() == ds.anim_time._max.get()
#                 @clear_timer()
#             else
#                 ds.anim_time.set ds.anim_time.get() + 1
#                 setTimeout @run_timer, 1 / @img_per_sec, app
#         else
#             @clear_timer()
            
    clear_timer : () =>
        clearTimeout @timer
        @play_state = false

    get_anim_time : () =>
        @actions[ @actions.length-1 ].mod.anim_time
        