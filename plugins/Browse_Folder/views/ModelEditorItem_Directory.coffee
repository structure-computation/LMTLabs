# Browsing and dnd
class ModelEditorItem_Directory extends ModelEditorItem
    constructor: ( params ) ->
        super params
        
        @breadcrumb = new Lst
        @breadcrumb.push @model
        
       
        @selected_file = []
        @clipboard     = [] # contain last 'copy' or 'cut' file
        
        @allow_shortkey = true # allow the use of shortkey like Ctrl+C / Delete. Set to false when renaming
        
        @line_height = 30 # enough to contain the text
        
        
        @container = new_dom_element
                parentNode: @ed                
                nodeName  : "div"
                        
        @icon_scene = new_dom_element
                parentNode: @container
                nodeName  : "div"
                className : "icon_scene"
                
        @icon_up = new_dom_element
                parentNode: @icon_scene
                nodeName  : "img"
                src       : "img/parent.png"
                alt       : "Parent"
                title     : "Parent"
                onclick: ( evt ) =>
                    # watching parent
                    @load_model_from_breadcrumb @breadcrumb.length - 2
                    
        @icon_new_folder = new_dom_element
                parentNode: @icon_scene
                nodeName  : "img"
                src       : "img/add_folder.png"
                alt       : "New folder"
                title     : "New folder"
                onclick: ( evt ) =>
                    n = new File Directory, "New folder"
                    @model.data.children.push n
                    @refresh()
                    
        @icon_cut = new_dom_element
                parentNode: @icon_scene
                nodeName  : "img"
                src       : "img/cut.png"
                alt       : "cut"
                title     : "Cut"
                onclick: ( evt ) =>
                    @cut()
                    
        @icon_copy = new_dom_element
                parentNode: @icon_scene
                nodeName  : "img"
                src       : "img/copy.png"
                alt       : "copy"
                title     : "Copy"
                onclick: ( evt ) =>
                    @copy()
                    
        @icon_paste = new_dom_element
                parentNode: @icon_scene
                nodeName  : "img"
                src       : "img/paste.png"
                alt       : "paste"
                title     : "Paste"
                onclick: ( evt ) =>
                    @paste()

        @icon_del_folder = new_dom_element
                parentNode: @icon_scene
                nodeName  : "img"
                src       : "img/trash.png"
                alt       : "Delete"
                title     : "Delete"
                onclick: ( evt ) =>
                    @delete_file()           
                ondragover: ( evt ) =>
                    return false
                ondrop: ( evt ) =>
                    @delete_file()
                    evt.stopPropagation()
                    return false

        @breadcrumb_dom = new_dom_element
                parentNode: @container                
                nodeName  : "div"
                    
        @all_file_container = new_dom_element
                parentNode: @container                
                nodeName  : "div"

        @refresh()
        
        key_map = {
            8 : ( evt ) => # backspace
                @load_model_from_breadcrumb @breadcrumb.length - 2
                        
#             13 : ( evt ) => # enter
                
            37 : ( evt ) => # left
                if @selected_file.length > 0
                    if evt.shiftKey
                        # TODO shift selected need to use a reference file and not push the next or previous file ( this is to prevent multiple occurence of file when shift leftand then shift+right etc)
                        index_last_file_selected = @selected_file[ @selected_file.length - 1 ]
                        if index_last_file_selected > 0
                            @selected_file.push index_last_file_selected - 1
                            
                    else
                        ind = @selected_file[ @selected_file.length - 1 ]
                        if ind != 0
                            @selected_file = []
                            @selected_file.push ind - 1
                        else
                            @selected_file = []
                            @selected_file.push 0
                
                # case no file is selected
                else
                    @selected_file.push 0 
                @draw_selected_file()
                
#             38 : ( evt ) => # up
                
            39 : ( evt ) => # right
                if @selected_file.length > 0
                    if evt.shiftKey
                        index_last_file_selected = @selected_file[ @selected_file.length - 1 ]
                        if index_last_file_selected < @model.data.children.length - 1
                            @selected_file.push index_last_file_selected + 1
                            
                    else
                        ind = @selected_file[ @selected_file.length - 1 ]
                        if ind < @model.data.children.length - 1
                            @selected_file = []
                            @selected_file.push ind + 1
                        else
                            @selected_file = []
                            @selected_file.push @model.data.children.length - 1
                
                # case no file is selected
                else
                    @selected_file.push 0 
                    
                @draw_selected_file()
                
#             40 : ( evt ) => # down
                
            65 : ( evt ) => # A
                if evt.ctrlKey # select all
                    @selected_file = []
                    for child, i in @model.data.children
                        @selected_file.push i
                    @draw_selected_file()
                    
            88 : ( evt ) => # X
                if evt.ctrlKey # cut
                    @cut()
                
            67 : ( evt ) => # C
                if evt.ctrlKey # copy
                    @copy()
                
            86 : ( evt ) => # V
                if evt.ctrlKey # paste
                    @paste()
                
            46 : ( evt ) => # suppr
                @delete_file()
                
            116 : ( evt ) => # F5
                @refresh()
        }

        document.onkeydown = ( evt ) =>
            if @allow_shortkey == true
                if key_map[ evt.keyCode ]?
                    evt.stopPropagation()
                    evt.preventDefault()
                    key_map[ evt.keyCode ]( evt )
                    return true

    refresh: ->
        @empty_window()
        @init()

    cut: ->
        if @selected_file.length > 0
            @clipboard = []
            for ind_children in @selected_file
                real_ind = @search_ord_index_from_id ind_children
                @clipboard.push @model.data.children[ real_ind ]
            @cutroot = @model
            
    copy: ->
        if @selected_file.length > 0
            @clipboard = []
            for ind_children in @selected_file
                real_ind = @search_ord_index_from_id ind_children
                @clipboard.push @model.data.children[ real_ind ]
            @cutroot = undefined
            
    paste: ->
        if @cutroot?
            for mod in @clipboard
                pos = @cutroot.data.children.indexOf mod
                if pos != -1
                    @cutroot.data.children.splice pos, 1
        for file in @clipboard
            @model.data.children.push file
        @refresh()
        
        
    rename_file: ( file, child_index ) ->
        # start rename file
        @allow_shortkey = false
        file.contentEditable = "true"
        # stop rename file
        file.onblur = ( evt ) =>
            @allow_shortkey = true
            title = file.innerHTML
            child_index.name.set title
            file.contentEditable = "false"
    
    empty_window: ->
        @all_file_container.innerHTML = ""
        @selected_file = []
    
    load_folder: ( children ) =>
        # watching children
        @model = children
        @breadcrumb.push @model
        
        @refresh()

        
    draw_breadcrumb: ->
        @breadcrumb_dom.innerHTML = ""
        for folder, i in @breadcrumb
            do ( i ) =>
                if i == 0
                    f = new_dom_element
                        parentNode: @breadcrumb_dom
                        nodeName  : "span"
                        className : "breadcrumb"
                        txt       : "Root"
                        onclick   : ( evt ) =>
                            @load_model_from_breadcrumb 0
                        
                else
                    l = new_dom_element
                        parentNode: @breadcrumb_dom
                        nodeName  : "span"
                        txt       : " > "
                        
                    f = new_dom_element
                        parentNode: @breadcrumb_dom
                        nodeName  : "span"
                        className : "breadcrumb"
                        txt       : folder.name.get()
                        onclick   : ( evt ) =>
                            @load_model_from_breadcrumb i

            
    load_model_from_breadcrumb: ( ind ) =>
        if ind != -1
            @delete_breadcrumb_from_index ind
            @model = @breadcrumb[ ind ]
            @refresh()
        
    delete_breadcrumb_from_index: ( index ) ->
        for i in [ @breadcrumb.length-1 ... index ]
            @breadcrumb.pop()
    
    search_ord_index_from_id: ( id ) ->
        sorted = @model.data.children.sorted sort_dir
        for i in @model.data.children
            pos = @model.data.children.indexOf sorted[ id ]
            if pos != -1
                return pos
        
    
    delete_file: ->
        if @selected_file.length
            index_array = []
            for i in @selected_file
                index = @search_ord_index_from_id i
                index_array.push index
                
            for i in [ index_array.length - 1 .. 0 ]
                @model.data.children.splice( index_array[ i ] , 1)
                
            @selected_file = []
            @refresh()
            
    draw_selected_file: ->
        file_contain = document.getElementsByClassName 'file_container'
        for file, j in file_contain
            if parseInt(@selected_file.indexOf j) != -1
                add_class file, 'selected_file'
            else
                rem_class file, 'selected_file'

    sort_dir = ( a, b ) -> 
        c = 0
        d = 0
        if b.data instanceof Directory
            c = 1
        if a.data instanceof Directory
            d = 1
        if d - c != 0
            return 1
        else if a.name.get().toLowerCase() > b.name.get().toLowerCase() then 1 else -1
    
    init: ->
        console.log @model.data.children.sorted
        sorted = @model.data.children.sorted sort_dir
        console.log sorted
#         if @breadcrumb.length > 1
#             parent = new File Directory, ".."
#             sorted.unshift parent
            
        for elem, i in sorted
            do ( elem, i ) =>
            
                file_container = new_dom_element
                    parentNode: @all_file_container
                    nodeName  : "div"
                    className : "file_container"
                    
                    ondragstart: ( evt ) =>
                        @popup_closer_zindex = document.getElementById('popup_closer').style.zIndex
                        document.getElementById('popup_closer').style.zIndex = -1
                        
                        @drag_source = []
                        @drag_source = @selected_file.slice 0
                        if parseInt(@selected_file.indexOf i) == -1
                            @drag_source.push i
                        
                        evt.dataTransfer.effectAllowed = if evt.ctrlKey then "copy" else "move"
                        
                    ondragover: ( evt ) =>
                        return false
                        
                    ondragend: ( evt ) =>
                        document.getElementById('popup_closer').style.zIndex = @popup_closer_zindex
                    
                    ondrop: ( evt ) =>
                        # drop file got index = i
                        console.log evt
                        #TODO décalage du au parent, la fonction search_ord_index_from_id ne semble pas très adaptée
                        if sorted[ i ].data instanceof Directory
                            console.log @drag_source
                            console.log @breadcrumb[ @breadcrumb.length - 2 ]
                            if sorted[ i ].name == ".."
#                                 @breadcrumb[ @breadcrumb.length - 2 ].data.children.push sorted[ ind ]
                            else
                                # add selected children to target directory
                                index = @search_ord_index_from_id i
                                for ind in @drag_source
                                    @model.data.children[ index ].data.children.push sorted[ ind ]
                                
                            # remove selected children from current directory
                            for sorted_ind in @drag_source
                                index = @search_ord_index_from_id sorted_ind
                                @model.data.children.splice index, 1
    
                            @selected_file = []
                            @refresh()
                        
                        console.log "stop"
                        evt.stopPropagation()
                        return false
                        
                    onmousedown : ( evt ) =>
                        if evt.ctrlKey
                            ind = parseInt(@selected_file.indexOf i)
                            if ind != -1
                                @selected_file.splice ind, 1
                            else
                                @selected_file.push i
                                
                        else if evt.shiftKey
                            if @selected_file.length == 0
                                @selected_file.push i
                            else
                                index_last_file_selected = @selected_file[ @selected_file.length - 1 ]
                                @selected_file = []
                                for j in [ index_last_file_selected .. i ]
                                    @selected_file.push j
                                
                        else
                            @selected_file = []
                            @selected_file.push i
                        
                        @draw_selected_file()
                
                if elem.data instanceof ImgItem
                    @picture = new_dom_element
                        parentNode: file_container
                        className : "picture"
                        nodeName  : "img"
                        src       : elem.data._name
                        alt       : ""
                        title     : elem.data._name
                        ondblclick: ( evt ) =>
                            @fundblclick evt, sorted[ i ]
                            
                    text = new_dom_element
                        parentNode: file_container
                        className : "linkDirectory"
                        nodeName  : "div"
                        txt       : elem.name
                        onclick: ( evt ) =>
                            @rename_file text, sorted[ i ]
                
                else if elem.data instanceof Mesh
                    @picture = new_dom_element
                        parentNode: file_container
                        nodeName  : "img"
                        src       : "img/unknown.png"
                        alt       : ""
                        title     : ""
                        ondblclick: ( evt ) =>
                            @fundblclick evt, sorted[ i ]
                            
                    text = new_dom_element
                        parentNode: file_container
                        className : "linkDirectory"
                        nodeName  : "div"
                        txt       : elem.name
                        onclick: ( evt ) =>
                            @rename_file text, sorted[ i ]
                            
                else if elem.data instanceof Directory
                    @picture = new_dom_element
                        parentNode: file_container
                        nodeName  : "img"
                        src       : "img/orange_folder.png"
                        alt       : elem.name
                        title     : elem.name
                        ondblclick: ( evt ) =>
                            if sorted[ i ].name.get() == ".."
                                @load_model_from_breadcrumb @breadcrumb.length - 2
                            else
                                @load_folder sorted[ i ]
                        
                    text = new_dom_element
                        parentNode: file_container
                        className : "linkDirectory"
                        nodeName  : "div"
                        txt       : elem.name
                        onclick: ( evt ) =>
                            @rename_file text, sorted[ i ]
                            
                else
                    @picture = new_dom_element
                        parentNode: file_container
                        nodeName  : "img"
                        src       : "img/unknown.png"
                        alt       : ""
                        title     : "" 
                        
                    text = new_dom_element
                        parentNode: file_container
                        className : "text"
                        nodeName  : "div"
                        txt       : elem.name
                        onclick: ( evt ) =>
                            @rename_file text, sorted[ i ]
                
        @draw_breadcrumb()
        

ModelEditor.default_types.push ( model ) -> ModelEditorItem_Directory if model instanceof Directory