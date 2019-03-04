import sys

if __name__ == "__main__":
    N = int(sys.argv[1])
    x = -2
    for i in range(2**N):
        for j in range(2**N):
            if j > x:
                print('x', end=' ')
            else:
                print('0', end=' ')
        x += 1
        print()
