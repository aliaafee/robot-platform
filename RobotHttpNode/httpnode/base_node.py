import json
from http import server
from urllib.parse import urlparse, parse_qs

from node_server import start_server


class BaseNodeHandler(server.BaseHTTPRequestHandler):
    def send_text(self, text):
        content = text.encode('utf-8')
        self.send_response(200)
        self.send_header('Content-Type', 'text/html')
        self.send_header('Content-Length', len(content))
        self.end_headers()
        self.wfile.write(content)

    def send_json(self, dictionary):
        content = json.dumps(dictionary).encode('utf-8')
        self.send_response(200)
        self.send_header('Content-Type', 'text/json')
        self.send_header('Content-Length', len(content))
        self.end_headers()
        self.wfile.write(content)

    def send_status_json(self, status):
        self.send_json(
            {
                'status': status
            }
        )

    def send_error_json(self, message):
        self.send_json(
            {
                'error': message
            }
        )

    def send_redirect(self, redirect_to):
        self.send_response(301)
        self.send_header('Location', redirect_to)
        self.end_headers()

    def send_notfound(self):
        self.send_error(404)
        self.end_headers()

    def do_GET(self):
        self.handle_GET(urlparse(self.path))

    def handle_GET(self, parsed_url):
        self.send_text("Base Node")


class BaseNode:
    def start(self, address):
        start_server(address, BaseNodeHandler)
