#
class CreepTimeHardeningMaterial extends Model
    constructor: ( ) ->
        super()
        
        # default values
        #@_name.set "isotropic plastic"
        #@_ico.set "img/material.png"
        #@_viewable.set false

        # attributes
        @add_attr  
            _name: "Creep, time Hardening"
            _type_num: 2
            _type_plast: "1"
            _type_endo: "0"
            elasticity:
              E: ["200", false]
              nu: ["0.3", false]
            creep:
              pl_multiplier: ["4.16", false]
              eq_stress_order: ["1", false]
              time_order: ["0", false]
              
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
    
        
    