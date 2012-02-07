class TreeAppModule_Animation extends TreeAppModule
    constructor: ( app_data ) ->
        super()
        
        @play_state = false
        @img_per_sec = 2
        
        @name = 'Time'
        

        @actions.push
            ico: "img/first_24.png"
            siz: 1
            ord: false
            txt: "Go to First Image"
            fun: ( evt, app ) =>
                #
                app.data.time.set app.data.time._min
                @clear_timer()
            key: [ "Shift+1" ]
                
        @actions.push
            ico: "img/rewind_24.png"
            siz: 1
            ord: false
            txt: "Rewind"
            fun: ( evt, app ) =>
                #
                if app.data.time.get() > 0
                    app.data.time.set app.data.time.get() - 1
                    @clear_timer()
            key: [ "Shift+2" ]
                
        @actions.push
            ico: "img/play_24.png"
            siz: 1
            ord: false
            txt: "Play"
            fun: ( evt, app ) =>
                #
                @play_state = true
                if app.data.time.get() == app.data.time._max.get() # If play button is clicked when the last picture is selected
                    app.data.time.set 0                            # Rewind to the first picture
                    
                setTimeout @run_timer, 1000 / @img_per_sec, app
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
                if app.data.time.get() < app.data.time._max.get()
                    app.data.time.set app.data.time.get() + 1
                    @clear_timer()
                    
            key: [ "Shift+5" ]
                
                
        @actions.push
            ico: "img/last_24.png"
            siz: 1
            txt: "Go to Last Image"
            fun: ( evt, app ) =>
                app.data.time.set app.data.time._max.get()
                
                @clear_timer()
            key: [ "Shift+6" ]
        
        # constrained value
        @actions.push
            mod: app_data.time
            siz: 1
            fun: ( evt, app ) =>
                #
                
                    
    run_timer : ( app ) =>
        if app.data.time.get() < app.data.time._max.get() and @play_state == true
            if app.data.time.get() == app.data.time._max.get()
                @clear_timer()
            else
                app.data.time.set app.data.time.get() + 1
                setTimeout @run_timer, 1000 / @img_per_sec, app
        else
            @clear_timer()

            
    clear_timer : () =>
        @play_state = false
        