#
class ScillsEdgeSetItem extends TreeItem
    constructor: ( @app_data, @panel_id ) ->
        super()
        
        # default values
        @_name.set "Edge collection"
        @_ico.set "img/interface_collection.png"
        @_viewable.set false
        @add_child new ScillsEdgeItem
        
        # attributes
        @add_attr
            edge_collection: new Lst
                
    accept_child: ( ch ) ->
        ch instanceof ScillsEdgeItem

    z_index: ->
        #
        
    sub_canvas_items: ->
        [ ]
    