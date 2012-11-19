#
class ScillsPartSetItem extends TreeItem
    constructor: ( @app_data, @panel_id ) ->
        super()
        
        # default values
        @_name.set "Part collection"
        @_ico.set "img/part_collection.png"
        @_viewable.set false
        
        # attributes
        @add_attr
            part_collection: new Lst
            _part_profile: new ScillsPartItem 
           
        @add_output new ScillsSetFilterItem
        @_output[0].add_child new ScillsSetItem @_name, @_ico
        
        @bind =>
            if  @_output[0].filter? and @_output[0].filter.has_been_modified()
                @filter_part_set()
        
    accept_child: ( ch ) ->
        ch instanceof ScillsPartItem 

    z_index: ->
        #
         
    sub_canvas_items: ->
        [ ]
     
    filter_part_set: ()->
        if !(@_output[0]._children[0])? 
            @_output[0].add_child new ScillsSetItem @_name, @_ico
        
        if @_children.length > 0
            if @_output[0]._children[0]._children.length > 0
                @_output[0]._children[0]._children.clear()
                for num_c in [ 0 ... @_output[0]._children[0].length ]
                    @_output[0]._children[0]._children.splice num_c, 1
            
            #alert  @_output[0].filter.type
            #alert  (@_output[0].filter.type.toString() == "by id")
            if @_output[0].filter.type.toString() == "by id"
#                 for num_c in [ 0 ... 1 ]
#                     @_output[0]._children[0].add_child @_children[num_c]     
                group = @_output[0].filter.filter.toString().split(",")
                
                #alert group.length
                for group_id in group
                    group_modulo = group_id.split("%")
                    #alert group_modulo.length
                    if group_modulo.length==2
                        range = group_modulo[0].split("-")
                        modulo_id = parseInt(group_modulo[1])
                        modulo = 0
                        out = true
                        while out
                            piece_id = []
                            if range.length==2
                                piece_id[0] = parseFloat(range[0]) + modulo
                                piece_id[1] = parseFloat(range[1]) + modulo
                                for part in @_children
                                    if part.id >= piece_id[0] and part.id <= piece_id[1]
                                       @_output[0]._children[0].add_child  part
                            else if range.length==1
                                piece_id[0] = parseFloat(range[0]) + modulo
                                for part in @_children
                                  if part.id == piece_id[0]
                                    @_output[0]._children[0].add_child  part
                            modulo += modulo_id
                            if (parseFloat(range[0]) + modulo) > @_children.length
                                #alert modulo
                                #alert parseFloat(piece_id[0]) + modulo
                                #alert @pieceViews.length
                                out = false
                                break
                                
                    else if group_modulo.length==1
                        range = group_modulo[0].split("-")
                        piece_id = []
                        if range.length==2
                            piece_id[0] = parseFloat(range[0])
                            piece_id[1] = parseFloat(range[1])
                            for part in @_children
                              if part.id >= piece_id[0] and part.id <= piece_id[1]
                                @_output[0]._children[0].add_child  part
                        else if range.length==1
                            piece_id[0] = parseFloat(range[0])
                            for part in @_children
                              if parseInt(part.id) == piece_id[0]
                                @_output[0]._children[0].add_child  part
    