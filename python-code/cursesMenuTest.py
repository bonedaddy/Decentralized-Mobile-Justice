import cursesmenu as cw


menu = cw.CursesMenu('this is a menu', 'this is a title')
command_item = cm.CommandItem("Run a console cmmand", "echo hey")
function_item = cm.FunctionItem("Call a fucking", input, ['enter some input'])
