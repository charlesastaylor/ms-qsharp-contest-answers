namespace Solution {
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Arithmetic;
    open Microsoft.Quantum.Canon;

    operation Increment (register : LittleEndian) : Unit is Adj+Ctl {
        let qs = register!;
        let n = Length(qs);
        for (i in n-1..-1..1) {
            Controlled X(qs[0..i-1], qs[i]);
        }
        X(qs[0]);
    }

    // This operation can be implemented using just the X gate and its controlled
    // variants (possibly with multiple qubits as controls).
    operation Solve_B1 (inputs : Qubit[], output : Qubit) : Unit is Adj+Ctl {
        // operation IncrementByInteger (increment : Int, target : Microsoft.Quantum.Arithmetic.LittleEndian) : Unit
        // function ControlledOnInt (numberState : Int, oracle : ('T => Unit is Adj + Ctl)) : ((Qubit[], 'T) => Unit is Adj + Ctl)
        let N = Length(inputs);
        using (qs = Qubit[4]) {
            let le = LittleEndian(qs);
            for (q in inputs) {
                Controlled Increment([q], le);
            }
            (ControlledOnInt(N / 2, X)) (le!, output);
            for (q in inputs) {
                Controlled Adjoint Increment([q], le);
            }
        }
    }
}