#
class PowerlawMaterial extends Model
    constructor: ( ) ->
        super()
        
        # default values
        #@_name.set "isotropic plastic"
        #@_ico.set "img/material.png"
        #@_viewable.set false

        # attributes
        @add_attr  
            _name: "Powerlaw"
            _type_num: 2
            _type_plast: "1"
            _type_endo: "0"
            elasticity:
              E: ["200", false]
              nu: ["0.3", false]
            plasticity:
              S0: ["200", false]
              a: ["300", false]
              n: ["0.3", false]
              
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
    
        
    