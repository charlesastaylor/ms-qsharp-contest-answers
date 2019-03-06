namespace Solution {
    open Microsoft.Quantum.Primitive;
    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Extensions.Math;
    open Microsoft.Quantum.Extensions.Convert;

    operation Solve_A3 (qs : Qubit[], bits0 : Bool[], bits1 : Bool[]) : ()
    {
        body
        {
            let s0 = PositiveIntFromBoolArr(Reverse(bits0));
            let s1 = PositiveIntFromBoolArr(Reverse(bits1));
            
            let N = Length(qs);
            mutable amps = new Double[2^N];
            set amps[s0] = Sqrt(0.5);
            set amps[s1] = Sqrt(0.5);

            let op = StatePreparationPositiveCoefficients(amps);
            op(BigEndian(qs));
        }
    }
}