namespace Solution {
    open Microsoft.Quantum.MachineLearning;

    operation Solve_D2_ () : (ControlledRotation[], (Double[], Double)) {
        return (
            [
                ControlledRotation((0, new Int[0]), PauliX, 0),
                ControlledRotation((0, new Int[0]), PauliY, 1),
                ControlledRotation((0, new Int[0]), PauliZ, 2)
            ],
            (
                [0.9892480468749996,0.9692480468749995,1.9992480468749996],
                 0.2703932857778518
            )
        );
    }
}