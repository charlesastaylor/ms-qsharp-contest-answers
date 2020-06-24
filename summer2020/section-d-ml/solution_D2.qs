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
    operation Solve_D2 () : ((Int, Double[]), ControlledRotation[], (Double[], Double)) {
        let classifierStructure = CombinedStructure([
                LocalRotationsLayer(2, PauliY),
                CyclicEntanglingLayer(2, PauliY, 1),
                PartialRotationsLayer([1], PauliY)
            ]);


// Training complete, found optimal parameters:[0.4722087424247712,5.9779964457726,2.7374726676957555,6.2918833125751465,1.8360711216953953], 0.09999999999999998 with 1 misses
//         let pre = (4, [0., 1.]);
//         let paramaters = [0.4722087424247712,5.9779964457726,2.7374726676957555,6.2918833125751465,1.8360711216953953];
//         let bias = 0.09999999999999998;
// Training complete, found optimal parameters: [7.786390856011393,7.515585198400066,3.128496469244241,5.2426664458385295,3.6714473435042123], 0.21625 with 0 misses
        let pre = (4, [0., 1.]);
        let paramaters = [7.786390856011393,7.515585198400066,3.128496469244241,5.2426664458385295,3.6714473435042123];
        let bias = 0.21625;
        return (pre, 
                classifierStructure,
                (paramaters, bias));
        
    }
}



