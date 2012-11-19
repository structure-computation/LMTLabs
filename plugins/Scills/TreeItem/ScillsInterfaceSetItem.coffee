#
class ScillsInterfaceSetItem extends TreeItem
    constructor: ( @app_data, @panel_id ) ->
        super()
        
        # default values
        @_name.set "Interface collection"
        @_ico.set "img/interface_collection.png"
        @_viewable.set false
        #@add_child new ScillsInterfaceItem
        
        # attributes
        @add_attr
            interface_collection: new Lst
            
        @add_attr
            _interface_profile: new ScillsInterfaceItem 
                
    accept_child: ( ch ) ->
        ch instanceof ScillsInterfaceItem

    z_index: ->
        #
        
    sub_canvas_items: ->
        [ ]
    