# API
# push
# pop
# is_empty
# size

class FixedCapacityStack:
    def __init__(self, cap) -> None:
        self.stack = [0] * cap
        self.size = 0

    def is_empty(self):
        return self.size == 0

    def push(self, n):
        self.stack[self.size] = n
        self.size += 1

    def pop(self):
        self.size -= 1
        return self.stack[self.size]

if __name__ == '__main__':
    s = FixedCapacityStack(6)
    for i in range(3):
        s.push(i)
        print(s.stack)

    while not s.is_empty():
        print(s.pop())