# lib ../Soja/Soja.js
# lib ../Soja/ModelEditor.js
# lib ../Soja/CodeEditor.js
# lib ../CodeMirror-2.22/lib/codemirror.js
# lib ../CodeMirror-2.22/mode/xml/xml.js
# lib ../CodeMirror-2.22/lib/util/dialog.js
# lib ../CodeMirror-2.22/mode/javascript/javascript.js
# lib ../CodeMirror-2.22/lib/util/searchcursor.js
# lib ../CodeMirror-2.22/lib/util/search.js
# lib ../CodeMirror-2.22/lib/util/match-highlighter.js
# lib ../Soja/DomHelper.js

# lib ../CodeMirror-2.22/lib/codemirror.css
# lib ../CodeMirror-2.22/lib/util/dialog.css
# lib ../Soja/ModelEditor.css
# lib ../Soja/CodeEditor.css




test_ScriptEditor = ->
    
    # model
    model = new Model
        text_editor: new StrLanguage("
Class Steel\n
    Poisson := 0.28\n
    Young := 210\n", "javascript", @parse_code_onchange)
    

    
    body = new_dom_element
        parentNode: document.body
        
    editor = new_model_editor el: body, model: model, item_width: 60
    
    lst_variables = new Lst
    old_lst_variables = new Lst
    lst_variables_value = new Lst
#     parse_code_onchange()
    console.log this

        
    parse_code_onchange: ->
        # first delete all variables from textarea
        for attr in lst_variables
            rem_attr attr.get() # focus seems to be loose when deleting
        lst_variables.clear()
        
        # then search all variables of type string := value
        reg = /(\w+?) *:= *([0-9\.]+)/g # option g select all occurrence
        i = 0
        while reg.exec @code.get()
            if i > 1000
                console.error 'Too much variables'
                break
            console.log 'variable ',  RegExp.$1 ,' found, value :', RegExp.$2
            variable = RegExp.$1
            variable_value = parseFloat RegExp.$2
            # add found variable as attributes
            if not @[ variable ]?                                 # if variable doesn't exist
                @add_attr variable, [ variable_value, false ]
                @lst_variables.push variable
            else # never call
                @set_attr @[ variable ], variable_value
                
            i++