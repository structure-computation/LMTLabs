class TreeAppApplication_Acquisition extends TreeAppApplication
    constructor: ->
        super()
        
        @mesher = ''
        @name = 'Acquisition'
            
        @actions.push
            ico: "img/Acquisition.png"
            siz: 1
            txt: "Acquisition"
            fun: ( evt, app ) =>
                app.undo_manager.snapshot()
                @mesher = @add_item_depending_selected_tree app.data, AcquisitionItem
        
    add_corr: ( app_data ) =>
        #
        m = @add_item_depending_selected_tree app_data, AcquisitionItem

        
            