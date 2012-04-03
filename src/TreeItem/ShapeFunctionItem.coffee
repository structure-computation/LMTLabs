#
class ShapeFunctionItem extends TreeItem
    constructor: ( name = "Shape Function" ) ->
        super()
        
        # attributes
        @add_attr
            code: new StrLanguage "
Class Fissure\n
    pos := Point( 0, 4 )\n
    dir := Point( 0, -1 )\n
    def shape_func( x )\n
        theta  := ...\n
        radius := ...\n
        return [\n
            heaviside( radius ),\n
            ...\n
        ]", "ruby"
        
        # default values
        @_name.set name
        @_ico.set "img/shape_function_16.png"
        @_viewable.set true
    
    accept_child: ( ch ) ->
        false
        
    sub_canvas_items: ->
        [  ]
       