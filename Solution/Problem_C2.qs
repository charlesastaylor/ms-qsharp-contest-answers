namespace Solution {
    open Microsoft.Quantum.Primitive;
    open Microsoft.Quantum.Canon;

    operation Solve_C2 (q : Qubit) : Int
    {
        body
        {
            if (RandomInt(2) == 0) {
                if (MResetZ(q) == One) {
                    return 1;
                }
            } else {
                if (MResetX(q) == One) {
                    return 0;
                }
            }
            return -1;
        }
    }

    // operation Test_C2 () : () {
    //     body {
    //         using (qs = Qubit[1]) {
    //             let q = qs[0];
    //             mutable 
    //             for (i in 0 .. 10000 - 1) {

    //             }
    //             ResetAll(qs);
    //         }
    //     }
    // }
}