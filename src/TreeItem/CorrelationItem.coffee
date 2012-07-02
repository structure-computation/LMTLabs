#
class CorrelationItem extends TreeItem_Computable
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
            visualization         : new Choice
            rigid_body_corr       : true
            lum_corr              : true
            wanted_norm_inf       : 1e-3 # [ new Choice( 0, [ "||dU||2", "||dU||inf"] ), 1e-5 ]
            wanted_norm_2         : 0 # [ new Choice( 0, [ "||dU||2", "||dU||inf"] ), 1e-5 ]
            # <math>\delta \infty</math>            mod: [ 1e-5, new Choice( 0, [ "||&#8710;u||2", "||&#8710;u||&#x221E;"] ) ]

            # con: 1e-5
            multi_resolution      : new ConstrainedVal( 0, { min: 0, max: 10, div: 10 } )
            nb_iter_max           : 50
            preview_result        : false
            
            # results
            _norm_i_history       : []
            _norm_2_history       : []
            _residual_history     : []

        # with choice roll
        #         @pre_fft._model_editor_item_type = ModelEditorItem_Bool_Img
        #         @pre_fft._model_editor_display_name = "Pre-fft"
        #         
        #         @luminosity_correction._model_editor_item_type = ModelEditorItem_Bool_Img
        #         
        #         # @convergence[ 0 ]._model_editor_item_type = ModelEditorItem_Choice_Roll
        #        
        #         @preview_result._model_editor_item_type = ModelEditorItem_Bool_Img
        #         @preview_result._model_editor_display_name = "Preview result"
        # 
        #         @multi_resolution._model_editor_display_name = "Multi-resolution"
        
        #         @correlation._model_editor_item_type = ModelEditorItem_Button
        
        #         @elX._model_editor_display_name = "Element size X"
        #         @elY._model_editor_display_name = "Element size Y"
        
    get_model_editor_parameters: ( res ) ->
        res.model_editor[ "visualization" ] = ModelEditorItem_ChoiceWithEditableItems
            

    accept_child: ( ch ) ->
        ch instanceof MaskItem or 
        ch instanceof DiscretizationItem or
        ch instanceof SketchItem or 
        ch instanceof ImgSetItem or
        ch instanceof TransformItem
        
    sub_canvas_items: ->
        d = @visualization.item()
        if d?
            [ d ]
        else
            []
        
    cosmetic_attribute: ( name ) ->
        super( name ) or ( name in [ "visualization" ] )
        
    
    information: ( div ) ->
        if not @txt?
            @txt = new_dom_element
                parentNode: div
                
        @txt.innerHTML = @_norm_2_history.get()


            
