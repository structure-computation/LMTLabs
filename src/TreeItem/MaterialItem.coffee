#
class MaterialItem extends TreeItem
    constructor: ->
        super()
        
        # default values
        @_name.set "Material"
        @_ico.set "img/cutting_plan.png"
        @_viewable.set false
        
        # attributes
        @add_attr
            code: new StrLanguage("
Class Steel\n
    Poisson := 0.28\n
    Young := 210\n", "ruby", @parse_code_onchange)
    
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
#         console.log @code.get()
        young = /Young := ([0-9\.]+)/i
        if young.exec @code.get()
            console.log 'young founded, value :', RegExp.$1
        else
            console.log ':('
