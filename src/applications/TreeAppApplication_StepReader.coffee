class TreeAppApplication_StepReader extends TreeAppApplication
    constructor: ->
        super()
        
        @mesher = ''
        @name = 'StepReader'
        @powered_with    = 'OpenCascade'
        @company         = 'Structure Computation'
        @link            = ""     
        @group           = ""
        @key_words       = ["CAO"," model", "STEP", "geometrie"]
        
        
        _ina = ( app ) =>
            app.data.focus.get() != app.selected_canvas_inst()?[ 0 ]?.cm.view_id
            
        @actions.push
            ico: "img/mesher.png"
            siz: 1
            txt: "StepReader"
            ina: _ina
            fun: ( evt, app ) =>
                app.undo_manager.snapshot()
                @step_reader = @add_item_depending_selected_tree app.data, StepReaderItem
        
            key: [ "Shift+M" ]