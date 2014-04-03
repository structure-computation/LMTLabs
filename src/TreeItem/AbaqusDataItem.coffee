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

        @add_child new MaterialABQItem
        @add_child new BoundariesSelectionItem
        
    
    display_suppl_context_actions: ( context_action )  ->
       
        
    accept_child: ( ch ) ->
        ch instanceof FieldSetCorreliItem or
        ch instanceof BoundariesSelectionItem or
        ch instanceof FieldSetItem or
        ch instanceof FieldItem or
        ch instanceof MeshItem or
        ch instanceof MaterialABQItem
        

    disp_only_in_model_editor: ->
#         @mesh
