#
class ScillsPartSetItem extends TreeItem
    constructor: ( @app_data, @panel_id ) ->
        super()
        
        # default values
        @_name.set "Part collection"
        @_ico.set "img/part_collection.png"
        @_viewable.set false
        @add_child new ScillsPartItem
        @add_child new ScillsPartItem
        
        # attributes
        @add_attr
            part_collection: new Lst
                
    accept_child: ( ch ) ->
        ch instanceof ScillsPartItem

    z_index: ->
        #
         
    sub_canvas_items: ->
        [ ]
    