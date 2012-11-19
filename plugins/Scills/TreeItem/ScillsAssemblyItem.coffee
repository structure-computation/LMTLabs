#
class ScillsAssemblyItem extends TreeItem_Computable
    constructor: (name = "Assembly" ) ->
        super()
        #@add_attr
        #    _mesh        : new Mesh( not_editable: true )
        # 
        #@add_attr
        #    visualization: @_mesh.visualization
            
        # default values
        @_name.set name
        @_ico.set "img/assembly_15.png"
        @_viewable.set true
        @add_child new ScillsPartSetItem
        @add_child new ScillsInterfaceSetItem
        @add_child new ScillsEdgeSetItem
        
        # attributes
        @add_attr
            id_model: 217
            id_calcul: -1
            nb_parts: 0
            nb_interfaces: 0
            nb_edges: 0
    
    accept_child: ( ch ) ->
        #false
        ch instanceof ScillsPartSetItem or 
        ch instanceof ScillsInterfaceSetItem or
        ch instanceof ScillsEdgeSetItem
    
    #cosmetic_attribute: ( name ) ->
    #    super( name ) or ( name in [ "_mesh", "visualization" ] )    
    
    sub_canvas_items: ->
         []
    
    #z_index: ->
    #    @_mesh.z_index()
     