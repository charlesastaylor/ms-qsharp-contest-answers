namespace Solution {
    open Microsoft.Quantum.Primitive;
    open Microsoft.Quantum.Canon;
   
    function FirstTrue(a: Bool[]) : (Int) {
        for (i in 0..Length(a)-1) {
            if (a[i]) {
                return i;
            }
        }
        return -1;
    }
   
    operation Solve_A2 (qs : Qubit[], bits : Bool[]) : ()
    {
        body
        {
            let first = FirstTrue(bits);
            H(qs[first]);
            for (i in first+1..Length(qs)-1) {
                if (bits[i]) {
                    CNOT(qs[first], qs[i]);
                }
            }
        }
    }
}