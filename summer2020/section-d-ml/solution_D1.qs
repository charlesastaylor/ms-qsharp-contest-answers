// This file is submitted by the participant
namespace Solution {
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.MachineLearning;
    open Microsoft.Quantum.Math;

    // The operation that the participant has to implement
    // Has to return three things: 
    //  1) the feature engineering to perform (as an index in the array of feature engineering functions and an array of parameters to be used with it)
    //  2) circuit structure (as an array of ControlledRotation)
    //  3) and training results (circuit parameters + bias)
    //
    // The features engineering is built-in and cannot be tweaked by the participant's solution, only chosen from the list 
    // (see quantum-checker.qs for the list of available feature engineering functions)
    //
    operation Solve_D1 () : ((Int, Double[]), ControlledRotation[], (Double[], Double)) {
        // let pre = (0, new Double[0]);

        // // half moons
        // let classifierStructure = [
        //     ControlledRotation((0, new Int[0]), PauliX, 4),
        //     ControlledRotation((0, new Int[0]), PauliZ, 5),
        //     ControlledRotation((1, new Int[0]), PauliX, 6),
        //     ControlledRotation((1, new Int[0]), PauliZ, 7),
        //     ControlledRotation((0, [1]), PauliX, 0),
        //     ControlledRotation((1, [0]), PauliX, 1),
        //     ControlledRotation((1, new Int[0]), PauliZ, 2),
        //     ControlledRotation((1, new Int[0]), PauliX, 3)
        // ];
        // 1.
        // let pre = (1, [0.5, 0.6]);
        // let paramaters = [5.21662, 6.04363, 0.03338399999999747, 1.3483299999999976, 1.4544399999999975, 4.604279999999993, 1.3066199999999975, 1.3541999999999974];
        // let bias = -0.34455548092569865;
        // 2.
        // let pre = (1, [0.6, 0.7]);
        // let paramaters = [0.058861865699999995,3.065624922,2.0318297050703125,0.5829348189921876,1.0187479930703125,1.2646941030703125,4.144487408070313,5.303468013570312];
        // let bias = 0.10065000000000002;
        
        let classifierStructure = CombinedStructure([
                LocalRotationsLayer(2, PauliY),
                CyclicEntanglingLayer(2, PauliY, 1),
                PartialRotationsLayer([1], PauliY)
            ]);

        // Mine yo
        // 1.
        // let pre = (1, [0.5, 0.5]);
        // let pre = (1, [0.5055555555555555, 0.49444444444444446]); // fail
        // let pre = (1, [0.5166666666666667, 0.46111111111111114]); // fail
        // let pre = (1, [0.5166666666666667, 0.48333333333333334]); // succues
        // let pre = (1, [0.538888888888889, 0.47222222222222227]); // succues
        // let paramaters = [3.97129157876657,4.889359286088416,0.34206436801089,2.0760273296187624,0.6025463351246735];
        // let bias = 0.20192311246914574;
        // 2.
        // Training complete, found optimal parameters: [0.5074945279016652,2.308283257065351,3.2090696515186177,1.9832299029714988,2.8348232865627163], 0.12257824052976254 with 6 misses
        let pre = (1, [0.5, 0.5]);
        let paramaters = [0.5074945279016652,2.308283257065351,3.2090696515186177,1.9832299029714988,2.8348232865627163];
        let bias = 0.12257824052976254;
        return (pre, 
                classifierStructure,
                (paramaters, bias));
        
    }
}

