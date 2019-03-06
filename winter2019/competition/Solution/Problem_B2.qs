namespace Solution {
    open Microsoft.Quantum.Primitive;
    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Extensions.Math;
    open Microsoft.Quantum.Extensions.Convert;

    // Circuit: https://algassert.com/quirk#circuit={%22cols%22:[[%22H%22],[%22Amps2%22],[],[%22%E2%80%A2%22,%22X%22],[%22H%22,%22%E2%80%A2%22],[%22Z^%C2%BD%22,%22%E2%80%A2%22],[%22~uj04%22,%22%E2%80%A2%22],[%22%E2%80%A2%22,%22X%22],[%22~d5jj%22,%22%E2%97%A6%22],[%22X%22,%22%E2%97%A6%22],[%22%E2%97%A6%22,%22H%22]],%22gates%22:[{%22id%22:%22~uj04%22,%22name%22:%22Ry(-pi/3)%22,%22matrix%22:%22{{%E2%88%9A%C2%BE,%C2%BD},{-%C2%BD,%E2%88%9A%C2%BE}}%22},{%22id%22:%22~d5jj%22,%22name%22:%22Ry(bla)%22,%22matrix%22:%22{{%E2%88%9A%E2%85%93,-%E2%88%9A%E2%85%94},{%E2%88%9A%E2%85%94,%E2%88%9A%E2%85%93}}%22},{%22id%22:%22~2cnc%22,%22name%22:%22w%22,%22matrix%22:%22{{%C2%BD-%E2%88%9A%C2%BEi,0},{0,%C2%BD+%E2%88%9A%C2%BEi}}%22}]}

    operation Solve (q : Qubit) : Int {
        mutable ret = 0;
        using (a = Qubit()) {
            // U3_dagger
            CNOT(q, a);
            Controlled H([a], q);
            Controlled S([a], q);
            Controlled Ry([a], (-PI() / 3., q));
            CNOT(q, a);
            // U2_dagger
            (ControlledOnInt(0, Ry))([a], (2. * ArcCos(Sqrt(1./3.)), q));
            (ControlledOnInt(0, X))([a], q);
            // U3_dagger
            (ControlledOnInt(0, H))([q], a);

            if (M(q) == Zero) {
                if (M(a) == One) {
                    set ret = 0;
                } else {
                    set ret = 2;
                }
            } else {
                if (M(a) == Zero) {
                    set ret = 1;
                }
            }
            Reset(a);
        }

        return ret;
    }
}
