namespace Solution {
    open Microsoft.Quantum.Primitive;
    open Microsoft.Quantum.Canon;
    // Circuit: https://algassert.com/quirk#circuit={%22cols%22:[[%22Counting5%22],[%22Chance%22,%22Chance%22,%22Chance%22,%22Chance%22,%22Chance%22],[1,1,1,1,1,%22%E2%80%A6%22],[%22%E2%97%A6%22,%22%E2%97%A6%22,%22%E2%97%A6%22,%22%E2%97%A6%22,%22%E2%97%A6%22,%22X%22],[%22%E2%80%A2%22,%22%E2%80%A2%22,%22%E2%80%A2%22,1,1,%22X%22],[%22%E2%80%A2%22,%22%E2%80%A2%22,1,%22%E2%80%A2%22,1,%22X%22],[%22%E2%80%A2%22,%22%E2%80%A2%22,1,1,%22%E2%80%A2%22,%22X%22],[%22%E2%80%A2%22,1,%22%E2%80%A2%22,%22%E2%80%A2%22,1,%22X%22],[%22%E2%80%A2%22,1,%22%E2%80%A2%22,1,%22%E2%80%A2%22,%22X%22],[%22%E2%80%A2%22,1,1,%22%E2%80%A2%22,%22%E2%80%A2%22,%22X%22],[1,%22%E2%80%A2%22,%22%E2%80%A2%22,%22%E2%80%A2%22,1,%22X%22],[1,%22%E2%80%A2%22,%22%E2%80%A2%22,1,%22%E2%80%A2%22,%22X%22],[1,%22%E2%80%A2%22,1,%22%E2%80%A2%22,%22%E2%80%A2%22,%22X%22],[1,1,%22%E2%80%A2%22,%22%E2%80%A2%22,%22%E2%80%A2%22,%22X%22]]}
    // TODO: dont have 6 nested for loops... can just loop over the gaps

    operation Solve_C3 (x : Qubit[], y : Qubit) : Unit {
        body (...) {
            let N = Length(x);
            // Check for Zero
            (ControlledOnInt(0, X))(x, y);
            // Check for three ones
            for (i in 0 .. N - 3) {
                for (j in i + 1 .. N - 2) {
                    for (k in j + 1 .. N - 1) {
                        Controlled X([x[i], x[j], x[k]], y);
                    }
                }
            }
            // Check for six ones
            for (i in 0 .. N - 6) {
                for (j in i + 1 .. N - 5) {
                    for (k in j + 1 .. N - 4) {
                        for (l in k + 1 .. N - 3) {
                            for (m in l + 1 .. N - 2) {
                                for (n in m + 1 .. N - 1) {
                                    Controlled X([x[i], x[j], x[k], x[l], x[m], x[n]], y);
                                }
                            }
                        }
                    }
                }
            }
            // Check for nine ones
            if (N == 9) {
                (ControlledOnInt(2^N-1, X))(x, y);
            }
        }
        adjoint auto;
    }
}