namespace Solution {
    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Intrinsic;

    operation Solve_A1__ (unitary : (Qubit => Unit is Adj+Ctl)) : Int {
        using (qubit = Qubit()) {
            unitary(qubit);
            let result = M(qubit);
            if (result == One) {
                X(qubit);
                return 1;
            } else {
                return 0;
            }
        }
    }
}