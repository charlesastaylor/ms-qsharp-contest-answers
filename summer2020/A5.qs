namespace Solution {
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Measurement;
    open Microsoft.Quantum.Convert;


// You are given an angle θ (in radians, 0.01π≤θ≤0.99π) and an operation that implements
// a single-qubit unitary transformation: either the Rz(θ) gate or the Ry(θ) gate.
// The operation will have Adjoint and Controlled variants defined.

// Your task is to perform necessary operations and measurements to figure out
// which unitary it was and to return 0 if it was the Rz(θ) gate or 1 if it was
// the Ry(θ) gate.
    operation Solve_A5 (theta : Double, unitary : (Qubit => Unit is Adj+Ctl)) : Int {
        using (q = Qubit()) {
            mutable ans = -1;
            repeat {
                let reps = theta < 0.2 ? 75 | 1;
                Adjoint Rz(theta * IntAsDouble(reps), q);
                for (_ in 1..reps) {
                    unitary(q);
                }
                if (MResetZ(q) == One) {
                    set ans = 1;
                }
                Adjoint Ry(theta * IntAsDouble(reps), q);
                for (_ in 1..reps) {
                    unitary(q);
                }
                if (MResetZ(q) == One) {
                    set ans = 0;
                }
            }
            until (ans != -1);
            return ans;
        }
    }
}