import sys


def b(x, n=0):
    return bin(x)[2:].zfill(n)

def is_periodic(s):
    N = len(s)
    periodic = True
    for p in range(1, N):
        periodic = True
        for i in range(N - p):
            m = 1
            while i + p*m < N:
                if s[i] != s[i + p*m]:
                    periodic = False
                    break
                m += 1
            if not periodic:
                break
        if periodic:
            return True
    return False

if __name__ == "__main__":
    N = int(sys.argv[1])
    num_periodic = 0
    for i in range(2**N):
        if is_periodic(b(i, N)):
            num_periodic += 1
            print(f'{i} - {b(i, N)}: {is_periodic(b(i, N))}')
    print(f'Total: {num_periodic}')
#    print(f'Periodic: {num_periodic}, Not: {2**N - num_periodic}')

