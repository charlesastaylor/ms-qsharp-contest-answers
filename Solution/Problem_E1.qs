namespace Solution {
    open Microsoft.Quantum.Primitive;
    open Microsoft.Quantum.Canon;

    operation Solve_E1 (N : Int, Uf : ((Qubit[], Qubit) => ())) : Int[]
    {
        body
        {
            mutable b = new Int[N];
            using (qubits = Qubit[N+1]) {
                let x = qubits[0..N-1];
                let y = qubits[N];
                X(y);
                ApplyToEachCA(H, qubits);
                Uf(x, y);
                ApplyToEachCA(H, x);
                for (i in 0 .. N - 1) {
                    set b[i] = ResultAsInt([M(x[i])]);
                }

                // Clean up
                ResetAll(qubits);
            }
            return b;
        }
    }
}