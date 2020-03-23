import numpy as np

def barrel(l):
    container = [0] * 11
    for i in l:
        container[i] += 1
    result = [[i] * count for i, count in enumerate(container) if count > 0]
    result = [v for sub in result for v in sub]
    return result[::-1]

def barrel(l):
    book = dict()
    res = []
    for i in l:
        book[i] = book.get(i, 0) + 1
    for i in range(max(l), 0, -1):
        if book.get(i, 0) > 0:
            for j in range(book[i]):
                res.append(i)
    return res

if __name__ == '__main__':
    print(barrel([5, 3, 5, 2, 8]))
