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
            pre_fft               : true
            luminosity_correction : true
            convergence           : [ new Choice( 0, [ "||dU||2", "||dU||inf"] ) ,1e-5 ]
            # <math>\delta \infty</math>            mod: [ 1e-5, new Choice( 0, [ "||&#8710;u||2", "||&#8710;u||&#x221E;"] ) ]

            # con: 1e-5
            multi_resolution      : new ConstrainedVal( 0, { min: 0, max: 10, div: 10 } )
            iteration             : 50
            preview_result        : false
            
            # results
            _mesh                 : new Mesh
            _norm_i_history       : []
            _norm_2_history       : []
            _residual_history     : []
            
        # meshattributes
        @add_attr
            visualization : @_mesh.visualization
        @_mesh.visualization.point_edition.set false
            

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
        
    sub_canvas_items: ->
        [ @_mesh ]
        
    z_index: () ->
        return @_mesh.z_index()
        
    cosmetic_attribute: ( name ) ->
        name in [ "visualization" ]
        
    
    information: ( div ) ->
        if not @txt?
            @txt = new_dom_element
                parentNode: div
                
        @txt.innerHTML = @_norm_2_history.get()


            
