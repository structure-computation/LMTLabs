#
class BCTypeItem extends TreeItem
    constructor: ( name = "BCType" ) ->
        super()
        
        @_name.set name
        @_ico.set "img/BCType_bouton.png"
        @_viewable.set false
        
        
        @add_attr
            Choice : new Choice( 0, [ "From disp. field", "Disp from text file"] )
            Data_X : "/home/mathieu/test_data/dx.txt"
            Data_Y : "/home/mathieu/test_data/dy.txt"
            Input_unit : new Choice( 0, [ "Meter", "Pixel"] )

    
    display_suppl_context_actions: ( context_action )  ->
       
        
    accept_child: ( ch ) ->

    disp_only_in_model_editor: ->
#         @mesh
