#
class TreeAppModule_Compute extends TreeAppModule
    constructor: ->
        super()
        
        @name = 'Compute'
        @visible = true
        
        
        _ina = ( app ) =>
            app.data.focus.get() != app.treeview.view_id
            
        @actions.push
            txt: "Manual Compute"
            ico: "img/manual_compute_24.png"
            ina: _ina
            fun: ( evt, app ) =>
                for path in app.data.selected_tree_items when path.length > 1
                    m = path[ path.length - 1 ]
                    if m instanceof TreeItem_Computable
                        m._computation_mode.set 1
                            
        @actions.push
            txt: "Auto Compute"
            ico: "img/auto_compute_24.png"
            ina: _ina
            fun: ( evt, app ) =>
                for path in app.data.selected_tree_items when path.length > 1
                    m = path[ path.length - 1 ]
                    if m instanceof TreeItem_Computable
                        m._computation_mode.set 2
                            
        
        # TODO at least one manual update...
        _draw_loc = ( app ) ->
            for path in app.data.selected_tree_items when path.length > 1
                m = path[ path.length - 1 ]
                if m instanceof TreeItem_Computable
                    if m.nothing_to_do() # stopped / or notn
                        @ico = "img/manual_compute_inactive_24.png"
                    else if m._computation_mode.get() == 1 # manual
                        @ico = "img/manual_compute_24.png"
                    else if m._computation_mode.get() == 2 #
                        @ico = "img/auto_compute_24.png"
                    return true
            return false
            
        @actions.push
            txt: "Compute"
            ico: ''
            ina: _ina
            dra: _draw_loc
            loc: true
            fun: ( evt, app ) =>
                for path in app.data.selected_tree_items when path.length > 1
                    m = path[ path.length - 1 ]
                    if m instanceof TreeItem_Computable
                        m._computation_mode.set 1
                        
                this.actions[ 2 ].dra app