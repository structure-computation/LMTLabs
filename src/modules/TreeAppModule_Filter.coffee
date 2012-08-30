#
class TreeAppModule_Filter extends TreeAppModule
    constructor: ->
        super()
        
        @name = 'Filter'
        
        _ina = ( app ) =>
            app.data.focus.get() != app.selected_canvas_inst()?[ 0 ]?.cm.view_id and 
            app.data.focus.get() != app.treeview.view_id
            
        @actions.push
            ico: "img/material_selection.png"
            siz: 1
            ina: _ina
            txt: "Select part of material"
            fun: ( evt, app ) ->
                console.log "material selection"
            key: [ "Shift+Z" ]
            
        @actions.push
            ico: "img/cutting_plan.png"
            siz: 1
            ina: _ina
            txt: "Cut 3D shape with a plan"
            fun: ( evt, app ) =>
                console.log "cutting plan"
                selected_items = app.data.get_selected_tree_items()
                cutting_plan = @add_item_depending_selected_tree app.data, CuttingPlanItem
                @child_in_selected app, CuttingPlanItem, selected_items, cutting_plan
                app.undo_manager.snapshot()
            key: [ "Shift+P" ]
            
        @actions.push
            ico: "img/filter_z_32.png"
            siz: 1
            ina: _ina
            txt: "Elevation"
            fun: ( evt, app ) =>
                console.log "Show value on Z"
                app.undo_manager.snapshot()
            key: [ "Shift+V+Z" ]
            