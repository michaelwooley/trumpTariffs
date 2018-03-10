#!/usr/bin/env python

from livereload import Server, shell
server = Server()

server.watch('./html/index.html', 'echo "UPDATING HTML"')
server.watch('js')
server.serve(root='html', open_url_delay=1, debug=False)

print(shell('PWD'))