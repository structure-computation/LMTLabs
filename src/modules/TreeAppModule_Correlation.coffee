class TreeAppModule_Correlation extends TreeAppModule
    constructor: ->
        super()
                
        @name = 'Correlation'
        
        @actions.push
            ico: "img/correlation.png"
            siz: 2
            txt: "Correlation"
            fun: ( evt, app ) =>
                #
                app.undo_manager.snapshot()
                m = @add_item_depending_selected_tree app, CorrelationItem
                #leg = new Legend "Displacement X"
                #res = new MeshItem
                #m.add_output res
                #@watch_item app, res
                @watch_item app, m
                @watch_item app, m._children[ 0 ]
                