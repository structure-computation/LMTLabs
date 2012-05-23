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
        #         @mesh_item.displayed_field.lst.set [ "elem", "nodal" ]
        #         @mesh_item.displayed_field.set 1
        
        #         @mesh_item.nodal_fields.set
        #             nodal: [ 3.2, -4.7, -0.74, 1.2 ]
        #             
        #         @mesh_item.elementary_fields.set
        #             elem : [ 3.2, -4.7 ]
        
        ef = new Elementary_Fields "toto", [ 3.2, -4.7 ]
        #ef.add_display_style "Wireframe"
        #ef.add_display_style "Surface"
        @mesh_item.add_field ef
        
        nf = new Nodal_Fields "toto", [ 3.2, -4.7, -0.74, 1.2 ]
        @mesh_item.add_field nf
        #         nf.add_display_style "Wireframe"
        #         nf.add_display_style "Surface"
        #         nf._warp_by.push "Something"
        #         @mesh_item._field.push nf
        
        #         if @mesh_item._field.length > 0
        #             for df in @mesh_item._field
        #                 @mesh_item.displayed_field.lst.push df.name.get()
        #                 
        #             for ds in @mesh_item._field[ @mesh_item.displayed_field.num.get() ]._display_style
        #                 @mesh_item.displayed_style.lst.push ds.get()
        #             
        #             for wb in @mesh_item._field[ @mesh_item.displayed_field.num.get() ]._warp_by
        #                 @mesh_item.warp_by.lst.push wb.get()
            
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
