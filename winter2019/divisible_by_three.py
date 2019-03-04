import sys


def b(x, N):
    return bin(x)[2:].zfill(N)

def no_ones(b):
    return b.count('1')

if __name__ == "__main__":
    N = int(sys.argv[1])
    count = 0
    for i in range(2**N):
        if no_ones(b(i, N)) % 3 == 0:
            count += 1
            print(f'{i}: {b(i, N)}')
    print(f'Total: {count} of {2**N}')
