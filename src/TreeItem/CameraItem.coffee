#
class CameraItem extends TreeItem
    @cam_items : {}
    
    constructor: ( app, @s, @name, @port ) ->
        super()

        # default values
        @_name.set @name
        @_ico.set "img/camera-photo.png"
        @_viewable.set true

        CameraItem.cam_items[ @model_id ] = this

        @img = new Img "", app

        @img.bind =>
            @_signal_change()
        
        @update_preview()
        
    update_preview: ->
        setTimeout ( =>
            @s.queue "snapshot #{@port} CameraItem.cam_items[#{@model_id}]\n"
            @s.flush()
        ), 1
        
    sub_canvas_items: ->
        [ @img ]
