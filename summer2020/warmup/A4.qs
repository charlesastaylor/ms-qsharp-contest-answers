namespace Solution {
    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Intrinsic;

// Your task is to perform necessary operations and measurements to figure out
// which unitary it was and to return 0 if it was I⊗X or 1 if it was the CNOT 
// gate.

// You are allowed to apply the given operation and its adjoint/controlled variants 
// exactly once.
    operation Solve_A4_ (unitary : (Qubit[] => Unit is Adj+Ctl)) : Int {
        using (qs = Qubit[2]) {
            unitary(qs);
            let result = M(qs[1]);
            if (result == One) {
                X(qs[1]);
                return 0;
            } else {
                return 1;
            }

        }
    }
}