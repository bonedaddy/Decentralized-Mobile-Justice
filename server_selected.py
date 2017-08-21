import os

server_list = []


if os.is_file('master_list.txt'):
    pass
else:
    # this is a default selection of server lists
    server_list = [ 'defaults' ]


    