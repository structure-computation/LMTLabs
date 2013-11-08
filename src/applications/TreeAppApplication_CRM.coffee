class TreeAppApplication_CRM extends TreeAppApplication
    constructor: ->
        super()
         
        @name = 'Collaborative CRM'
        @powered_with    = 'SC'
        
        _ina = ( app ) =>
            app.data.focus.get() != app.selected_canvas_inst()?[ 0 ]?.cm.view_id
        
        @actions.push
            ico: "img/CRM_bouton.png"
            siz: 1
            txt: "test collection item"
            ina: _ina
            fun: ( evt, app ) =>
                app.undo_manager.snapshot()
                CRM = @add_item_depending_selected_tree app.data, CRMItem
        