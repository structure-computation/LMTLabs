#
class TestCollectionTreeItem extends CollectionTreeItem
    constructor: ( name = "test_collection_item" ) ->
        super()

        @_name.set name
        #@_ico.set "img/plot2D.png"
        @_viewable.set false
        
        @add_attr
            name_child : "test"
                
    
    add_collection_item: ->
        # function to overload 
        id_child = @ask_for_id_collection_child()
        name_temp = @name_child + id_child.toString()
        @add_child  (new TestChildItem name_temp, id_child, @_dim)
    

