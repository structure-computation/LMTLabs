#
class MaskItem extends TreeItem
    constructor: ( @app_data, @panel_id ) ->
        super()
        
        # default values
        @_name.set "Mask"
        @_ico.set "img/mask_16.png"
        @_viewable.set false
#         @add_child new SketchItem

    accept_child: ( ch ) ->
        ch instanceof SketchItem or
        ch instanceof ImgItem or
        ch instanceof TransformItem

    z_index: ->
        #could call z_index() of child
        
    sub_canvas_items: ->
        [ ]