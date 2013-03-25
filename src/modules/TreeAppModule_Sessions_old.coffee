# Copyright 2012 Structure Computation  www.structure-computation.com
# Copyright 2012 Hugo Leclerc
#
# This file is part of Soda.
#
# Soda is free software: you can redistribute it and/or modify
# it under the terms of the GNU Lesser General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# Soda is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Lesser General Public License for more details.
# You should have received a copy of the GNU General Public License
# along with Soda. If not, see <http://www.gnu.org/licenses/>.



#
class TreeAppModule_Sessions extends TreeAppModule
    constructor: ->
        super()
        
        @name = 'Sessions'
        @visible = true
                
        _ina = ( app ) =>
            app.data.focus.get() != app.selected_canvas_inst()?[ 0 ]?.cm.view_id and 
            app.data.focus.get() != app.treeview.view_id
      
        @icon_app = new Lst
        
        @actions.push
            ico: "img/proprietes-session-icone-5116-128.png"
            siz: 0.9
            txt: "Browse your sessions"
            ina: _ina
            fun: ( evt, app ) =>
                if !SC_MODEL_ID? or SC_MODEL_ID == -1
                  d = "/home/monkey/sessions"
                else
                  d = "/home/projet_" + SC_MODEL_ID
                fs.load_or_make_dir d, ( session_dir, err ) ->
                    clear_page()
                    
                    div = new_dom_element

                    div_top = new_dom_element
                        parentNode: div
                        style:
                           width: "100%"
                           padding: "10px 20px 10px 20px"
                           height: "50px"
                           #background: "#e5e5e5"
                        
                        
                    # NEW SESSION
                    new_dom_element
                        nodeName: "button"
                        txt: "New session"
                        parentNode: div_top
                        onclick: ( evt ) ->
                            clear_page() 
                            name = prompt "Session name", "session " + new Date()
                            # name = "session " + new Date()
                            td = new_session()
                            
                            session_dir.add_file name, td, model_type: "Session", icon: "session"
                            window.location = "#" + encodeURI( "#{d}/#{name}" )
                            
                    
                    item_cp = new ModelEditorItem_Directory
                        el             : div
                        model          : session_dir
                        use_icons      : false
                        use_upload     : false
                        use_breadcrumb : false
                        display        : "Session" 

                    

                    # RELOAD
                    ModelEditorItem_Directory.add_action "Session", ( file, path, browser ) ->
                        clear_page()
                        window.location = "#" + encodeURI( "#{d}/#{file.name.get()}" )
                    
                    
                    inst = undefined
                    for inst_i in app.selected_canvas_inst()
                        inst = inst_i
                        
                    Ptop   = @getTop( inst.div )  
                    Pleft  = @getLeft( inst.div )  
                    Pwidth = inst.divCanvas.offsetWidth
                    Pheight = inst.divCanvas.offsetHeight
                    Pheight = Pheight + 22
                    p = new_popup "Browse sessions", event: evt, child: div, top_x: Pleft, top_y: Ptop, width: Pwidth, height: Pheight, onclose: =>
                    @onPopupClose( app )

    onPopupClose: ( app ) =>
        document.onkeydown = undefined
        app.active_key.set true
    
    # obtenir la position réelle dans le canvas
    getLeft: ( l ) ->
      if l.offsetParent?
          return l.offsetLeft + @getLeft( l.offsetParent )
      else
          return l.offsetLeft

    # obtenir la position réelle dans le canvas
    getTop: ( l ) ->
        if l.offsetParent?
            return l.offsetTop + @getTop( l.offsetParent )
        else
            return l.offsetTop
    
        