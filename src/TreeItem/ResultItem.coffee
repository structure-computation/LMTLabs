#
class ResultItem extends TreeItem
    constructor: ( app ) ->
        super()
        
            
        disp = @add_child new DisplacementItem app
            
        # default values
        @_name.set "Results"
        @_ico.set "img/results_16.png"
        @_viewable.set false
        
                
    accept_child: ( ch ) ->
        ch instanceof SketchItem or
        ch instanceof ImgItem or
        ch instanceof DisplacementItem 
        
    z_index: ->
        #could call z_index() of child
        
    sub_canvas_items: ->
        [ ]
        
    anim_min_max: ->
        #