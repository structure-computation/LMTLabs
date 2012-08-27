#
class TreeAppModule_Session extends TreeAppModule
    constructor: ->
        super()
        
        @name = 'Correli'
        
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
            txt: "Open in Tree"
            fun: ( evt, app ) ->
                @modules = app.data.modules
                for m in @modules
                    if m instanceof TreeAppModule_File
                        m.actions[ 1 ].fun evt, app
            key: [ "Shift+I" ]
            
        session_info.sub.act.push 
            ico: ""
            txt: "Watch result"
            fun: ( evt, app ) =>
                @d = new_dom_element
                    className : "notice_container"
                    
                @fill_notice_popup(@d, app )
                
                p = new_popup "Notice", event : evt, width : 70, height : 70, child: @d, onclose: =>
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
        
        session = app.data.selected_session()
        
    
        for correlation in session._children when correlation instanceof CorrelationItem
#             console.log correlation
            if correlation._children.length
                for ic in correlation._children when ic instanceof ImgSetItem
                    break
    #             console.log ic
    
                new_dom_element
                    parentNode: parent
                    nodeName  : "h3"
                    txt       : "General informations"
                    
                if ic._children.length
                    if not correlation._residual_history? #no correlation have been done
                        no_correlation = new_dom_element
                            parentNode: parent
                            nodeName  : "span"
                            txt       : "Correlation from picture name " + ic._children[ 0 ].img.src + " to " + ic._children[ ic._children.length - 1 ].img.src + " have not been launched yet"
                        break 
                    
                    else
                        text = 
                        "Correlation used " + ic._children.length + " pictures<br>
                        From picture name " + ic._children[ 0 ].img.src + " to " + ic._children[ ic._children.length - 1 ].img.src + "<br>
                        Updates have been done on " + ic._children[ 0 ].img.src + "<br>"
                        
                        general_informations = new_dom_element
                            parentNode: parent
                            nodeName  : "div"
                            txt       : text
                            
                            
                            
                        new_dom_element
                            parentNode: parent
                            nodeName  : "h3"
                            txt       : "Correlation parameters"
                            
                        text_correlation_parameters = "Rigid body : " + correlation.parameters.rigid_body.get() + "<br>
                        Luminosity : " + correlation.parameters.lum_corr.get() + "<br>
                        Norm infinite with value "+ correlation.parameters.norm_inf.get() + "<br>
                        Norm 2 with value "+ correlation.parameters.norm_2.get() + "<br>
                        Multi resolution : " + correlation.parameters.multi_res.get() + "<br>
                        Number max of iterations : " + correlation.parameters.nb_iter_max.get() + "<br>
                        "
#                         Residual : " + correlation._residual_history.get() + "<br>
                        correlation_parameters = new_dom_element
                            parentNode: parent
                            nodeName  : "div"
                            txt       : text_correlation_parameters
                            
                            
                            
                        new_dom_element
                            parentNode: parent
                            nodeName  : "h3"
                            txt       : "Mesh parameters"
                            
                        for di in correlation._children when di instanceof DiscretizationItem
                            break
                        for mesherit in di._children when mesherit instanceof MesherItem
                            break
                            
                        mesh_text = "Mesh type : " + mesherit.cell_type.toString() + "<br>
                        Base size : " + mesherit.base_size.toString() + "px<br>
                        Mesh got " + mesherit._mesh.points.length + " points<br>"
                        
                        
                        mesh_parameters = new_dom_element
                            parentNode: parent
                            nodeName  : "div"
                            txt       : mesh_text
                            
                            
                        data = []
                        for i in [ 0 .. 10 ]
                            data.push [ i , Math.exp( - i ) * 10, 0 ]
                        
                        if correlation.parameters.norm_2.get() != 0
                            data = correlation._norm_2_history.get()
                        else
                            data = correlation._norm_i_history.get()
                        
                        error = 0
                        for res in correlation._residual_history.get()
                            error += res
                        avg_cor_error = (error / correlation._residual_history.length ).toExponential( 2 )
                            
                            
                        if data?
                            new_dom_element
                                parentNode: parent
                                nodeName  : "h3"
                                txt       : "Convergence"
                                
                            text = "Average correlation convergence is reached after " + ( data.length / ( ic._children.length - 1 ) ).toFixed( 1 ) + " iterations<br>
                            Average correlation error is " + avg_cor_error + "<br>"
                                
                            average_correlation_convergence_error = new_dom_element
                                parentNode: parent
                                nodeName  : "div"
                                txt       : text
                                
                            @get_convergence_curve parent, data
                        
            #             for result in correlation._children when result instanceof ResultItem
            #                 break

                        new_dom_element
                            parentNode: parent
                            nodeName  : "h3"
                            txt       : "Results"
                            
#                         disp_txt = correlation._residual_history.get()
#                             
#                         new_dom_element
#                             parentNode: parent
#                             nodeName  : "span"
#                             txt       : "Displacement :<br>"
#                             
#                         new_dom_element
#                             parentNode: parent
#                             nodeName  : "textarea"
#                             txt       : disp_txt
                            
                            
                        res_txt = correlation._residual_history.get()
                            
                        new_dom_element
                            parentNode: parent
                            nodeName  : "span"
                            txt       : "Residual history :<br>"
                            
                        new_dom_element
                            parentNode: parent
                            nodeName  : "textarea"
                            txt       : res_txt
                            
                            
                            
                        norm_txt = data
                        
                        new_dom_element
                            parentNode: parent
                            nodeName  : "span"
                            txt       : "<br>Norm :<br>"
                            
                        new_dom_element
                            parentNode: parent
                            nodeName  : "textarea"
                            txt       : norm_txt
                        
                            
                            