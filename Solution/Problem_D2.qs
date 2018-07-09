namespace Solution {
    open Microsoft.Quantum.Primitive;
    open Microsoft.Quantum.Canon;

    function NumZeros (x : Int[]) : (Int) {
        mutable num = 0;
        for (i in 0..Length(x)-1) {
            if (x[i] == 0) {
                set num = num + 1;
            }
        }
        return num;
    }

    operation Solve_D2 (x : Qubit[], y : Qubit, b : Int[]) : ()
    {
        body
        {
            for (i in 0..Length(x)-1) {
                CNOT(x[i], y);
            }
            if (NumZeros(b) % 2 == 1) {
                X(y);
            }
        }
    }
}