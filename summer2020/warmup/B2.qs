namespace Solution {
    open Microsoft.Quantum.Arithmetic;
    open Microsoft.Quantum.Intrinsic;

// Implement a unitary operation on a register of N qubits that decrements the
// number written in the register modulo 2N.

// Your code is not allowed to use measurements or arbitrary rotation gates 
// (so, for example, using the library operation IncrementByInteger will cause 
// runtime error). This operation can be implemented using just the X gate and its 
// controlled variants.

// https://algassert.com/quirk#circuit={%22cols%22:[[%22Counting4%22],[%22Chance4%22],[%22X%22],[%22%E2%80%A2%22,%22X%22],[%22%E2%80%A2%22,%22%E2%80%A2%22,%22X%22],[%22%E2%80%A2%22,%22%E2%80%A2%22,%22%E2%80%A2%22,%22X%22],[%22Chance4%22]]}
    operation Solve_B2_ (register : LittleEndian) : Unit is Adj+Ctl {
        let qs = register!;
        let n = Length(qs);
        X(qs[0]);
        for (i in 1..n-1) {
            Controlled X(qs[0..i-1], qs[i]);
        }
    }
}

