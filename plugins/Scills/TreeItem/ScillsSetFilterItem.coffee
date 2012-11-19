#
class ScillsSetFilterItem extends TreeItem
    constructor: ( @app_data, @panel_id ) ->
        super()
        
        # default values
        @_name.set "filter"
        @_ico.set "img/fleche_output.png"
        @_viewable.set false
         
        # attributes
        @add_attr
            filter:
                type: new Choice( 0, [ "by id", "by name" ] )
                filter: ""
                
     
    cosmetic_attribute: ( name ) ->
        super( name ) or ( name in [ "filter"] )  
                
    accept_child: ( ch ) ->
        ch instanceof ScillsSetItem

    z_index: ->
        #
         
    sub_canvas_items: ->
        [ ]
        
    