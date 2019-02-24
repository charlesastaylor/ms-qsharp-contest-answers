namespace Solution {
    open Microsoft.Quantum.Primitive;
    open Microsoft.Quantum.Canon;

    operation Solve_U1 (qs : Qubit[]) : Unit {
        ApplyToEach(X, qs);
    }
}