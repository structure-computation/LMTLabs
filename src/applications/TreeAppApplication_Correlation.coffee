class TreeAppApplication_Correlation extends TreeAppApplication
    constructor: ->
        super()
                
        @name = 'Correlation'
            
        @actions.push
            ico: "img/correlation.png"
            siz: 2
            txt: "Correlation"
            fun: ( evt, app ) =>
                app.undo_manager.snapshot()
                @add_corr app.data


    add_corr: ( app_data ) =>
        #
        m = @add_item_depending_selected_tree app_data, CorrelationItem
#         app_data.watch_item m
#         app_data.watch_item m._children[ 1 ]
        