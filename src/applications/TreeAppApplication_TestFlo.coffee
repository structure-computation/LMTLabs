class TreeAppApplication_TestFlo extends TreeAppApplication
    constructor: ->
        super()
        
        @name = 'Test Flo'
        @powered_with    = 'Flo'

        _ina = ( app ) =>
            app.data.focus.get() != app.selected_canvas_inst()?[ 0 ]?.cm.view_id
            
        @actions.push
            ico: "img/mesher_bouton.png"
            siz: 1
            txt: "Test Flo"
            ina: _ina
            fun: ( evt, app ) =>
                app.undo_manager.snapshot()
                tester = @add_item_depending_selected_tree app.data, TestFlo1Item
        

        
            