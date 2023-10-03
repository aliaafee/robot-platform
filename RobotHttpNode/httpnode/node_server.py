import io
import logging
import socketserver
from threading import Condition
from http import server


class NodeServer(socketserver.ThreadingMixIn, server.HTTPServer):
    allow_reuse_address = True
    daemon_threads = True


def start_server(address, node_handler):
    try:
        server = NodeServer(address, node_handler)
        ip_addr, port = server.server_address
        print(f"Serving on http://{ip_addr}:{port}/")
        server.serve_forever()
    except KeyboardInterrupt:
        print("Closing node")
        pass
    finally:
        pass
