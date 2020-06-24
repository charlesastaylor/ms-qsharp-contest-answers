// You are given an operation that implements a single-qubit unitary
// transformation: either the Y gate (possibly with an extra global phase of −1)
// or the sequence of Pauli Z and Pauli X gates (the Z gate applied first and the
// X gate applied second; possibly with an extra global phase of −1). The operation
// will have Adjoint and Controlled variants defined.

// Your task is to perform necessary operations and measurements to figure out
// which unitary it was and to return

// 0 if it was the Y gate,
// 1 if it was the −XZ gate,
// 2 if it was the −Y gate,
// 3 if it was the XZ gate.
// You are allowed to apply the given operation and its adjoint/controlled variants
// at most three times.

// Y / XZ: https://algassert.com/quirk#circuit={%22cols%22:[[1,1,%22H%22],[1,1,%22%E2%80%A2%22,%22~8oom%22],[1,1,%22%E2%80%A2%22,%22~8oom%22],[1,1,%22H%22],[%22H%22],[%22%E2%80%A6%22],[%22%E2%80%A2%22,%22~agt5%22],[%22%E2%80%A2%22,%22~agt5%22],[%22%E2%80%A6%22],[%22H%22],[%22Amps2%22,1,%22Amps2%22]],%22gates%22:[{%22id%22:%22~koia%22,%22name%22:%22Z_minus%22,%22matrix%22:%22{{-1,0},{0,1}}%22},{%22id%22:%22~s4pm%22,%22name%22:%22Rz_pi%22,%22matrix%22:%22{{-i,0},{0,i}}%22},{%22id%22:%22~13u%22,%22name%22:%22I%22,%22matrix%22:%22{{1,0},{0,1}}%22},{%22id%22:%22~9t71%22,%22name%22:%22I_minus%22,%22matrix%22:%22{{-1,0},{0,-1}}%22},{%22id%22:%22~agt5%22,%22name%22:%22XYZ%22,%22circuit%22:{%22cols%22:[[%22Z%22],[%22Y%22],[%22X%22]]}},{%22id%22:%22~8oom%22,%22name%22:%22XXZZ%22,%22circuit%22:{%22cols%22:[[%22Z%22],[%22Z%22],[%22X%22],[%22X%22]]}},{%22id%22:%22~fl6s%22,%22name%22:%22-XYZ%22,%22circuit%22:{%22cols%22:[[%22NeGate%22],[%22Z%22],[%22Y%22],[%22X%22]]}}]}
// XZ / -XZ: https://algassert.com/quirk#circuit={%22cols%22:[[1,1,%22H%22],[1,1,%22%E2%80%A2%22,%22~4tul%22],[1,1,%22%E2%80%A2%22,%22X%22],[1,1,%22H%22],[%22H%22],[%22%E2%80%A2%22,%22~g1sl%22],[%22%E2%80%A2%22,%22X%22],[%22H%22],[%22Amps2%22,1,%22Amps2%22]],%22gates%22:[{%22id%22:%22~koia%22,%22name%22:%22Z_minus%22,%22matrix%22:%22{{-1,0},{0,1}}%22},{%22id%22:%22~s4pm%22,%22name%22:%22Rz_pi%22,%22matrix%22:%22{{-i,0},{0,i}}%22},{%22id%22:%22~13u%22,%22name%22:%22I%22,%22matrix%22:%22{{1,0},{0,1}}%22},{%22id%22:%22~9t71%22,%22name%22:%22I_minus%22,%22matrix%22:%22{{-1,0},{0,-1}}%22},{%22id%22:%22~g1sl%22,%22name%22:%22XZ%22,%22circuit%22:{%22cols%22:[[%22Z%22],[%22X%22]]}},{%22id%22:%22~4tul%22,%22name%22:%22-XZ%22,%22circuit%22:{%22cols%22:[[%22NeGate%22],[%22Z%22],[%22X%22]]}}]}
// Y / -Y: https://algassert.com/quirk#circuit={%22cols%22:[[1,1,%22H%22],[1,1,%22%E2%80%A2%22,%22Y%22],[1,1,%22%E2%80%A2%22,%22Y%22],[1,1,%22H%22],[%22H%22],[%22%E2%80%A2%22,%22~ct2g%22],[%22%E2%80%A2%22,%22Y%22],[%22H%22],[%22Amps2%22,1,%22Amps2%22]],%22gates%22:[{%22id%22:%22~koia%22,%22name%22:%22Z_minus%22,%22matrix%22:%22{{-1,0},{0,1}}%22},{%22id%22:%22~s4pm%22,%22name%22:%22Rz_pi%22,%22matrix%22:%22{{-i,0},{0,i}}%22},{%22id%22:%22~13u%22,%22name%22:%22I%22,%22matrix%22:%22{{1,0},{0,1}}%22},{%22id%22:%22~9t71%22,%22name%22:%22I_minus%22,%22matrix%22:%22{{-1,0},{0,-1}}%22},{%22id%22:%22~ct2g%22,%22name%22:%22-Y%22,%22circuit%22:{%22cols%22:[[%22NeGate%22],[%22Y%22]]}}]}
namespace Solution {
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Measurement;

    operation X_Z ((unitary : (Qubit => Unit is Adj+Ctl), qubit : Qubit)) : Unit is Adj + Ctl{
        Z(qubit);
        unitary(qubit);
        X(qubit);
    }

    operation Solve_A7 (unitary : (Qubit => Unit is Adj+Ctl)) : Int {
        using ((c, t) = (Qubit(), Qubit())) {
            H(c);
            let U = X_Z(unitary, _);
            // Controlled X_Z([c], (unitary, t));
            Controlled U([c], t);
            Controlled U([c], t);
            H(c);
            if (MResetZ(c) == One) {
                // Y or -Y
                H(c);
                Controlled unitary([c], t);
                CY(c, t);
                H(c);
                return MResetZ(c) == Zero ? 0 | 2;
            } else {
                // XZ or -XZ
                H(c);
                Controlled unitary([c], t);
                CNOT(c, t);
                H(c);
                return MResetZ(c) == Zero ? 3 | 1;
            }
        }
    }
}