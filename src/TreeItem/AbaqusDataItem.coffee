#
class AbaqusDataItem extends TreeItem
    constructor: ( name = "AbaqusData" ) ->
        super()
        
        @_name.set name
        @_ico.set "img/AbaqusData_bouton.png"
        @_viewable.set false
        
        
        @add_attr
            pix2m : 0.00002
            thickness : 0.002
            computation_type : new Choice( 0, [ "Plane Stress 2D", "Plane Strain 2D", "Extruded 3D"] )
            n_el : 1
            n_timesteps : 1

        @add_child new ABQMaterialItem
        @add_child new BoundariesSelectionItem
        
    
    display_suppl_context_actions: ( context_action )  ->
       
        
    accept_child: ( ch ) ->
        ch instanceof FieldSetCorreliItem or
        ch instanceof FieldSetItem or
        ch instanceof FieldItem or
        ch instanceof MeshItem or
        ch instanceof ImgSetItem

    disp_only_in_model_editor: ->
#         @mesh
