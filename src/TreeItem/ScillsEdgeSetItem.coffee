#
class ScillsEdgeSetItem extends TreeItem
    constructor: ( @app_data, @panel_id ) ->
        super()
        
        # default values
        @_name.set "Edge collection"
        @_ico.set "img/edge_collection.png"
        @_viewable.set false
        
        # attributes
        @add_attr
            edge_collection: new Lst
            
        @add_attr
            _edge_profile: new ScillsEdgeItem 
                
    accept_child: ( ch ) ->
        ch instanceof ScillsEdgeItem

    z_index: ->
        [ ]
        #
        
    sub_canvas_items: ->
        [ ]
    