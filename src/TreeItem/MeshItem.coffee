#
class MeshItem extends TreeItem
    constructor: ( legend = undefined ) ->
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
        
        dis_x = new NodalField "Displacement X", [ 3.2, -4.7, -0.74, 1.2 ]
        @mesh_item.add_field dis_x
        dis_y = new NodalField "Displacement Y", [ -2, -7, 2, 1.05 ]
        @mesh_item.add_field dis_y
        dis_z = new NodalField "Displacement Z", [ 3, 5, 0.7, 2 ]
        @mesh_item.add_field dis_z
        
        displacement = new VectorialFields "Displacement", [ dis_x, dis_y, dis_z ]
        
        nf = new ElementaryField "Strain", [ 3.2, -4.7 ]
        @mesh_item.add_field nf
            
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

    # use on directory when browsing
    get_file_info: ( info ) ->
        info.model_type = "Mesh"
        info.icon = "mesh"
