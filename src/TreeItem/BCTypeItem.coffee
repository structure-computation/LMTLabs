#
class BCTypeItem extends TreeItem
    constructor: ( name = "BCType" ) ->
        super()
        
        @_name.set name
        @_ico.set "img/BCType_bouton.png"
        @_viewable.set false
        
        
        @add_attr
            Choice : new Choice( 0, [ "From disp. field", "Disp from text file"] )
            Input_unit : new Choice( 0, [ "Meter", "Pixel"] )
            Displacement_X : "/home/mathieu/test_data/dx.txt"
            Displacement_Y : "/home/mathieu/test_data/dy.txt"

    
    display_suppl_context_actions: ( context_action )  ->
       
        
    accept_child: ( ch ) ->

    disp_only_in_model_editor: ->
#         @mesh
