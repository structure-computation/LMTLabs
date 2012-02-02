#
class ResultItem extends TreeItem
    constructor: ( app ) ->
        super()
        
        @add_attr
            legend: new Legend "Displacement X"
            
        disp = @add_child new MeshItem @legend
            
        # default values
        @_name.set "Results"
        @_ico.set "img/results_16.png"
        @_viewable.set true
        
                
    accept_child: ( ch ) ->
        ch instanceof SketchItem or
        ch instanceof ImgItem or
        ch instanceof MeshItem
        
    z_index: ->
        #could call z_index() of child
        
    sub_canvas_items: ->
        [ @legend ]
        
    anim_min_max: ->
        #