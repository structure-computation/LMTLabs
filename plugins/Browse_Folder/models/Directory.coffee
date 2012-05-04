# #
# class Directory extends File
#     constructor: () ->
#         super()
#         
#         
#         @add_attr
#             children: new Lst
#             
#     _set: ( path ) ->
#         @path.set path
#     
#     drop: ( evt, info ) ->
#         @handleFiles evt, info
#         
#         evt.returnValue = false
#         evt.stopPropagation()
#         evt.preventDefault()
#         return false
#         
#     handleFiles: (event, info, files) -> 
#         if typeof files == "undefined" #Drag and drop
#             event.stopPropagation()
#             event.returnValue = false
#             event.preventDefault()
#             files = event.dataTransfer.files
#             
#         if event.dataTransfer.files.length > 0
#             for file in files 
#                 format = file.type.indexOf "image"
#                 if format isnt -1
#                     pic = new ImgItem file.name
#                     accept_child = info.item.accept_child pic
#                     if accept_child == true
#                         info.item.add_child pic
# #                         info.item.img_collection.push pic
#                         
# #             @sendFiles()
# #         
# #     sendFiles: ->
# #         imgs = document.querySelectorAll ".obj"
# #         for img in imgs
# #             new FileUpload img, img.file
# # 
# #     FileUpload: (img, file) ->
# #         reader = new FileReader()
# #         this.ctrl = createThrobber(img)
# #         xhr = new XMLHttpRequest()
# #         this.xhr = xhr
# # 
# # #         self = this
# # #         xhr.upload.addEventListener("progress", (e) ->
# # #             if (e.lengthComputable)
# # #                     percentage = Math.round((e.loaded * 100) / e.total)
# # #                     self.ctrl.update(percentage)
# # #           , false)
# # # 
# # #         xhr.upload.addEventListener("load", (e) ->
# # #             self.ctrl.update(100)
# # #             canvas = self.ctrl.ctx.canvas
# # #             canvas.parentNode.removeChild(canvas)
# # #         , false)
# # #         #xhr.open("POST", "http://demos.hacks.mozilla.org/paul/demos/resources/webservices/devnull.php");
# # #         xhr.overrideMimeType('text/plain; charset=x-user-defined-binary')
# #         reader.onload = ( evt ) =>
# #             xhr.sendAsBinary evt.target.result
# #         
# #         reader.readAsBinaryString(file)
#     
# 
# TreeView.default_types.push ( evt, info ) -> 
#     d = new Directory
#     d.drop evt, info