namespace Solution {
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Measurement;


// Your task is to perform necessary operations and measurements to figure out
// which unitary it was and to return 0 if it was the H gate or 1 if it was the X gate.

// You are allowed to apply the given operation and its adjoint/controlled variants at most twice.
    operation Solve_A3 (unitary : (Qubit => Unit is Adj+Ctl)) : Int {
        using (q1 = Qubit()) {
            unitary(q1);
            X(q1);
            unitary(q1);
            return MResetZ(q1) == Zero ? 0 | 1;
        }
    }
}
