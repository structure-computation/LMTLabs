class TreeAppApplication_Test extends TreeAppApplication
    constructor: ->
        super()
         
        @name = 'Test apps'
        
        _ina = ( app ) =>
            app.data.focus.get() != app.selected_canvas_inst()?[ 0 ]?.cm.view_id
        
        
        #unv reader application 3D   
        @actions.push
            ico: "img/addlist.png"
            siz: 1
            txt: "test collection item"
            ina: _ina
            fun: ( evt, app ) =>
                app.undo_manager.snapshot()
                test = @add_item_depending_selected_tree app.data, TestCollectionTreeItem
        