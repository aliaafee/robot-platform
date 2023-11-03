import os.path
import subprocess
import signal
from urllib.parse import urlparse, parse_qs

from node_server import start_server
from base_node import BaseNodeHandler, BaseNode

from nodes_list import nodes

HOSTNAME = "robotpi.local"

PAGE = """\
<!DOCTYPE html>
<html>
<head>
    <title>Robotpi</title>
    <script>
        async function startNode(name) {
            const response = await fetch('/start?node=' + name);
            const result = await response.json();
            console.log(result);
            updateStatus();
        }
        async function stopNode(name) {
            const response = await fetch('/stop?node=' + name);
            const result = await response.json();
            console.log(result);
            updateStatus();
        }
        async function updateStatus() {
            const response = await fetch('/status');
            const result = await response.json();
            for (let node_name in result) {
                const status = result[node_name];
                const el = document.getElementById(node_name + "_status");
                el.innerText = status;

                const url_el = document.getElementById(node_name + "_url");
                if (status == 'running') {
                    url_el.style.display = '';
                } else {
                    url_el.style.display = 'none';
                }
            }
        }
        setInterval(updateStatus, 3000)
    </script>
</head>
<body>
    <h1>Nodes</h1>
    <ul>{node_list}</ul>
</body>
</html>
"""

MODULE_DIR = os.path.join(
    os.path.realpath(os.path.dirname(__file__))
)

available_nodes = nodes
available_nodes.pop('governer')

active_nodes = {}


def node_has_started(node_name):
    if node_name not in active_nodes:
        return False
    return True


def start_node(node_name):
    if node_name not in available_nodes:
        return

    if node_has_started(node_name):
        return

    process = subprocess.Popen(["python", MODULE_DIR, node_name])

    active_nodes[node_name] = process


def stop_node(node_name):
    if not node_has_started(node_name):
        return

    active_nodes[node_name].send_signal(signal.SIGINT)
    active_nodes.pop(node_name)


class GovernerNodeHandler(BaseNodeHandler):
    def get_node_name(self, query):
        q = parse_qs(query)

        if 'node' not in q:
            return None

        return q['node'][0]

    def handle_start(self, url):
        node_name = self.get_node_name(url.query)

        if node_name not in available_nodes:
            self.send_error_json("Node name not valid")
            return

        if node_has_started(node_name):
            self.send_error_json("Node already started")
            return

        start_node(node_name)

        self.send_status_json(f"{node_name} node started")

    def handle_stop(self, url):
        node_name = self.get_node_name(url.query)

        if not node_has_started(node_name):
            self.send_error_json("Node has not started")
            return

        stop_node(node_name)

        self.send_status_json("Node stoped")

    def handle_list(self, url):
        node_list = ' '.join(
            [f"<li><span>{node_name}</span> <button onClick=\"startNode('{node_name}')\">start</button> <button onClick=\"stopNode('{node_name}')\">stop</button> <status id=\"{node_name}_status\"></status> <a id=\"{node_name}_url\" href=\"http://{HOSTNAME}:{port}/\" style=\"display: none;\" target=\"_blank\">open</a></li>" for node_name, (port,_,_) in available_nodes.items()])
        self.send_text(PAGE.replace("{node_list}", node_list))

    def handle_status(self, url):
        result = {}
        for node_name in available_nodes:
            if node_name in active_nodes:
                status = active_nodes[node_name].poll()
                if status is None:
                    result[node_name] = "running"
                else:
                    if status:
                        result[node_name] = "failed"
                    else:
                        result[node_name] = "closed"
            else:
                result[node_name] = ""
        self.send_json(result)

    def handle_GET(self, url):
        if url.path == "/":
            self.handle_list(url)
        elif url.path == "/start":
            self.handle_start(url)
        elif url.path == "/stop":
            self.handle_stop(url)
        elif url.path == "/status":
            self.handle_status(url)
        else:
            self.send_notfound()


class GovernerNode(BaseNode):
    def start(self, address):
        start_server(address, GovernerNodeHandler)
