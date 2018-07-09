namespace Solution {
    open Microsoft.Quantum.Primitive;
    open Microsoft.Quantum.Canon;

    operation Solve_E2 (N : Int, Uf : ((Qubit[], Qubit) => ())) : Int[]
    {
        body
        {
            // Only ever need to return 0...00 or 0...01 as only two values
            // of f(x)
            mutable b_pos = new Int[N];
            using (qubits = Qubit[N+1]) {
                let x = qubits[0..N-1];
                let y = qubits[N];
                Uf(x, y);
                if (N % 2 == 1) {
                    X(y);
                }
                set b_pos[0] = ResultAsInt([M(y)]);
                // Clean up
                ResetAll(qubits);
            }
            return b_pos;
        }
    }
}