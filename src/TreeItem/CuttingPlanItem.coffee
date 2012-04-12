#
class CuttingPlanItem extends TreeItem
    constructor: ->
        super()
        
        # default values
        @_name.set "Cutting Plan"
        @_ico.set "img/cutting_plan.png"
        @_viewable.set true
        
        # attributes
        @add_attr
            cutting_plan: new CuttingPlan
    
    accept_child: ( ch ) ->
        ch instanceof MaskItem or 
        ch instanceof DiscretizationItem or
        ch instanceof SketchItem or 
        ch instanceof MeshItem or 
        ch instanceof ImgSetItem or
        ch instanceof ImgItem
                
        
    sub_canvas_items: ->
        [ @cutting_plan ]
    
        
    on_mouse_down: ( cm, evt, pos, b ) ->
        @cutting_plan.on_mouse_down cm, evt, pos, b
                
    on_mouse_move: ( cm, evt, pos, b ) ->
        @cutting_plan.on_mouse_move cm, evt, pos, b