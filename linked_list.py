class Node:
    def __init__(self, value=None, next=None) -> None:
        self.value = value
        self.next = next

    def __iter__(self):
        return []

    def __repr__(self) -> str:
        class_name = type(self).__name__
        return f'[{self.value} {self.next}]'


def cons(value, node: Node) -> Node:
    return Node(value, node)

def car(node: Node):
    return node.value

def iter_node(node):
    if node.next == None:
        print(node.value)
    else:
        return iter_node(node.next)

if __name__ == '__main__':
    first = Node('to')
    second = Node('be')
    first.next = second
    third = Node('or')
    second.next = third
    print(first)
    new_first = Node('first')
    new_first.next = first
    print(new_first)
    print(iter_node(first))
