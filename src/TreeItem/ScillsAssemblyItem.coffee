#
class ScillsAssemblyItem extends TreeItem_Computable
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
            id_model: -1
            id_calcul: -2
            nb_parts: 0
            nb_interfaces: 0
            nb_edges: 0
    
    accept_child: ( ch ) ->
        #false
        ch instanceof ScillsPartSetItem or 
        ch instanceof ScillsInterfaceSetItem or
        ch instanceof ScillsEdgeSetItem
     
    z_index: ->
        return 1000
        
    sub_canvas_items: ->
        [ ]
        