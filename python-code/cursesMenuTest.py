import cursesmenu as cw


menu = cw.CursesMenu('this is a menu', 'this is a title')
command_item = cm.CommandItem("Run a console cmmand", "echo hey")
function_item = cm.FunctionItem("Call a fucking", input, ['enter some input'])




submenu = cm.CursesMenu("This is a sub menu")
submenu_item = cm.SubmenuItem("This is a sub menu, submenu, menu=menu")


menu.append_item(command_item)

menu.append_item(function_item)

menu.append_item(submenu_item)


menu.start()