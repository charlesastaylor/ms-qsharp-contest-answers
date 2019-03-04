namespace Solution {
    open Microsoft.Quantum.Primitive;
    open Microsoft.Quantum.Canon;

    operation Solve_D1 (qs : Qubit[]) : Unit {
        H(qs[0]);
    }
}