class TreeAppApplication_CsvReader extends TreeAppApplication
    constructor: ->
        super()

        @name = 'Reader CSV'
        @powered_with    = 'SC'

        _ina = ( app ) =>
            app.data.focus.get() != app.selected_canvas_inst()?[ 0 ]?.cm.view_id


        #unv reader application 3D   
        @actions.push
            ico: "img/csvReader_bouton.png"
            siz: 1
            txt: "CSV file reader"
            ina: _ina
            fun: ( evt, app ) =>
                app.undo_manager.snapshot()
                #alert "New CsvReader asked"
                csv = @add_item_depending_selected_tree app.data, CsvReaderItem
                #alert "New CsvReader added"
