execfile( "Soja/bin/concat_js.py" )

# main lib
concat_js( "src", "html/gen/CorreliOnline.js", "html/gen/CorreliOnline.css" )

# ext tools
for plugins_dir in [ "plugins" ]:
    for p in os.listdir( plugins_dir ):
        concat_js( plugins_dir + "/" + p, "html/gen/" + p + ".js", "html/gen/" + p + ".css" )
