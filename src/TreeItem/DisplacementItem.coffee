#
class DisplacementItem extends TreeItem
    constructor: ( legend ) ->
        super()
        
        
        # attributes

            
        @add_attr
            displacement: new Mesh legend
        
        @displacement.points.push [ 0, 0, 0 ]
        @displacement.points.push [ 1, 0, 0 ]
        @displacement.points.push [ 0, 1, 0 ]
        @displacement.triangles.push [ 0, 1, 2 ]
        @displacement.displayed_field.lst.set [ "elem", "nodal" ]
        @displacement.displayed_field.set 0
    
        @displacement.nodal_fields.set
            nodal: [ 1, 0.5, 0 ]
            
        @displacement.elementary_fields.set
            elem : [ 120 ]
        
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
        [ @displacement ]
