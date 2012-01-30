execfile( "Soja/bin/concat_js.py" )

# main lib
concat_js( "src", "gen/CorreliOnline.js", "gen/CorreliOnline.css" )

# ext tools
for plugins_dir in [ "plugins" ]:
    for p in os.listdir( plugins_dir ):
        concat_js( plugins_dir + "/" + p, "gen/" + p + ".js", "gen/" + p + ".css" )
