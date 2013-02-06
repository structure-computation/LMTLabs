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
            ico: "img/screenshots.png"
            siz: 2
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
                
                p = new_popup "Apps store", event: evt, child: @d, onclose: =>
                    @onPopupClose( app )
                app.active_key.set false
                
#             key: [ "Shift+O" ]

    onPopupClose: ( app ) =>
        document.onkeydown = undefined
        app.active_key.set true
        
        
    display_app: ( app, application ) =>
        if application.actions?
#             group_app = new_dom_element
#                 parentNode: @d
#                 className : "app_group"
#                 nodeName  : "div"
#             group_name = new_dom_element
#                 parentNode: group_app
#                 className : "app_group_name"
#                 nodeName  : "div"
#                 txt       : application.name
            for act in application.actions
                ico_app = new_dom_element
                      parentNode: @d
                      className : "app_icon"
                      nodeName  : "div"
                      onmousedown: ( evt ) =>
                          act.fun evt, app
                          group_app.classList.toggle "block"
#                       onclick: ( evt ) =>
#                            act.fun( evt, app )
                @picture = new_dom_element
                      parentNode: ico_app
                      className : "picture"
                      nodeName  : "img"
                      src       : act.ico
                      alt       : act.txt
                      title     : act.txt
                      style:
                          maxWidth : 60
                          maxHeight: 70
