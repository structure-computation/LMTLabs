#
class Code_Aster_DataItem extends TreeItem
    constructor: ( name = "Code_Aster_Data" ) ->
        super()
        
        @_name.set name
        @_ico.set "img/Code_Aster_Data_bouton.png"
        @_viewable.set false
        
        
        @add_attr
            pix2m : 0.00002
            thickness : 0.002
            computation_type : new Choice( 0, [ "Plane Stress 2D", "Plane Strain 2D", "Extruded 3D"] )
            n_el : 1
            n_timesteps : 1

        @add_child new Code_Aster_MaterialItem
        @add_child new BoundariesSelectionItem
        
    
    display_suppl_context_actions: ( context_action )  ->
       
        
    accept_child: ( ch ) ->
        ch instanceof FieldSetCorreliItem or
        ch instanceof BoundariesSelectionItem or
        ch instanceof FieldSetItem or
        ch instanceof FieldItem or
        ch instanceof MeshItem or
        ch instanceof Material_Code_Aster_Item or
        ch instanceof ImgSetItem

    disp_only_in_model_editor: ->
#         @mesh
