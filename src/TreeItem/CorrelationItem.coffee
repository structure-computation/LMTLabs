
#
class CorrelationItem extends TreeItem_Computable
    constructor: ->
        super()
        
        # default values
        @_name.set "Correlation"
        @_ico.set "img/correlation_19.png"
        @_viewable.set true
        @add_child new PhysicsItem
        @add_child new ImgSetItem
        @add_child new MaskItem
        @add_child new DiscretizationItem
        
        # attributes
        @add_attr
            visualization: new FieldSet
            parameters   :
                rigid_body      : true
                lum_corr        : true
                uncertainty     : false
                norm_inf        : 1e-2 # [ new Choice( 0, [ "||dU||2", "||dU||inf"] ), 1e-5 ]
                norm_2          : 0    # [ new Choice( 0, [ "||dU||2", "||dU||inf"] ), 1e-5 ]
                # <math>\delta \infty</math> mod: [ 1e-5, new Choice( 0, [ "||&#8710;u||2", "||&#8710;u||&#x221E;"] ) ]

                # con: 1e-5
                multi_res       : new ConstrainedVal( 0, { min: 0, max: 10, div: 10 } )
                nb_iter_max     : 10
                lambda_bulk     : 0
                max_displacement: -1
                crack_eps_threshold: -1
                ident           : false
                crack_dir       : [ 1, 0, 0 ]
                rb_guess        : [ 0, 0, 0 ]
#                 preview_result  : false
                #                 clear_lst       : false
            
            # results
            _norm_i_history       : []
            _norm_2_history       : []
            _residual_history     : []
            
            _residual_adv         : new NamedParametrizedDrawable( "Residual adv"    , new InterpolatedField )
            _residual             : new NamedParametrizedDrawable( "Residual"        , new InterpolatedField )
            _residual_int_adv     : new NamedParametrizedDrawable( "Residual int adv", new InterpolatedField )
            _residual_int         : new NamedParametrizedDrawable( "Residual int"    , new InterpolatedField )

         # @visualization: new FieldSet

    #     get_disp: ->
    #         for f in visualization.warp_by
    #             if f.name == "Displacement"
    #                 re
            
    accept_child: ( ch ) ->
        ch instanceof MaskItem or 
        ch instanceof DiscretizationItem or
        ch instanceof SketchItem or 
        ch instanceof ImgSetItem or
        ch instanceof TransformItem or
        ch instanceof PhysicsItem or
        ch instanceof BoundariesSelectionItem
        
    sub_canvas_items: ->
        res = []
        if @nothing_to_do()
            res.push @visualization
        return res
        
    cosmetic_attribute: ( name ) ->
        super( name ) or ( name in [ "visualization", "_residual", "_residual_adv", "_residual_int", "_residual_int_adv", "_norm_i_history", "_norm_2_history", "_residual_history" ] )
        
    
    information: ( div ) ->
        if not @txt?
            @txt = new_dom_element
                parentNode: div
                
        @txt.innerHTML = @_norm_2_history.get()


            
