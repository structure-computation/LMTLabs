class TreeAppModule_ScillsAssembly extends TreeAppModule
    constructor: ->
        super()
         
        @name = 'Assemblage'
        
        @add_ass: ( app_data ) =>
            #
            m = @add_item_depending_selected_tree app_data, ScillsAssemblyItem
            app_data.watch_item m
            app_data.watch_item m._children[ 0 ]
        
        
        @actions.push
            ico: "img/assembly.png"
            txt: "Assembly"
            siz: 2
            fun: ( evt, app ) =>
                app.undo_manager.snapshot()
                @add_ass app.data