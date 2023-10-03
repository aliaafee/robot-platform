import sys
import os.path
import importlib.util

from nodes_list import nodes

MODULE_DIR = os.path.join(
    os.path.realpath(os.path.dirname(__file__))
)


def usage():
    print("httpnode <node_name>")
    print(f"    available nodes: {',' .join(nodes.keys())}")


def load_node_class(node_module_path, node_class_name):
    spec = importlib.util.spec_from_file_location(
        'node_module', node_module_path)
    node_module = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(node_module)

    return getattr(node_module, node_class_name)


def main():
    try:
        node_name = sys.argv[1]
    except IndexError:
        usage()
        return

    if not node_name in nodes:
        usage()
        return

    print(f"Starting {node_name} node")

    port, node_module_path, node_class_name = nodes[node_name]

    node_class = load_node_class(os.path.join(
        MODULE_DIR, node_module_path), node_class_name)

    node = node_class()
    node.start(('', port))


if __name__ == '__main__':
    main()
