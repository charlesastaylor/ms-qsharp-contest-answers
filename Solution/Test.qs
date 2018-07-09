namespace Solution {
    open Microsoft.Quantum.Primitive;
    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Extensions.Math;
    open Microsoft.Quantum.Extensions.Convert;

    operation Test () : ()
    {
        body
        {
            let N = 1;
            mutable amps = new Double[2^N];
            // Select amps
            for ( i in 0 .. 2^(N-1) - 1)  {
                set amps[2^i] = Sqrt(1.0 / ToDouble(N));
                Message(ToStringI(i^N));
                Message(ToStringD(amps[i^N]));
            }
        }
    }
}