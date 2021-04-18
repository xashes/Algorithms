#!/usr/bin/env python3
from typing import Optional


def bin_search(n: int, lon: list[int]) -> Optional[int]:
    return search_in(n, lon, 0, len(lon) - 1)


def search_in(n: int, lon: list[int], low_idx: int, high_idx: int) -> Optional[int]:
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


def test_bin_search():
    assert bin_search(5, [1, 2, 5, 6, 7]) == 2
    assert bin_search(6, [1, 2, 3, 6, 6]) == 3
    assert bin_search(3, [1, 2, 5, 7, 8]) is None
