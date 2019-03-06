namespace Solution {
    open Microsoft.Quantum.Primitive;
    open Microsoft.Quantum.Canon;

    operation Solve_B4 (qs : Qubit[]) : Int
    {
        body
        {
            (Controlled Z)([qs[0]], qs[1]);
            ApplyToEachCA(H, qs);

            let m_0 = M(qs[0]);
            let m_1 = M(qs[1]);
            if (IsResultZero(m_0)) {
                if (IsResultZero(m_1)) {
                    return 3;
                } else {
                    return 1;
                }
            } else {
                if (IsResultZero(m_1)) {
                    return 2;
                } else {
                    return 0;
                }    
            }
        }
    }
}