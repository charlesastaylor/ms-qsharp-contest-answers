namespace Solution {
    open Microsoft.Quantum.Primitive;
    open Microsoft.Quantum.Canon;

    operation Solve_G2 (x : Qubit[], y : Qubit) : Unit {
        body (...) {
            for (i in 0..Length(x) - 1) {
                (ControlledOnBitString(BoolArrFromPositiveInt(2^i, i + 1), X))(x[0..i], y);
            }
        }
        adjoint auto;
    }

    operation Solve_G2_Slow (x : Qubit[], y : Qubit) : Unit {
        // There is surely a better way than all these CNOTS but can't figure it out.
        body (...) {
            for (i in 1..2^Length(x)-1) {
                if ((i &&& (i - 1)) != 0) {
                    (ControlledOnBitString(BoolArrFromPositiveInt(i, Length(x)), X))(x, y);
                }
            }
        }
        adjoint auto;
    }
}