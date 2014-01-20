class TreeAppApplication_Acquisition extends TreeAppApplication
    constructor: ->
        super()
        
        @name = 'Hardware acquisition'
        @powered_with    = 'SC'
            
        @actions.push
            ico: "img/acquisition_bouton.png"
            siz: 1
            txt: "Acquisition"
            fun: ( evt, app ) =>
                app.undo_manager.snapshot()
                acquisition = @add_item_depending_selected_tree app.data, AcquisitionItem
        
        
            