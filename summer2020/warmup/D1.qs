namespace Solution {
    open Microsoft.Quantum.MachineLearning;

    operation Solve_D1_ () : (ControlledRotation[], (Double[], Double)) {
        return (
            [ControlledRotation((0, new Int[0]), PauliY, 0)],
            // ([3.2435999999999985], 0.04276136760204836)
            ([3.2102000000000133], 0.01942259314448826)

        );
    }
}