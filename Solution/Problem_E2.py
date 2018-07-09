def f(x, b, N=4):
    return (N - bin(x).count('1') - bin(b).count('1')) % 2


for N in range(1, 7):
    print('N: {}'.format(N))
    for b in range(2**N):
        print(f'{b: 06b} | {"".join([str(f(x, b, N)) for x in range(2**N)])}')

    print('\n')
