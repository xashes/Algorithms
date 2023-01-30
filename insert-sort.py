from typing import List, Optional
def insertion_sort(l: List[int]) -> List[int]:
    for i in range(1, len(l)):
        key = l[i]
        j = i - 1
        while j >= 0 and l[j] > key:
            l[j+1] = l[j]
            j -= 1
        l[j+1] = key
    return l

def test_insertion_sort():
    assert insertion_sort([4, 3, 2, 5, 1, 9]) == [1, 2, 3, 4, 5, 9]
    assert insertion_sort([4, 3, 2, 6, 1, 6]) == [1, 2, 3, 4, 6, 6]
    assert insertion_sort([]) == []
