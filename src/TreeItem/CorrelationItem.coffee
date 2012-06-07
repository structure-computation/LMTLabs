#
class CorrelationItem extends TreeItem
    constructor: ->
        super()
        
        # default values
        @_name.set "Correlation"
        @_ico.set "img/correlation_19.png"
        @_viewable.set true
        @add_child new ImgSetItem
        @add_child new MaskItem
        @add_child new DiscretizationItem

        
        # attributes
        @add_attr
            pre_fft               : true
            luminosity_correction : true
            convergence           : [ new Choice( 0, [ "||dU||2", "||dU||inf"] ) ,1e-5]
            # <math>\delta \infty</math>            mod: [ 1e-5, new Choice( 0, [ "||&#8710;u||2", "||&#8710;u||&#x221E;"] ) ]

            # con: 1e-5
            multi_resolution      : new ConstrainedVal( 0, { min: 0, max: 10, div: 10 } )
            iteration             : 50
            preview_result        : false
            element_size          : [ 16, 16 ]
            _can_be_computed      : 0 # 0 / 1 / 2 respectively uncheck / manually computable / auto-computable
            #correlation           : new Button "Compute", "Connecting (click to abort)"
        

#         @correlation.change_allowed = ( state ) ->
#             state or confirm "Are you sure you want to abort ?"

        # with choice roll
        @pre_fft._model_editor_item_type = ModelEditorItem_Bool_Img
        @pre_fft._model_editor_display_name = "Pre-fft"
        
        @luminosity_correction._model_editor_item_type = ModelEditorItem_Bool_Img
        
        @convergence[ 0 ]._model_editor_item_type = ModelEditorItem_Choice_Roll
       
        @preview_result._model_editor_item_type = ModelEditorItem_Bool_Img
        @preview_result._model_editor_display_name = "Preview result"

        @multi_resolution._model_editor_display_name = "Multi-resolution"
        
        #         @correlation._model_editor_item_type = ModelEditorItem_Button
        
        #         @elX._model_editor_display_name = "Element size X"
        #         @elY._model_editor_display_name = "Element size Y"

    accept_child: ( ch ) ->
        ch instanceof MaskItem or 
        ch instanceof DiscretizationItem or
        ch instanceof SketchItem or 
        ch instanceof ImgSetItem or
        ch instanceof TransformItem
        
    z_index: ->
        #
        
    
    sub_canvas_items: ->
        [ ]