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
                app.undo_manager.snapshot()
                physics = @add_item_depending_selected_tree app.data, PhysicsItem
                
            key: [ "Shift+L" ]

        @actions.push
            ico: "img/border_constrain_displacement.png"
            siz: 1
            ina: _ina
            txt: "Constrain boundaries with displacement"
            fun: ( evt, app ) =>
                app.undo_manager.snapshot()
                constrain_border = @add_item_depending_selected_tree app.data, BorderDisplacementItem
            key: [ "Shift+G" ]
            
        @actions.push
            ico: "img/border_constrain_strain.png"
            siz: 1
            ina: _ina
            txt: "Constrain boundaries with strain"
            fun: ( evt, app ) =>
                app.undo_manager.snapshot()
                constrain_border = @add_item_depending_selected_tree app.data, BorderStrainItem
            key: [ "Shift+G" ]
            
        @actions.push
            ico: "img/border_constrain_pressure.png"
            siz: 1
            ina: _ina
            txt: "Constrain boundaries with pressure"
            fun: ( evt, app ) =>
                app.undo_manager.snapshot()
                constrain_border = @add_item_depending_selected_tree app.data, BorderPressureItem
            key: [ "Shift+G" ]
            
        @actions.push
            ico: "img/border_free.png"
            siz: 1
            ina: _ina
            txt: "Make a border out of any constrain"
            fun: ( evt, app ) =>
                app.undo_manager.snapshot()
                free_border = @add_item_depending_selected_tree app.data, BorderFreeItem

            key: [ "Shift+F" ]
            