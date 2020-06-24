// Your task is to perform necessary operations and measurements to figure out
// which unitary it was and to return

// 0 if it was the I gate,
// 1 if it was the X gate,
// 2 if it was the Y gate,
// 3 if it was the Z gate.
// You are allowed to apply the given operation and its adjoint/controlled variants
// exactly once.
namespace Solution {
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Measurement;

    operation Solve_A6 (unitary : (Qubit => Unit is Adj+Ctl)) : Int {
        using ((c, t) = (Qubit(), Qubit())) {
            H(c);
            CNOT(c, t);
            unitary(t);
            CNOT(c, t);
            H(c);
            let r = MResetZ(c);
            let s = MResetZ(t);
            if (r == Zero and s == Zero) {
                return 0;
            } elif (r == Zero and s == One) {
                return 1;
            } elif (r == One and s == Zero) {
                return 3;
            } else  {
                return 2;
            }
        }
    }
}