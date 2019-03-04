namespace Solution {
    open Microsoft.Quantum.Primitive;
    open Microsoft.Quantum.Canon;

    operation Solve_C1 (x : Qubit[], y : Qubit) : Unit {
        body (...) {
            let N = Length(x);
            let bits = AlternatingBitStrings(N);
            for (b in bits) {
                (ControlledOnBitString(b, X))(x, y);
            }
        }
        adjoint auto;
    }

    function AlternatingBitStrings(N : Int) : Bool[][] {
        mutable bits1 = new Bool[N];
        mutable bits2 = new Bool[N];
        for (i in 0..2..N-1) {
            set bits1[i] = true;
            if (i + 1 < N) {
                set bits2[i+1] = true;
            }
        }
        return [bits1, bits2];
    }
}