# Copyright 2012 Structure Computation  www.structure-computation.com
# Copyright 2012 Hugo Leclerc
#
# This file is part of Soda.
#
# Soda is free software: you can redistribute it and/or modify
# it under the terms of the GNU Lesser General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# Soda is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Lesser General Public License for more details.
# You should have received a copy of the GNU General Public License
# along with Soda. If not, see <http://www.gnu.org/licenses/>.



#
class Function extends Model
    constructor: (  ) ->
        super()
        
        @add_attr
            _f_t          : "t"
            _tmin         : 0
            _tmax         : 10
            _nb_values    : 10
            _v1           : new Vec
            _v2           : new Vec
            _mesh         : new Mesh( not_editable: true )

        onload = =>
            @_signal_change()
            if @_v2.length == 0
                @fill_v1_v2()
        
        @bind =>
            if  @_f_t.has_been_modified() or @_tmin.has_been_modified() or @_tmax.has_been_modified() or @_nb_values.has_been_modified()
                @make_mesh()
  
    
    fill_v1_v2: () ->
        @_v1.clear()
        @_v2.clear()
        #alert @_f_t + " " + @_tmin + " " + @_tmax + " " + @_nb_values
        
        for i in [ 0 ... @_nb_values.get() ]
            @_v1.push 0
            @_v2.push 0
            @_v1[ i ].set (@_tmin.get() + i * (@_tmax.get() - @_tmin.get())/(@_nb_values.get()-1))
         
        #alert @_v1
        for i in [ 0 ... @_nb_values.get() ]
            t = @_v1[ i ]
            str = "t=" + t + "; val_t = " + @_f_t + ";"
            #alert str
            val_f = eval(str)
            #alert val_f
            #alert val_t
            @_v2[ i ].set val_t
            
        #alert @_v2
                
    make_mesh: ()->
        @fill_v1_v2()
        @_mesh.points.clear()
        @_mesh._elements.clear()
        
        for i in [ 0 ... @_nb_values.get() ]
            @_mesh.add_point [ @_v1[ i ], @_v2[ i ], 0 ]
        
        for i in [ 0 ... (@_nb_values.get()-1) ]
            liste = [i, i+1]
            bar = new Element_Line(liste)
            @_mesh.add_element bar
            
                
    information: ( div ) ->
        if not @cm?
            #alert "test 3"
            @txt = new_dom_element
                parentNode: div
                
            d = new_dom_element
                parentNode: div
                #style     : { position: "absolute", top: 0, left: 0, width: "70%", bottom: 0 }

            #             bg = new Background
            # #             bg.gradient.remove_color 1
            #             bg.gradient.remove_color 0
            @fill_v1_v2()
            m = new Graph marker: 'bar', show_line: false, shadow: false, marker_size: 2, font_size: 10
            for i in [ 0 ... @_nb_values.get() ]
                m.points.push [ @_v1[ i ], @_v2[ i ], 0 ]
            m.build_w2b_legend()
            
            @cm = new CanvasManager el: d, want_aspect_ratio: true, padding_ratio: 1.4, constrain_zoom: 'x', width: '', class_name: 'histogramm'
            @cm.cam.threeD.set false
            
            # @cm.items.push bg
            @cm.items.push m
            @cm.fit()
            
        @cm.draw()
