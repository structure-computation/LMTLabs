#
class TreeAppModule_Compute extends TreeAppModule
    constructor: ->
        super()
        
        @name = 'Compute'
        @visible = true
        
        
        _ina = ( app ) =>
            app.data.focus.get() != app.treeview.view_id
        
        _draw_loc = ( app ) ->
            for path in app.data.selected_tree_items
                if path.length > 1
                    m = path[ path.length - 1 ]
                    if m._can_be_computed?
                        if m._can_be_computed.get() == 0
                            this.ico = "img/manual_compute_inactive_24.png"
                        else if m._can_be_computed.get() == 1
                            this.ico = "img/manual_compute_24.png"
                        else if m._can_be_computed.get() == 2
                            this.ico = "img/auto_compute_24.png" #could be replaced by a gif
                        else if m._can_be_computed.get() == 3
                            this.ico = "img/auto_compute_24.png"
                        return true
            return false
            
        @actions.push
            txt: "Manual Compute"
            ico: "img/manual_compute_24.png"
            ina: _ina
            fun: ( evt, app ) =>
                for path in app.data.selected_tree_items
                    if path.length > 1
                        m = path[ path.length - 1 ]
                        if m._can_be_computed?
                            m._can_be_computed.set 1
                            
        @actions.push
            txt: "Auto Compute"
            ico: "img/auto_compute_24.png"
            ina: _ina
            fun: ( evt, app ) =>
                for path in app.data.selected_tree_items
                    if path.length > 1
                        m = path[ path.length - 1 ]
                        if m._can_be_computed?
                            m._can_be_computed.set 2
                            
        @actions.push
            txt: "Compute"
            ico: ""
            ina: _ina
            dra: _draw_loc
            loc: true
            fun: ( evt, app ) =>
                for path in app.data.selected_tree_items
                    if path.length > 1
                        m = path[ path.length - 1 ]
                        if m._can_be_computed?
                            m._can_be_computed.set 1