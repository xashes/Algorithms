#!/usr/bin/env python3
from typing import List

def sum_rec(lon: List[float]) -> float:
    if len(lon) == 0:
        return 0
    else:
        return lon[0] + sum_rec(lon[1:])

def test_sum_rec():
    assert sum_rec([1, 2, 3]) == 6
    assert sum_rec([]) == 0
