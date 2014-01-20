#
class Browse extends Model
    constructor: () ->
        super()
        
        @add_attr
            path: new Str
            
    _set: ( path ) ->
        @path.set path