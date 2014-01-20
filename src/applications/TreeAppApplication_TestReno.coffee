class TreeAppApplication_TestReno extends TreeAppApplication
    constructor: ->
        super()
         
        @name = 'TestReno'
        @powered_with    = 'EKS'
        
        _ina = ( app ) =>
            app.data.focus.get() != app.selected_canvas_inst()?[ 0 ]?.cm.view_id
        
        @actions.push
            ico: "img/TestReno_bouton.png"
            siz: 1
            txt: "test collection item"
            ina: _ina
            fun: ( evt, app ) =>
                app.undo_manager.snapshot()
                TestReno = @add_item_depending_selected_tree app.data, TestRenoItem
        