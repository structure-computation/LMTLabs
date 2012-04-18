#
class TreeAppModule_MechanicalData extends TreeAppModule
    constructor: ->
        super()
        
        @name = 'Mechanical Data'
        
        _ina = ( app ) =>
            app.data.focus.get() != app.selected_canvas_inst()?[ 0 ]?.cm.view_id and 
            app.data.focus.get() != app.treeview.view_id
            
        @actions.push
            ico: "img/mechanical_tools.png"
            siz: 2
            ina: _ina
            txt: "Configure comportemental law"
            fun: ( evt, app ) =>
                selected_items = app.data.get_selected_tree_items()
                physics = @add_item_depending_selected_tree app, PhysicsItem
                app.undo_manager.snapshot()
                
            key: [ "Shift+L" ]

        @actions.push
            ico: "img/border_constrain_displacement.png"
            siz: 1
            ina: _ina
            txt: "Constrain boundaries with displacement"
            fun: ( evt, app ) =>
                selected_items = app.data.get_selected_tree_items()
                constrain_border = @add_item_depending_selected_tree app, BorderDisplacementItem
                app.undo_manager.snapshot()
            key: [ "Shift+G" ]
            
        @actions.push
            ico: "img/border_constrain_strain.png"
            siz: 1
            ina: _ina
            txt: "Constrain boundaries with strain"
            fun: ( evt, app ) =>
                selected_items = app.data.get_selected_tree_items()
                constrain_border = @add_item_depending_selected_tree app, BorderStrainItem
                app.undo_manager.snapshot()
            key: [ "Shift+G" ]
            
        @actions.push
            ico: "img/border_constrain_pressure.png"
            siz: 1
            ina: _ina
            txt: "Constrain boundaries with pressure"
            fun: ( evt, app ) =>
                selected_items = app.data.get_selected_tree_items()
                constrain_border = @add_item_depending_selected_tree app, BorderPressureItem
                app.undo_manager.snapshot()
            key: [ "Shift+G" ]
            
        @actions.push
            ico: "img/border_free.png"
            siz: 1
            ina: _ina
            txt: "Make a border out of any constrain"
            fun: ( evt, app ) =>
                selected_items = app.data.get_selected_tree_items()
                free_border = @add_item_depending_selected_tree app, BorderFreeItem
                app.undo_manager.snapshot()

            key: [ "Shift+F" ]
            