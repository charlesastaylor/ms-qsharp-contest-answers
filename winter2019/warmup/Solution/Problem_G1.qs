namespace Solution {
    open Microsoft.Quantum.Primitive;
    open Microsoft.Quantum.Canon;

    operation Solve_G1 (x : Qubit[], y : Qubit) : Unit {
        body (...) {
            Controlled X(x, y);
        }
        adjoint auto;
    }
}