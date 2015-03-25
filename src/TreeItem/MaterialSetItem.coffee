#
class MaterialSetItem extends TreeItem
    constructor: ( dim = 3 ) ->
        super()
        
        # default values
        @_name.set "Material collection"
#         @_ico.set "img/material_collection.png"
        @_viewable.set false
        
        # attributes
        @add_attr
            _nb_materials:0
            _incr_id_material:0
            _incr_id_group_part:0
            _dim: dim
            
        @add_attr
            nb_materials: @_nb_materials
        
        @add_context_actions
            txt: "add material"
            ico: "img/add.png"
            fun: ( evt, app ) =>
                #alert "add material"
                items = app.data.selected_tree_items
                for path_item in items
                    item = path_item[ path_item.length - 1 ]
                    item._nb_materials.set(item._nb_materials.get() + 1)
                    
        @add_context_actions
            txt: "remove material"
            ico: "img/remove.png"
            fun: ( evt, app ) =>
                #alert "remove material"
                items = app.data.selected_tree_items
                for path_item in items
                    item = path_item[ path_item.length - 1 ]
                    item._nb_materials.set(item._nb_materials.get() - 1) if item._nb_materials.get() > 0
        
        
        @bind =>
            if  @_nb_materials.has_been_modified()
                @change_collection()
                
    accept_child: ( ch ) ->
        false

    z_index: ->
        #
         
    sub_canvas_items: ->
        [ ]
    
    ask_for_id_group: ->
        id_group = parseInt(@_incr_id_group_part)
        @_incr_id_group_part.set (parseInt(@_incr_id_group_part) + 1)
        return id_group
        
    ask_for_id_mat: ->
        id_mat = parseInt(@_incr_id_material)
        @_incr_id_material.set (parseInt(@_incr_id_material) + 1)
        #@_incr_id_material +=1
        return id_mat
    
    change_collection: ->
        #modification du nombre de chargements
        size_splice = 0
        if @_children.length > @_nb_materials
            size_splice = @_children.length - @_nb_materials
            @_children.splice @_nb_materials, size_splice
            
        else 
            size_child0_child = @_children.length
            for num_c in [ size_child0_child ... @_nb_materials ]
                id_mat = @ask_for_id_mat()
                name_temp = "Mat_" + id_mat.toString()
                @add_child  (new ScillsMaterialItem name_temp, id_mat, @_dim)
                
                
    set_filter_part: (part_filter,mat_id)->
        @_parents[0]._parents[0].set_filter_part(part_filter, mat_id)
        @assign_parts_to_materials()
        
    assign_parts_to_materials: ->
        for mat in @_children
            for part_filter in mat._children
                for part in part_filter._children
                    if parseInt(part.material_id) == -1
                        part.material_id.set mat._id
                    if parseInt(part.group_id) == -1
                        part.group_id.set part_filter._id
        
        
        
        
        
        
        
    