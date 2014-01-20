# Browsing and dnd
class ModelEditorItem_Browse extends ModelEditorItem
    constructor: ( params ) ->
        super params
        
        @line_height = 30 # enough to contain the text
        
        @height = 30
                
        @container = new_dom_element
            parentNode: @ed
            nodeName  : "div"
            className : "ModelEditorDragAndDrop"
            style:
                color     : "rgba(0,0,0,0)"
                display   : "inline-block"
                width     : @ew + "%"
                height    : @height + "px"
                border    : "black solid thin"
            ondragover    : ( evt ) =>
                return false
                
            ondrop        : ( evt ) =>
                @drop evt

        @browse = new_dom_element
            parentNode: @container
            nodeName  : 'input'
            type      : 'file'
            multiple  : 'multiple'
                

    onchange: ->

#     dragStart(event) ->
#         event.dataTransfer.effectAllowed = 'move'
#         event.dataTransfer.setData("Text", event.target.getAttribute('id'))


    drop: ( event ) ->
        console.log "drop"
        event.stopPropagation()
        event.returnValue = false
        event.preventDefault()
        files = event.dataTransfer.files
        
        if event.dataTransfer.files.length > 0
            for file in files 
                format = file.type.indexOf "image"
                if format isnt -1
                    console.log file
                    pic = new ImgItem file.name
                    pic.file = file

        return false
# 
ModelEditorItem.default_types.push ( model ) -> ModelEditorItem_Browse if model instanceof Browse