class TreeAppModule_Correlation extends TreeAppModule
    constructor: ->
        super()
                
        @actions.push
            ico: "img/correlation_24.png"
            txt: "Correlation"
            fun: ( evt, app ) =>
                #
                m = @add_item_depending_selected_tree app, CorrelationItem
                res = new ResultItem app
                m.add_child res
                @watch_item app, res
                @watch_item app, res._children[ 0 ]
                app.undo_manager.snapshot()