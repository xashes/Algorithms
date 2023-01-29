import numpy as np
from typing import Optional, List

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

def select_sort(lon: List[float]) -> List[float]:
    sorted_list = []
    while len(lon) > 0: # O(n)
        minimal_number = minimal(lon) # O(n)
        sorted_list.append(minimal_number)
        lon.remove(minimal_number)
    return sorted_list

def test_select_sort():
    assert select_sort([2, 5, 3, 1, 7]) == [1, 2, 3, 5, 7]
    assert select_sort([2, 5, 3, 1, 7, 2]) == [1, 2, 2, 3, 5, 7]

def minimal(lon: List[float]) -> Optional[float]: # O(n)
    if len(lon) == 0:
        return None
    elif len(lon) == 1:
        return lon[0]
    else:
        if lon[0] < minimal(lon[1:]):
            return lon[0]
        else:
            return minimal(lon[1:])
    # minimal_number = None
    # for n in lon:
    #     if minimal_number is None or n < minimal_number:
    #         minimal_number = n

    # return minimal_number

def test_minimal():
    assert minimal([1, 2, 6, 5, 0]) == 0
    assert minimal([1, 2, 6, 5, 9]) == 1
    assert minimal([]) is None

def qsort(lon: List[float]) -> List[float]:
    if len(lon) <= 1:
        return lon
    else:
        return qsort([x for x in lon[1:] if x <= lon[0]]) + [lon[0]] + qsort([x for x in lon[1:] if x > lon[0]])

def test_qsort():
    l1 = [1, 3, 2, 6, 4, 3, 0]
    l2 = []
    assert qsort(l1) == sorted(l1)
    assert qsort(l2) == []

if __name__ == '__main__':
    print(barrel([5, 3, 5, 2, 8]))
    print(select_sort([1, 6, 4, 3, 6]))
