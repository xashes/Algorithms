#!/usr/bin/env python3
from typing import Optional, List


def bin_search(n: int, lon: List[int]) -> Optional[int]:
    return search_in(n, lon, 0, len(lon) - 1)


def search_in(n: int, lon: List[int], low_idx: int, high_idx: int) -> Optional[int]:
    if low_idx > high_idx:
        return
    else:
        m_idx = (low_idx + high_idx) // 2
        value = lon[m_idx]
        if n == value:
            return m_idx
        elif n > value:
            low_idx = m_idx + 1
            return search_in(n, lon, low_idx, high_idx)
        else:
            high_idx = m_idx - 1
            return search_in(n, lon, low_idx, high_idx)

def bin_search_iter(n: int, lon: List[int]) -> Optional[int]:
    low_idx = 0
    high_idx = len(lon) - 1
    while low_idx <= high_idx:
        mid_idx = (low_idx + high_idx) // 2
        value = lon[mid_idx]
        if value == n:
            return mid_idx
        elif value < n:
            low_idx += 1
        else:
            high_idx -= 1


def test_bin_search():
    assert bin_search(5, [1, 2, 5, 6, 7]) == 2
    assert bin_search(6, [1, 2, 3, 6, 6]) == 3
    assert bin_search(3, [1, 2, 5, 7, 8]) is None

def test_bin_search_iter():
    assert bin_search_iter(5, [1, 2, 5, 6, 7]) == 2
    assert bin_search_iter(6, [1, 2, 3, 6, 6]) == 3
    assert bin_search_iter(3, [1, 2, 5, 7, 8]) is None