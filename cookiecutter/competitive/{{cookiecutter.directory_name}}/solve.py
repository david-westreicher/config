"""
Experimentation:

"""
import sys

# from itertools import accumulate
# from collections import defaultdict

input = sys.stdin.readline


def solve():
    (N,) = [int(e) for e in input().split()]
    arr = [int(e) for e in input().split()]


T = int(input())
for t in range(T):
    s = solve()
    print(s)
    # print(f"Case #{t+1}: {s}")
