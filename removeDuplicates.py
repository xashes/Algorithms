#!/usr/bin/env python3
#
from typing import List

def removeDuplicates(nums: List[int]) -> int:
    if len(nums) <= 1:
        return len(nums)
    p = 0
    q = 1
    while q < len(nums):
        if nums[p] < nums[q]:
            p += 1
            nums[p] = nums[q]
        q += 1
    return p + 1

def test_removeDuplicates():
    lst = [1, 2, 2, 3, 3, 4, 5, 5]
    assert removeDuplicates(lst) == 5
    assert lst[:5] == [1, 2, 3, 4, 5]
