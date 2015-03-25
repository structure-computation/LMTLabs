#
class ElasticIsotropMaterial extends Model
    constructor: ( ) ->
        super()
        
        # default values
        #@_name.set "isotropic elastic"
        #@_ico.set "img/material.png"
        #@_viewable.set false

        # attributes
        @add_attr 
            _name: "Isotropic elastic"
            _type_num: 0
            _type_plast: "0"
            _type_endo: "0"
            elasticity:
              E: ["200", false]
              nu: ["0.3", false]
     
              
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
    
        
    