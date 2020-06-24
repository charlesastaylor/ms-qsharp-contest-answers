namespace Solution {
    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Intrinsic;

// Your task is to perform necessary operations and measurements to figure out
// which unitary it was and to return 0 if it was the Z gate or 1 if it was the
// -Z gate.

// You are allowed to apply the given operation and its adjoint/controlled
// variants exactly once.
    operation Solve_A5_ (unitary : (Qubit => Unit is Adj+Ctl)) : Int {
        using ((q, t) = (Qubit(), Qubit())) {
            H(q);
            CNOT(q, t);
            Controlled unitary([q], t);
            CNOT(q, t);
            H(q);
            let result = M(q);
            if (result == One) {
                X(q);
                return 0;
            } else {
                return 1;
            }
        }
    }
}