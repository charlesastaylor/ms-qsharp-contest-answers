namespace Solution {
    open Microsoft.Quantum.Arithmetic;
    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Math;
    open Microsoft.Quantum.Convert;

    operation Solve (p : Int, inputRegister : LittleEndian) : Unit is Adj+Ctl {
        using (anc = Qubit[2]) {
            H(anc[0]);
            H(anc[1]);
            Controlled QFTLE([anc[0]], inputRegister);
            Controlled QFTLE([anc[1]], inputRegister);
            Controlled QFTLE([anc[1]], inputRegister);
            Adjoint QFTLE(LittleEndian(anc)); // might need to be big endian
            R1(PI() / (2. * IntAsDouble(p)), anc[0]);
            R1(PI() / IntAsDouble(p), anc[1]);
            QFTLE(LittleEndian(anc)); // might need to be big endian
            Controlled Adjoint QFTLE([anc[1]], inputRegister);
            Controlled Adjoint QFTLE([anc[1]], inputRegister);
            Controlled Adjoint QFTLE([anc[0]], inputRegister);
            H(anc[0]);
            H(anc[1]);
        }
    }

}
