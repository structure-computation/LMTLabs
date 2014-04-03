#
class MaterialABQItem extends TreeItem
    constructor: ->
        super()
        
        # default values
        @_name.set "Material"
        @_ico.set "img/material_16.png"
        @_viewable.set false
        
        # attributes
        @add_attr 
            Comportement : new Choice( 0, [ "Elas_iso", "Elas_ortho", "Ramberg-Osgood" ] )
            code: new StrLanguage("
Class Steel\n
    Poisson := 0.33\n
    Young := 210\n
    rapport := 1\n
    n := 8\n
    sigma_0 := 150\n", "ruby", @parse_code_onchange)
    
        @_lst_variables = new Lst
#         @_old_lst_variables = new Lst
#         @_lst_variables_value = new Lst
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
        # first delete all variables from textarea
        if @_lst_variables.length > 0
            for attr in @_lst_variables
                @rem_attr attr.get() # focus seems to be loose when deleting
            @_lst_variables.clear()
        
        # then search all variables of type string := value
        reg = /(\w+?) *:= *([0-9\.]+)/g # option g select all occurrence
        i = 0
        while reg.exec @code.get()
            if i > 1000
                console.error 'Too much variables'
                break
            # console.log 'variable ',  RegExp.$1 ,' found, value :', RegExp.$2
            variable = RegExp.$1
            variable_value = parseFloat RegExp.$2
            # add found variable as attributes
            if not @[ variable ]? # if variable doesn't exist
                @add_attr variable, [ variable_value, true ]
                @_lst_variables.push variable
#             else # never call
#                 @set_attr @[ variable ], variable_value
#                 
            i++