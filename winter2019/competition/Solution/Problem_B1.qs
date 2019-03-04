namespace Solution {
    open Microsoft.Quantum.Primitive;
    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Extensions.Math;
    // Circuit: https://algassert.com/quirk#circuit={%22cols%22:[[1,1,%22~egm%22],[1,%22H%22,%22%E2%97%A6%22],[%22X%22,%22%E2%97%A6%22,%22%E2%97%A6%22],[%22~b300%22,%22~rv4f%22],[%22%E2%80%A6%22],[%22~rv4f%22,%22~b300%22],[%22X%22,%22%E2%97%A6%22,%22%E2%97%A6%22],[1,%22H%22,%22%E2%97%A6%22],[1,1,%22~p0b9%22]],%22gates%22:[{%22id%22:%22~egm%22,%22name%22:%22G%22,%22matrix%22:%22{{%E2%88%9A%E2%85%94,-%E2%88%9A%E2%85%93},{%E2%88%9A%E2%85%93,%E2%88%9A%E2%85%94}}%22},{%22id%22:%22~rv4f%22,%22name%22:%22w%22,%22matrix%22:%22{{1,0},{0,-%C2%BD+%E2%88%9A%C2%BEi}}%22},{%22id%22:%22~b300%22,%22name%22:%22w^2%22,%22matrix%22:%22{{1,0},{0,-%C2%BD-%E2%88%9A%C2%BEi}}%22},{%22id%22:%22~p0b9%22,%22name%22:%22GA%22,%22matrix%22:%22{{%E2%88%9A%E2%85%94,%E2%88%9A%E2%85%93},{-%E2%88%9A%E2%85%93,%E2%88%9A%E2%85%94}}%22},{%22id%22:%22~jias%22,%22name%22:%22GG%22,%22matrix%22:%22{{%E2%88%9A%E2%85%93,-%E2%88%9A%E2%85%94},{%E2%88%9A%E2%85%94,%E2%88%9A%E2%85%93}}%22}]}

    operation Solve_B1 (qs : Qubit[]) : Int {
        Rz(4.0 * PI() / 3.0, qs[1]);
        Rz(2.0 * PI() / 3.0, qs[2]);
        (ControlledOnBitString([false, false], X))(qs[0..1], qs[2]);
        (ControlledOnBitString([false], H))(qs[0..0], qs[1]);
        Adjoint G(qs[0]);
        for (q in qs) {
            if (M(q) == One) {
                return 1;
            }
        }
        return 0;
    }

    operation G (q : Qubit) : Unit {
        body (...) {
            let theta = 2.0 * ArcCos(Sqrt(2.0 / 3.0));
            Ry(theta, q);
        }
        adjoint invert;
        controlled distribute;
        controlled adjoint distribute;
    }
}