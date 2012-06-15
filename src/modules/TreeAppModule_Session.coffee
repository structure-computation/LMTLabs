#
class TreeAppModule_Session extends TreeAppModule
    constructor: ->
        super()
        
        @name = 'Session'
        
        session_info =
            ico: "img/correli.png"
            siz: 2
            txt: "Session information"
            sub:
                prf: "menu"
                act: [ ]
                
            key: [ "Esc" ]

        @actions.push session_info
            
        session_info.sub.act.push 
            ico: ""
            txt: "Open"
            fun: ( evt, app ) ->
                @modules = app.data.modules
                for m in @modules
                    if m instanceof TreeAppModule_File
                        m.actions[ 0 ].fun evt, app
            key: [ "Shift+O" ]
            
        session_info.sub.act.push 
            ico: ""
            txt: "Watch result"
            fun: ( evt, app ) =>
                @d = new_dom_element
                    className : "notice_container"
                    
                @fill_notice_popup(@d, app )
                
#                 @item_cp = new ModelEditorItem_Directory
#                     el    : @d
#                     model : @model

                p = new_popup "Notice", event : evt, width : 70, child: @d, onclose: =>
                    @onPopupClose( app )
                app.active_key.set false
                
            key: [ "Shift+R" ]
            
        session_info.sub.act.push 
            ico: ""
            txt: "Save"
            fun: ( evt, app ) =>
                #
                console.log "Save"
            key: [ "Ctrl+S" ]
            
#         test1 =
#             mod: new Str "name"
#             sub:
#                 prf: "list"
#                 act: [ ]
#             key: [ "Ctrl+Alt+T" ]
        test2 =
            txt: "PNG"
            fun: ( evt, app ) =>
                #
                console.log "PNG"
            key: [ "Ctrl+Alt+R" ]
            
        test3 =
            txt: "PDF"
            siz: 1
            fun: ( evt, app ) =>
                #
                console.log "PDF"
            key: [ "Ctrl+Alt+E" ]
#                 
        session_info.sub.act.push
            txt: "Save as"
            fun: ( evt, app ) =>
                #
                console.log "Save as"
            key: [ "Ctrl+Shift+S" ]
            #testing recursivity
            sub:
                prf: "menu"
                act: [ test2, test3 ]
                
        session_info.sub.act.push 
            ico: ""
            txt: "Export"
            fun: ( evt, app ) =>
                #
                console.log "Export"
            key: [ "Ctrl+E" ]
                
        session_info.sub.act.push 
            ico: ""
            txt: "Log out"
            fun: ( evt, app ) =>
                #
                console.log "Log out"
            key: [ "Ctrl+L" ]
            
    onPopupClose: ( app ) ->
        app.active_key.set true
    
    get_convergence_curve: ( parent, data ) ->
#         if not @cm?
        if data?.length
                
            d = new_dom_element
                parentNode: parent
                style     : { width: 700, height: 400 }
                
            m = new Graph marker: 'dot', x_axis: 'Iteration', y_axis: 'Error', line_color: "#00f", marker_color: "#f00", marker_size: 8, movable_hl_infos: false
                
            for p, i in data
                m.points.push [ i, p, 0 ]
                
            @cm = new CanvasManager el: d, want_aspect_ratio: true, padding_ratio: 1.4, constrain_zoom: 'x'
            @cm.cam.threeD.set false
            @cm.resize 700, 400
            
            @cm.items.push m
            @cm.fit()


            @cm.draw()

    
    
    fill_notice_popup: ( parent, app ) ->
        head = new_dom_element
            parentNode: parent
            nodeName  : "h2"
            txt       : "Correlation informations"
        
#         console.log app

        session = app.data.selected_session()
        
    
        for correlation in session._children when correlation instanceof CorrelationItem
#             console.log correlation
            for ic in correlation._children when ic instanceof ImgSetItem
                break
#             console.log ic
            text = 
            "Correlation used " + ic._children.length + " pictures<br>
            From picture name " + ic._children[ 0 ].img.src + " to " + ic._children[ ic._children.length - 1 ].img.src + "<br>
            Updates have been done on " + ic._children[ 0 ].img.src + "<br><br>
            With following parameters :<br>
            Prefft : " + correlation.pre_fft.get() + "<br>
            Luminosity : " + correlation.luminosity_correction.get() + "<br>
            Norm : " + correlation.convergence[ 0 ].get() + " with value "+ correlation.convergence[ 1 ].get() + "<br>
            Multi resolution : " + correlation.multi_resolution.get() + "<br>
            Number max of iterations : " + correlation.iteration.get() + "<br>
            Residual : " + correlation._residual_history.get() + "<br>
            "
        
        
            correlation_parameters = new_dom_element
                parentNode: parent
                nodeName  : "div"
                txt       : text
                
            data = []
            for i in [ 0 .. 10 ]
                data.push [ i , Math.exp( - i ) * 10, 0 ]
            
            if correlation.convergence[ 0 ].num.get() == 0
                data = correlation._norm_2_history.get()
            else
                data = correlation._norm_i_history.get()
            if data?
                console.log data
                @get_convergence_curve parent, data
            
#             for result in correlation._children when result instanceof ResultItem
#                 break

            disp_txt = correlation.visualisation.displayed_field.lst[ correlation.visualisation.displayed_field.num.get() ].get()
                
            displacement_title = new_dom_element
                parentNode: parent
                nodeName  : "span"
                txt       : "Displacement :<br>"
                
            displacement_points = new_dom_element
                parentNode: parent
                nodeName  : "textarea"
                txt       : disp_txt