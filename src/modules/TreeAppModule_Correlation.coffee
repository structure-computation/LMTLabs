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
                m = @add_item_depending_selected_tree app, CorrelationItem
                res = new ResultItem app
                m.add_output res
                @watch_item app, res
                @watch_item app, res._children[ 0 ]
                app.undo_manager.snapshot()