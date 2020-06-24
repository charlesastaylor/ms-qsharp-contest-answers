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
    operation Solve_D3 () : ((Int, Double[]), ControlledRotation[], (Double[], Double)) {
        let classifierStructure = CombinedStructure([
                LocalRotationsLayer(2, PauliY),
                CyclicEntanglingLayer(2, PauliY, 1),
                PartialRotationsLayer([1], PauliY)
            ]);

        // Training complete, found optimal parameters: [5.287311907312137,6.12140750547978,5.105010069136324,0.40188299643736974,6.059298441634672], -0.04875948283737718 with 8 misses
        // let pre = (1, [0.5, 0.5]);
        // let paramaters = [5.287311907312137,6.12140750547978,5.105010069136324,0.40188299643736974,6.059298441634672];
        // let bias = -0.04875948283737718;
        // Training complete, found optimal parameters: [5.312311907312138,6.146407505479781,5.105010069136324,0.40188299643736974,6.084298441634672], -0.05736594202199646 with 7 misses
        let pre = (1, [0.5, 0.5]);
        let paramaters = [5.312311907312138,6.146407505479781,5.105010069136324,0.40188299643736974,6.084298441634672];
        let bias = -0.05736594202199646;
        return (pre, 
                classifierStructure,
                (paramaters, bias));
        
    }
}

