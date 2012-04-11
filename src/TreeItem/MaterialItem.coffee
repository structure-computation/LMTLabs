#
class MaterialItem extends TreeItem
    constructor: ->
        super()
        
        # default values
        @_name.set "Material"
        @_ico.set "img/material_16.png"
        @_viewable.set false
        
        # attributes
        @add_attr
            code: new StrLanguage("
Class Steel\n
    Poisson := 0.28\n
    Young := 210\n", "ruby", @parse_code_onchange)
    
        @lst_variables = new Lst
        @parse_code_onchange()
        
    accept_child: ( ch ) ->
        ch instanceof MaskItem or 
        ch instanceof PickedZoneItem or
        ch instanceof DiscretizationItem or
        ch instanceof SketchItem or 
        ch instanceof MeshItem or 
        ch instanceof ImgSetItem or
        ch instanceof ImgItem
                
        
    sub_canvas_items: ->
        []
    
    parse_code_onchange: =>
        # first delete all variables from
        for attr in @lst_variables
            @rem_attr attr.get() # focus seems to be loose when deleting      
        @lst_variables.clear()
        
        # then search all variables of type string := value
        reg = /(\w+?) *:= *([0-9\.]+)/g # option g select all occurrence
        i = 0
        while reg.exec @code.get()
            if i > 1000
                console.error 'Too much variables'
                break
#             console.log 'variable ',  RegExp.$1 ,' founded, value :', RegExp.$2
            variable = RegExp.$1
            variable_value = parseFloat RegExp.$2
            console.log variable_value
            # add founded variable as attributes
            if not @[ variable ]?                                 # if variable doesn't exist
                @add_attr variable, variable_value
                @lst_variables.push variable
                
#             else if @[ variable ].get() != variable_value       # actualise value if it exist
#                 @[ variable ].set variable_value
            i++