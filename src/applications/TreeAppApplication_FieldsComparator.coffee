class TreeAppApplication_FieldsComparator extends TreeAppApplication
    constructor: ->
        super()
        
        @name = 'Fields Comparator'
        @powered_with    = 'SC'
        
        _ina = ( app ) =>
            app.data.focus.get() != app.selected_canvas_inst()?[ 0 ]?.cm.view_id
        
        #scult application 3D
        @actions.push
            ico: "img/fieldsComparator_bouton.png"
            siz: 1
            txt: "Fields Comparator"
            ina: _ina
            fun: ( evt, app ) =>
                app.undo_manager.snapshot()
                fieldsComparator = @add_item_depending_selected_tree app.data, FieldsComparatorItem
                
        