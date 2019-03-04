import sys
from random import randint


if __name__ == "__main__":
    N = int(sys.argv[1])
    num = 4
    if len(sys.argv) > 2:
        num = int(sys.argv[2])
    strings = []
    while len(strings) < num:
        x = randint(0, 2**N - 1)
        s = bin(x)[2:].zfill(N)
        if s not in strings:
            strings.append(s)
    print(strings)
