#
class TreeAppModule_Compute extends TreeAppModule
    constructor: ->
        super()
        
        @name = 'Compute'
        @visible = true
        
        
        _ina = ( app ) =>
            app.data.focus.get() != app.treeview.view_id
        
        _ina_build = ( app ) =>
            for el in app.treeview.flat when el.item instanceof TreeItem_Computable
                cm = el.item._computation_mode
                cs = el.item._computation_state
                if cm == false and cs == false
                    return false
            return true
            
        @actions.push
            txt: "Manual Compute"
            ico: "img/manual_compute_24.png"
            ina: _ina
            fun: ( evt, app ) =>
                for el in app.treeview.flat when el.item instanceof TreeItem_Computable
                    el.item._computation_mode.set false
                #                 for path in app.data.selected_tree_items when path.length > 1
                #                     m = path[ path.length - 1 ]
                #                     if m instanceof TreeItem_Computable
                #                         m._computation_mode.set 1
                
        @actions.push
            txt: "Build"
            ico: "img/play_24.png"
            ina: _ina_build
            vis: _ina_build # TODO, we expect this icon to disappear or be transformed in white and black when auto compute is true
            fun: ( evt, app ) =>
                for el in app.treeview.flat when el.item instanceof TreeItem_Computable
                    el.item._computation_state.set true
            key: [ "X" ]
                            
        @actions.push
            txt: "Auto Compute"
            ico: "img/auto_compute_24.png"
            ina: _ina
            fun: ( evt, app ) =>
                for el in app.treeview.flat when el.item instanceof TreeItem_Computable
                    el.item._computation_mode.set true
                    
        # loc icon ( use in edit view )
        @actions.push
            txt: "Already computed"
            ico: "img/manual_compute_inactive_24.png"
            ina: _ina
            loc: true
            fun: ( evt, app ) =>
                for path in app.data.selected_tree_items when path.length > 1
                    m = path[ path.length - 1 ]
                    if m instanceof TreeItem_Computable
                        m._computation_mode.set false
                        m._computation_state.set false
#                 @_toggle_inactive app
                
        @actions.push
            txt: "Set Item to manual compute"
            ico: "img/manual_compute_24.png"
            ina: _ina
            loc: true
            fun: ( evt, app ) =>
                for path in app.data.selected_tree_items when path.length > 1
                    m = path[ path.length - 1 ]
                    if m instanceof TreeItem_Computable
                        m._computation_mode.set false
                        m._computation_state.set true
#                 @_toggle_inactive app
                
        @actions.push
            txt: "Set Item to auto compute"
            ico: "img/auto_compute_24.png"
            ina: _ina
            loc: true
            fun: ( evt, app ) =>
                for path in app.data.selected_tree_items when path.length > 1
                    m = path[ path.length - 1 ]
                    if m instanceof TreeItem_Computable
                        m._computation_mode.set true
                        m._computation_state.set true
#                 @_toggle_inactive app
                
        @_toggle_inactive = ( app ) ->
            for path in app.data.selected_tree_items when path.length > 1
                m = path[ path.length - 1 ]
                if m instanceof TreeItem_Computable
                    if m.nothing_to_do() # stopped / or notn
                        0
                    else if m._computation_mode.get() == 1 # manual
                        1
                    else if m._computation_mode.get() == 2 #
                        2
                    return true
            return false
                
        
#         @_draw_loc = ( app ) ->
#             for path in app.data.selected_tree_items when path.length > 1
#                 m = path[ path.length - 1 ]
#                 if m instanceof TreeItem_Computable
#                     if m.nothing_to_do() # stopped / or notn
#                         ico = "img/manual_compute_inactive_24.png"
#                         txt = "Already computed"
#                         computation_mode = 0
#                         
#                     else if m._computation_mode.get() == 1 # manual
#                         ico = "img/manual_compute_24.png"
#                         txt = "Set Item to manual compute"
#                         computation_mode = 1
#                         
#                     else if m._computation_mode.get() == 2 #
#                         ico = "img/auto_compute_24.png"
#                         txt = "Set Item to auto compute"
#                         computation_mode = 2
#                         
#                     @_add_loc_actions txt, ico, computation_mode
#                     return true
#             return false
    
#     _add_loc_actions: ( txt="", ico="", computation_mode = 2 ) ->
#         @actions.push
#             txt: txt
#             ico: ico
#             loc: true
#             fun: ( evt, app ) =>
#                 for path in app.data.selected_tree_items when path.length > 1
#                     m = path[ path.length - 1 ]
#                     if m instanceof TreeItem_Computable
#                         m._computation_mode.set computation_mode
#                 @_draw_loc app