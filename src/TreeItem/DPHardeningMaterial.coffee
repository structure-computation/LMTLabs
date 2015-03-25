#
class DPHardeningMaterial extends Model
    constructor: ( ) ->
        super()
        
        # default values
        #@_name.set "isotropic plastic"
        #@_ico.set "img/material.png"
        #@_viewable.set false

        # attributes
        @add_attr  
            _name: "Drucker-Prager Hardening"
            _type_num: 2
            _type_plast: "1"
            _type_endo: "0"
            elasticity:
              E: ["200", false]
              nu: ["0.3", false]
            DruckerPrager:
              friction_angle: ["0.9", false]
              flowstress_ratio: ["0.9", false]
              dilation_angle: ["0.9", false]
            hardening:
              S0: ["200", false]
              eps0: ["0", false]
              
    toString: ->
        @_name.get()
    
    #cosmetic_attribute: ( name ) ->
    #    name in [ "elasticity" ]
    
    accept_child: ( ch ) ->
        #

    z_index: ->
        #
         
    sub_canvas_items: ->
        [ ]
    
        
    