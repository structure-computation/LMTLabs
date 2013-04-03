class TreeAppApplication_Annotation extends TreeAppApplication
    constructor: ->
        super()
        
        @mesher = ''
        @name = 'Note'
            
        @actions.push
            ico: "img/note.png"
            siz: 1
            txt: "Note"
            fun: ( evt, app ) =>
                app.undo_manager.snapshot()
                @mesher = @add_item_depending_selected_tree app.data, AnnotationItem
        

        
            