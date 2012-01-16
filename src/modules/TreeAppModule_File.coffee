#
class TreeAppModule_File extends TreeAppModule
    constructor: ->
        super()
        
        @name = 'File'
        
        @actions.push
            ico: "img/add_folder.png"
            siz: 2
            txt: "Open"
            fun: ( evt, app ) ->
                @model = new File Directory, "LMT"
                
                p = new File ImgItem, "composite01.png"
                d = new File Directory, "Work"
                m = new File Mesh, "Mesh"
                
                @model.data.children.push m
                @model.data.children.push p
                @model.data.children.push d
                
                
                mesh = new File Directory, "Mesh"
                pictures = new File Directory, "Pictures"
                result = new File Directory, "Result"
                d.data.children.push mesh
                d.data.children.push pictures
                d.data.children.push result
                
                
                pic5 = new File ImgItem, "composite05.png"
                pic7 = new File ImgItem, "composite07.png"
                pictures.data.children.push pic5
                pictures.data.children.push pic7
                
                mes1 = new File Mesh, "Mesh"
                mesh.data.children.push mes1
                
                res = new File
                result.data.children.push res
                
                @d = new_dom_element
                    className : "browse_container"
                @item_cp = new ModelEditorItem_Directory
                    el    : @d
                    model : @model
                    fundblclick: ( evt, file ) =>
                        if file.data instanceof ImgItem
                            @modules = app.data.modules
                            for m in @modules
                                if m instanceof TreeAppModule_ImageSet
                                    m.actions[ 1 ].fun evt, app, file.data
                                
                        else if file.data instanceof Mesh
                            @modules = app.data.modules
                            for m in @modules 
                                if m instanceof TreeAppModule_Sketch
                                    m.actions[ 0 ].fun evt, app, file.data
                        
                p = new_popup "Browse Folder", event : evt, width : 70
                p.appendChild @d
            key: [ "Shift+O" ]
            