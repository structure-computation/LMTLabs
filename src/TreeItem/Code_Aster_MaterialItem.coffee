#
class Code_Aster_MaterialItem extends TreeItem
    constructor: (name = "Material", id_mat = 0, dim = 3 ) ->
        super()
        
        # default values
        @_name.set name
#         @_ico.set "img/material.png"
        @_viewable.set false

        # attributes
        @add_attr
            _nb_part_filters: 1
            alias: @_name
            _id: id_mat
            _info_ok: parseInt(0)
            _dim: dim
        
        @add_attr
            type: new Choice
        
        elastic_isotrop_mat = new ElasticIsotropMaterial
        powerlaw_mat = new PowerlawMaterial
       
        @type.lst.push elastic_isotrop_mat
        @type.lst.push powerlaw_mat
         
        @add_context_actions
            txt: "add part filter"
            ico: "img/add.png"
            fun: ( evt, app ) =>
                #alert "add material"
                items = app.data.selected_tree_items
                for path_item in items
                    item = path_item[ path_item.length - 1 ]
                    item._nb_part_filters.set(item._nb_part_filters.get() + 1)
                    
        @add_context_actions
            txt: "remove part filter"
            ico: "img/remove.png"
            fun: ( evt, app ) =>
                #alert "remove material"
                items = app.data.selected_tree_items
                for path_item in items
                    item = path_item[ path_item.length - 1 ]
                    item._nb_part_filters.set(item._nb_part_filters.get() - 1) if item._nb_part_filters.get() > 0
            
        @bind =>
            if  @_nb_part_filters.has_been_modified()
                @change_collection()
    
    get_model_editor_parameters: ( res ) ->
       res.model_editor[ "type" ] = ModelEditorItem_ChoiceWithEditableItems
    

    z_index: ->
        #
         
    sub_canvas_items: ->
        [ ]
   
    set_filter_part: (part_filter)->
        @_parents[0]._parents[0].set_filter_part(part_filter,@_id)
    
    ask_for_id_group: ->
        return @_parents[0]._parents[0].ask_for_id_group()
    
  #   change_collection: ->
        #modification du nombre de chargements
   #     size_splice = 0
    #    if @_children.length > @_nb_part_filters
   #         size_splice = @_children.length - @_nb_part_filters
   #         @_children.splice @_nb_part_filters, size_splice
  #          
  #      else 
  #          size_child0_child = @_children.length
  #          for num_c in [ size_child0_child ... @_nb_part_filters ]
  #              id_group = @ask_for_id_group()
  #              name_temp = "Part_Group_" + id_group.toString()
  #              @add_child  (new ScillsPartFilterItem name_temp, id_group)
        
    information: ( div ) ->
        if @_info_ok < 2
            @txt = new_dom_element
                  parentNode: div
            @txt.innerHTML = "
                  id : #{@_id} <br>
              "
            @_info_ok.set (parseInt(@_info_ok) + 1)
        
    