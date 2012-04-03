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
            key: [ "Shift+0" ]
            
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
            
        test1 =
            mod: new Str "name"
            sub:
                prf: "list"
                act: [ ]
            key: [ "Ctrl+Alt+T" ]
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
                act: [test1, test2, test3 ]
                
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
                break;
#             console.log ic
            text = 
            "Correlation used " + ic._children.length + " pictures<br>
            From picture name " + ic._children[ 0 ].img.src + " to " + ic._children[ ic._children.length - 1 ].img.src + "<br>
            Updates have been done on " + ic._children[ 0 ].img.src + "<br>
            With following parameters :<br>
        Prefft : " + correlation.pre_fft.get() + "<br>
        Luminosity : " + correlation.luminosity_correction.get() + "<br>
        Norm : " + correlation.convergence[ 0 ].get() + " with value "+ correlation.convergence[ 1 ].get() + "<br>
        Multi resolution : " + correlation.multi_resolution.get() + "<br>
        Number max of iterations : " + correlation.iteration.get() + "<br>
        "
        
            correlation_parameters = new_dom_element
                parentNode: parent
                nodeName  : "div"
                txt       : text
                
#         Correlation used 4 pictures
#         From picture name : composite00 to composite04 with updates on : composite03
#         ZOI
#         P1 : 213.4 ; 286.1
#         P2 : 829.3 ; 729.9
#         Width : 615.9
#         Height : 443.8
# 
#         With following parameters :
#         prefft on
#         luminance on
#         norm 2 u
#         norm value : 10e-3
#         Number max of iterations : 50
#         Multi resolution : 3
#         Nodes X : 40 with a size of 16
#         Nodes Y : 29 with a size of 16

        