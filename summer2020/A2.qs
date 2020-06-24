namespace Solution {
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Measurement;


// 0 if it was the I ⊗ I gate,
// 1 if it was the CNOT12 gate,
// 2 if it was the CNOT21 gate,
// 3 if it was the SWAP gate.
    operation Solve_A2 (unitary : (Qubit[] => Unit is Adj+Ctl)) : Int {
        using ((q1, q2) = (Qubit(), Qubit())) {
            X(q1);
            X(q2);
            unitary([q1, q2]);
            let q1_res = MResetZ(q1);
            let q2_res = MResetZ(q2);
            mutable res = -1;
            if (q1_res == One and q2_res == Zero) {
                set res = 1;
            } elif (q1_res == Zero and q2_res == One) {
                set res = 2;
            } else {
                X(q1);
                unitary([q1, q2]);
                if (M(q1) == One) {
                    set res = 0;
                } else {
                    set res = 3;
                }
            }
            ResetAll([q1, q2]);
            return res;
        }
    }
}
