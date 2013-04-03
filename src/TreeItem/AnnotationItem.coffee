#
class AnnotationItem extends TreeItem
    constructor: ( name = "Note" ) ->
        super()
        @add_attr
            title        : @_name
            _point       : new PointMesher
            note         : new Text "test"
        
        @add_attr
            point        : @_point.point

        @_name.set name
        @_ico.set "img/note.png"
        @_viewable.set true
        
        #@add_context_actions  new TreeAppModule_Mesher   
        #@add_context_actions  new TreeAppModule_Sketch
        
        
        
    accept_child: ( ch ) ->
        false
    
    sub_canvas_items: ->
        [ @_point ]
        
    z_index: ->
        @_point.z_index()
        
    draw: ( info ) ->
        draw_point = info.sel_item[ @model_id ]
        if @_point.length && draw_point
            for pm in @_point
                pm.draw info
                
    get_movable_entities: ( res, info, pos, phase ) ->
        for pm in @_point
            pm.get_movable_entities res, info, pos, phase
            
    on_mouse_down: ( cm, evt, pos, b ) ->
        for pm in @_point
            pm.on_mouse_down cm, evt, pos, b
        return false
            
    on_mouse_move: ( cm, evt, pos, b, old ) ->
        for pm in @_point
            pm.on_mouse_move cm, evt, pos, b, old
        return false