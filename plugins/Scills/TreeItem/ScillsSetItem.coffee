#
class ScillsSetItem extends TreeItem
    constructor: ( name = "PartSet", ico = ""  ) ->
        super()
        
        # default values
        @_name.set name
        @_ico.set ico
        @_viewable.set true
        
        @add_attr
            filter:
                type: ""
                filter: ""
        
    accept_child: ( ch ) ->
        ch instanceof ScillsPartItem or
        ch instanceof ScillsInterfaceItem or
        ch instanceof ScillsEdgeItem

    z_index: ->
        #
         
    sub_canvas_items: ->
        [ ]
        
        
        
    
    