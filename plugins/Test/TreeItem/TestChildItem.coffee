class TestChildItem extends TreeItem
    constructor: (name = "test", id_bc = 0, dim = 3) ->
        super()
        
        # default values
        @_name.set name
        @_ico.set "img/boundary_condition.png"
        @_viewable.set false

        # attributes
        @add_attr
            _nb_edge_filters: 1
            name: @_name
            _id: id_bc
            _info_ok: parseInt(0)
            _dim: dim