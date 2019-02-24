namespace Solution {
    open Microsoft.Quantum.Primitive;
    open Microsoft.Quantum.Canon;

    operation Solve_U2 (qs : Qubit[]) : Unit {
        // Equivalent to HxIx(H^(N-2))
        ApplyToEach(H, qs);
        H(qs[1]);
    }
}