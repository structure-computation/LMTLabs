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
class TreeAppModule_Apps extends TreeAppModule
    constructor: ->
        super()
        
        @name = 'Apps'
        @visible = true
                
        _ina = ( app ) =>
            app.data.focus.get() != app.selected_canvas_inst()?[ 0 ]?.cm.view_id and 
            app.data.focus.get() != app.treeview.view_id
      
        @icon_app = new Lst
        
        @actions.push
            ico: "img/Apps.png"
            siz: 0.9
            txt: "Load app in tree"
            ina: _ina
            fun: ( evt, app ) =>
                @d = new_dom_element
                    className : "apps_container"
                    id        : "id_apps_container"
                
                #alert app.data.modules.length
                for i_app in [0 .. app.data.applications.length]
                    #alert app.data.modules[i_app].name
                    @display_app( app, app.data.applications[i_app] ) if app.data.applications[i_app]?
#                           src       : "img/parent.png"
#                           alt       : "Parent"
#                           title     : "App"
#                           onclick: ( evt ) =>
#                               app.undo_manager.snapshot()
#                               @mesher = @add_item_depending_selected_tree app.data, MesherItem
                
                inst = undefined
                for inst_i in app.selected_canvas_inst()
                    inst = inst_i
                
                
                if (inst.divCanvas)?
                  Ptop   = @getTop( inst.div )  
                  Pleft  = @getLeft( inst.div )  
                  Pwidth = inst.divCanvas.offsetWidth
                  Pheight = inst.divCanvas.offsetHeight
                  Pheight = Pheight + 22
                
                else
                  Ptop   = 100
                  Pleft  = 100
                  Pwidth = 800 
                  Pheight = 500 
                  
                    #position = inst.div.position()
                    #alert inst.div.offsetLeft + " " + inst.div.offsetTop + " " +  inst.div.offsetHeight + " " + inst.div.offsetWidth
                #alert "top : " + Ptop + " left : " + Pleft + " width : " +  Pwidth + " height : " + Pheight
                
                p = new_popup "Apps store", event: evt, child: @d, top_x: Pleft, top_y: Ptop, width: Pwidth, height: Pheight, onclose: =>
                    @onPopupClose( app )
                app.active_key.set false
                
#             key: [ "Shift+O" ]

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
    
        
    display_app: ( app, application ) =>
        if application.actions?
            group_app = new_dom_element
                parentNode: @d
                className : "app_group"
                nodeName  : "div"
#             group_name = new_dom_element
#                 parentNode: group_app
#                 className : "app_group_name"
#                 nodeName  : "div"
#                 txt       : application.name
            for act in application.actions
                ico_app = new_dom_element
                    parentNode: group_app
                    className : "app_icon"
                    nodeName  : "div"
                    onmousedown: ( evt ) =>
                        act.fun evt, app
#                           group_app.classList.toggle "block"
#                     onclick: ( evt ) =>
#                           act.fun( evt, app )
                @picture = new_dom_element
                    parentNode: ico_app
                    className : "picture"
                    nodeName  : "img"
                    src       : act.ico
                    alt       : act.txt
                    title     : act.txt
                    style:
                        maxWidth : 140
                        maxHeight: 70
                
                text_app = new_dom_element
                    parentNode: group_app
                    className : "app_group_text"
                    nodeName  : "div"
                
                @name_app = new_dom_element
                    parentNode: text_app
                    className : "app_group_title"
                    nodeName  : "div"
                    txt       : application.name
                
                @editor_app = new_dom_element
                    parentNode: text_app
                    className : "app_group_name"
                    nodeName  : "div"
                    style:
                        fontWidth : 0.8
                    txt       : "powered by"
                
                @powered_app = new_dom_element
                      parentNode: text_app
                      className : "app_group_name"
                      nodeName  : "div"
                      txt       : application.powered_with
                
                link_app = new_dom_element
                    parentNode: group_app
                    className : "app_group_link"
                    nodeName  : "div"
                
                #if application.publication_link? != ""
                @publication_link_app = new_dom_element
                    parentNode: link_app
                    className : "app_group_publication_link"
                    nodeName  : "div"
                    src       : act.ico
                    alt       : application.publication_link
                    title     : application.publication_link
                    onmousedown: ( evt ) =>
                        myWindow = window.open '',''
                        myWindow.document.location.href = application.publication_link
                        myWindow.focus()
                
                @tutorial_link_app = new_dom_element
                    parentNode: link_app
                    className : "app_group_tutorial_link"
                    nodeName  : "div"
                    src       : act.ico
                    alt       : application.tutorial_link
                    title     : application.tutorial_link
                    onmousedown: ( evt ) =>
                        myWindow = window.open '',''
                        myWindow.document.location.href = application.tutorial_link
                        myWindow.focus()

