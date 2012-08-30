class TreeAppModule_Correlation extends TreeAppModule
    constructor: ->
        super()
                
        @name = 'Correlation'

        @add_corr: ( app_data ) =>
            #
            m = @add_item_depending_selected_tree app_data, CorrelationItem
            #leg = new Legend "Displacement X"
            #res = new MeshItem
            #m.add_output res
            #@watch_item app, res
            app_data.watch_item m
            app_data.watch_item m._children[ 0 ]
            
        @actions.push
            ico: "img/correlation.png"
            siz: 2
            txt: "Correlation"
            fun: ( evt, app ) =>
                app.undo_manager.snapshot()
                @add_corr app.data
