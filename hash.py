#!/usr/bin/env python3

from typing import Any


class HashTable:
    def __init__(self, size: int = 100) -> None:
        self.table = [[]] * size
        self.size = size

    def add(self, item: str, value: Any):
        idx = hash_func(item)


def hash_func(s: str) -> int:
    return len(s)
