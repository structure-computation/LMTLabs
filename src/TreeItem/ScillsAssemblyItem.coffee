#
class ScillsAssemblyItem extends TreeItem
    constructor: (name = "Assembly" ) ->
        super()
        
        # default values
        @_name.set name
        @_ico.set "img/assembly_15.png"
        @_viewable.set false
        @add_child new ScillsPartSetItem
        @add_child new ScillsInterfaceSetItem
        @add_child new ScillsEdgeSetItem

        # attributes
        @add_attr
            nb_parts: 2
            nb_interfaces: 1
            nb_edges: 2
    
    accept_child: ( ch ) ->
        ch instanceof ScillsPartSetItem or 
        ch instanceof ScillsInterfaceSetItem or
        ch instanceof ScillsEdgeSetItem
        

    z_index: ->
        #
        
    
    sub_canvas_items: ->
        [ ]