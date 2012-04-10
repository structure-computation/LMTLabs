#
class MeshItem extends TreeItem
    constructor: ( legend ) ->
        super()
        
        # attributes
        @add_attr
            mesh_item: new Mesh legend
        
        @mesh_item.points.push [ 0, 0, 0 ]
        @mesh_item.points.push [ 0.25, 0, 0 ]
        @mesh_item.points.push [ 0, 0.25, 0 ]
        @mesh_item.points.push [ 0.25, 0.25, 0 ]
        @mesh_item.triangles.push [ 0, 1, 2 ]
        @mesh_item.triangles.push [ 1, 3, 2 ]
        @mesh_item.displayed_field.lst.set [ "elem", "nodal" ]
        @mesh_item.displayed_field.set 1
    
        @mesh_item.nodal_fields.set
            nodal: [ 3.2, -4.7, -0.74, 1.2 ]
            
        @mesh_item.elementary_fields.set
            elem : [ 3.2, -4.7 ]
        
        # default values
        @_name.set "Displacement"
        @_ico.set "img/displacement_16.png"
        @_viewable.set true

        
    accept_child: ( ch ) ->
        ch instanceof SketchItem or
        ch instanceof ImgItem

    z_index: ->
        #could call z_index() of child
        
    sub_canvas_items: ->
        [ @mesh_item ]

