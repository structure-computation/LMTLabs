class TreeAppModule_Photo extends TreeAppModule
    # ...hum...
    @s = new Synchronizer()
    @app = undefined
    
    constructor: ->
        super()

        @name = 'Device'
        

        @actions.push
            ico: "img/camera-photo.png"
            txt: "Update cam devices"
            fun: ( evt, app ) =>
                TreeAppModule_Photo.app = app
                TreeAppModule_Photo.s.queue "update_cam_list TreeAppModule_Photo.update_cam_list\n"
                TreeAppModule_Photo.s.flush()
                

    @update_cam_list: ( lst ) ->
        # console.log lst
        for cam in lst
            # app.undo_manager.snapshot()
            m = new CameraItem TreeAppModule_Photo.app, TreeAppModule_Photo.s, cam.name, cam.port
            session = TreeAppModule_Photo.app.data.selected_session()
            session._children.push m

            for p in TreeAppModule_Photo.app.data.panel_id_list()
                TreeAppModule_Photo.app.data.visible_tree_items[ p ].push m
            