#
class ElasticOrthotropMaterial extends Model
    constructor: (dim = 3 ) ->
        super()
        
        # default values
        #@_name.set "orthotropic elastic"
        #@_ico.set "img/material.png"
        #@_viewable.set false

        # attributes
        @add_attr  
            _name: "Orthotropic elastic (not working atm)"
            _type_num: 1
            _type_plast: "0"
            _type_endo: "0"
            _dim: dim
            
        if (parseInt(@_dim) == 3)
            @add_attr 
                main_directions:
                    direction_1: [1, 0, 0]
                    direction_2: [0, 1, 0]
                    direction_3: [0, 0, 1]   
                elasticity:
                    E: ["200000", "200000", "200000"]
                    nu: ["0.3", "0.3", "0.3"]
                    G: ["0", "0", "0"]
        else
           @add_attr 
                main_directions:
                    direction_1: [1, 0]
                    direction_2: [0, 1]  
                elasticity:
                    E: ["200000", "200000"]
                    nu: ["0.3", "0.3"]
                    G: ["0", "0"] 
            
            
            
              
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
    
        
    