namespace Solution {
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Measurement;

    operation Solve_A1 (unitary : (Qubit[] => Unit is Adj+Ctl)) : Int {
        using ((q1, q2) = (Qubit(), Qubit())) {
            X(q1);
            unitary([q1, q2]);
            X(q1);
            return MResetZ(q2) == One ? 0 | 1;
        }
    }
}

// using (q = Qubit()) {
// unitary(q);
// return MResetZ(q) == Zero ? 0 | 1;
// }
