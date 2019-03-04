namespace Solution {
    open Microsoft.Quantum.Primitive;
    open Microsoft.Quantum.Canon;

    operation Solve_C2 (x : Qubit[], y : Qubit) : Unit {
        body (...) {
            let N = Length(x);
            for (i in 0 .. 2^N - 1) {
                let bits = BoolArrFromPositiveInt(i, N);
                if (not IsPeriodic(bits, N)) {
                    (ControlledOnBitString(bits, X))(x, y);
                }
            }
            X(y);
        }
        adjoint auto;
    }

    function IsPeriodic(bits : Bool[], N : Int) : Bool {
        mutable periodic = true;
        for (p in N - 1 .. -1 .. 1) {
            set periodic = true;
            for (i in 0 .. N - p - 1) {
                if (periodic) {
                    for (j in i + p .. p .. N - 1) {
                        if (periodic) {
                            if (bits[i] != bits[j]) {
                                set periodic = false;
                            }
                        }
                    }
                }
            }
            if (periodic) {
                return true;
            }
        }
        return false;
    }
}


// operation Solve (x : Qubit[], y : Qubit) : Unit {
//         body (...) {
//             let N = Length(x);
//             let dis = Disallowed(N);
//             for (i in 0 .. 2^N - 1) {
//                 if (not IntInArray(i, dis)) {
//                     (ControlledOnBitString(BoolArrFromPositiveInt(i, N), X))(x, y);
//                 }
//             }
//         }
//         adjoint auto;
//     }