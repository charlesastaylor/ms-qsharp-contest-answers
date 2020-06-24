namespace Microsoft.Quantum.Problem
{
    open Microsoft.Quantum.Arithmetic;
    open Microsoft.Quantum.Arrays;
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Convert;
    open Microsoft.Quantum.Math;
    open Microsoft.Quantum.Diagnostics;
    open Microsoft.Quantum.MachineLearning;
        
    // ------------------------------------------------------
    // input is the array of original features
    // output is the array of engineered features, that might be larger than the original one

    // mode 0 is no engineering: we return exactly the same features as the ones we started with
    // the parameters array is ignored
    function RawFeatures (auxil : Double[], input : Double[]) : Double[] {
        return input;
    }


    // mode 1 is feature padding: the parameters array is appended to the features array (padding on the left)
    // the length of the result is len(auxil) + len(input)
    function LeftPaddedFeatures (auxil : Double[], input : Double[]) : Double[] {
        return auxil + input;
    }


    // mode 2 is tensor product of the parameters array with input:
    // [auxil[0] * input[0], auxil[0] * input[1], auxil[1] * input[0], auxil[1] * input[1]]
    // the length of the result is len(auxil) * len(input)
    function FeaturesTensorWithAncilla (auxil : Double[], input : Double[]) : Double[] {
        mutable ret = new Double[Length(auxil) * Length(input)];
        for (j in 0 .. Length(auxil) - 1) {
            for (k in 0 .. Length(input) - 1) {
                set ret w/= (j * Length(input) + k) <- (auxil[j] * input[k]);   
            }
        }
        return ret;
    }

    // mode 3 is feature fanout: tensor product of the parameters array with input with input
    // the length of the result is len(auxil) * len(input)^2
    function FeaturesFanout (auxil : Double[], input : Double[]) : Double[] {
        mutable ret = new Double[Length(auxil)*Length(input)*Length(input)];
        for (j in 0..Length(auxil)-1) {
            for (k in 0..Length(input)-1) {
                for (m in 0..Length(input)-1) {
                    set ret w/= (j*Length(input)*Length(input)+k*Length(input)+m) <- (auxil[j] * input[k] * input[m]);   
                }
            }
        }
        return ret;    
    }

    // mode 4 is tensor product of (concatenation of left halves of parameters and input) and (concatenation of right halves)
    // [auxil[0] * auxil[1], auxil[0] * input[1], input[0] * auxil[1], input[0] * input[1]]
    // the length of the result is len(auxil) * len(input)
    function FeaturesSplitFanout (auxil : Double[], input : Double[]) : Double[] {
        let halfLa = Length(auxil)/2;
        let halfLi = Length(input)/2;
        let left = auxil[...(halfLa-1)] + input[...(halfLi-1)];
        let right = auxil[halfLa...] + input[halfLi...];
        return FeaturesTensorWithAncilla(left, right);
    }


    // a helper function to choose and apply the necessary feature engineering mode
    function FeaturesPreprocess (mode : Int, auxil : Double[], input : Double[]) : Double[] {
        if (mode == 1) { return LeftPaddedFeatures(auxil, input); }
        if (mode == 2) { return FeaturesTensorWithAncilla(auxil, input); }
        if (mode == 3) { return FeaturesFanout(auxil, input); }
        if (mode == 4) { return FeaturesSplitFanout(auxil, input); }
        // in case of unsupported mode, return the raw features
        return input;
    }

    // // Half moons
    // function ClassifierStructure() : ControlledRotation[] {
    //     return [
    //         ControlledRotation((0, new Int[0]), PauliX, 4),
    //         ControlledRotation((0, new Int[0]), PauliZ, 5),
    //         ControlledRotation((1, new Int[0]), PauliX, 6),
    //         ControlledRotation((1, new Int[0]), PauliZ, 7),
    //         ControlledRotation((0, [1]), PauliX, 0),
    //         ControlledRotation((1, [0]), PauliX, 1),
    //         ControlledRotation((1, new Int[0]), PauliZ, 2),
    //         ControlledRotation((1, new Int[0]), PauliX, 3)
    //     ];
    // }

    // // D4 Custom
    // function ClassifierStructure() : ControlledRotation[] {
    //     return [
    //         ControlledRotation((0, new Int[0]), PauliX, 4),
    //         ControlledRotation((0, new Int[0]), PauliZ, 5),
    //         ControlledRotation((1, new Int[0]), PauliX, 6),
    //         ControlledRotation((1, new Int[0]), PauliZ, 7),
    //         ControlledRotation((0, [1]), PauliX, 0),
    //         ControlledRotation((1, [0]), PauliX, 1),
    //         ControlledRotation((0, new Int[0]), PauliZ, 2),
    //         ControlledRotation((0, new Int[0]), PauliX, 3),
    //         ControlledRotation((1, new Int[0]), PauliZ, 8),
    //         ControlledRotation((1, new Int[0]), PauliX, 9)
    //     ];
    // }

    // // D4 Custom n = 3
    // function ClassifierStructure() : ControlledRotation[] {
    //     return [
    //         ControlledRotation((0, new Int[0]), PauliX, 6),
    //         ControlledRotation((0, new Int[0]), PauliZ, 7),
    //         ControlledRotation((1, new Int[0]), PauliX, 8),
    //         ControlledRotation((1, new Int[0]), PauliZ, 9),
    //         ControlledRotation((2, new Int[0]), PauliX, 10),
    //         ControlledRotation((2, new Int[0]), PauliZ, 11),
    //         ControlledRotation((2, [0]), PauliX, 0),
    //         ControlledRotation((1, [2]), PauliX, 1),
    //         ControlledRotation((0, [1]), PauliX, 2),
    //         ControlledRotation((1, [0]), PauliX, 3),
    //         ControlledRotation((2, [1]), PauliX, 4),
    //         ControlledRotation((0, [2]), PauliX, 5),
    //         ControlledRotation((0, new Int[0]), PauliZ, 12),
    //         ControlledRotation((0, new Int[0]), PauliX, 13)
    //     ];
    // }

    // D4 Custom n = 3 ys
    function ClassifierStructure() : ControlledRotation[] {
        return [
            ControlledRotation((0, new Int[0]), PauliY, 6),
            ControlledRotation((1, new Int[0]), PauliY, 7),
            ControlledRotation((2, new Int[0]), PauliY, 8),
            ControlledRotation((0, [2]), PauliY, 0),
            ControlledRotation((1, [0]), PauliY, 1),
            ControlledRotation((2, [1]), PauliY, 2),
            ControlledRotation((1, [2]), PauliY, 3),
            ControlledRotation((0, [1]), PauliY, 4),
            ControlledRotation((2, [0]), PauliY, 5),
            ControlledRotation((2, new Int[0]), PauliY, 9)
        ];
    }

    // // Half moons mmodifeid for d4
    // function ClassifierStructure() : ControlledRotation[] {
    //     return [
    //         ControlledRotation((0, new Int[0]), PauliX, 3),
    //         ControlledRotation((0, new Int[0]), PauliZ, 4),
    //         ControlledRotation((1, new Int[0]), PauliX, 5),
    //         ControlledRotation((1, new Int[0]), PauliZ, 6),
    //         // ControlledRotation((0, [1]), PauliX, 0),
    //         ControlledRotation((1, [0]), PauliX, 0),
    //         ControlledRotation((1, new Int[0]), PauliZ, 1),
    //         ControlledRotation((1, new Int[0]), PauliX, 2)
    //     ];
    // }

    // // wine modified for n=2
    // function ClassifierStructure() : ControlledRotation[] {
    //     return CombinedStructure([
    //         LocalRotationsLayer(2, PauliZ),
    //         LocalRotationsLayer(2, PauliX),
    //         CyclicEntanglingLayer(2, PauliX, 1),
    //         PartialRotationsLayer([2], PauliX)
    //     ]);
    // }



    

    // function ClassifierStructure() : ControlledRotation[] {
    //     return CombinedStructure([
    //         LocalRotationsLayer(2, PauliX),
    //         LocalRotationsLayer(2, PauliZ),
    //         CyclicEntanglingLayer(2, PauliX, 1),
    //         PartialRotationsLayer([1], PauliZ),
    //         PartialRotationsLayer([1], PauliX)
    //     ]);
    // }

    // // D1, D2 and D3
    // function ClassifierStructure() : ControlledRotation[] {
    //     return CombinedStructure([
    //         LocalRotationsLayer(2, PauliY),
    //         CyclicEntanglingLayer(2, PauliY, 1),
    //         PartialRotationsLayer([1], PauliY)
    //     ]);
    // }

    // // N = 3
    // function ClassifierStructure() : ControlledRotation[] {
    //     return CombinedStructure([
    //         LocalRotationsLayer(3, PauliY),
    //         CyclicEntanglingLayer(3, PauliY, 1),
    //         LocalRotationsLayer(3, PauliY),
    //         CyclicEntanglingLayer(3, PauliY, 2),
    //         PartialRotationsLayer([1, 2], PauliY)
    //     ]);
    // }


    // use all data for validation
    function DefaultSchedule(samples : Double[][]) : SamplingSchedule {
        return SamplingSchedule([
            0..Length(samples) - 1
        ]);
    }

    operation TrainModel(
        trainingVectors : Double[][],
        trainingLabels : Int[],
        engineeringMode: Int,
        engineeringParameters: Double[],
        initialParameters : Double[][]
    ) : (Double[], Double) {
        let engineeredData = Mapped(FeaturesPreprocess(engineeringMode, engineeringParameters, _), trainingVectors);
        let samples = Mapped(
            LabeledSample,
            Zip(engineeredData, trainingLabels)
        );
        Message("Ready to train.");

/// ## LearningRate
/// The learning rate by which gradients should be rescaled when updating
/// model parameters during training steps.
/// ## Tolerance
/// The approximation tolerance to use when preparing samples as quantum
/// states.
/// ## MinibatchSize
/// The number of samples to use in each training minibatch.
/// ## NMeasurements
/// The number of times to measure each classification result in order to
/// estimate the classification probability.
/// ## MaxEpochs
/// The maximum number of epochs to train each model for.
/// ## MaxStalls
/// The maximum number of times a training epoch is allowed to stall
/// (approximately zero gradient) before failing.
/// ## StochasticRescaleFactor
/// The amount to rescale stalled models by before retrying an update.
/// ## ScoringPeriod
/// The number of gradient steps to be taken between scoring points.
/// For best accuracy, set to 1.
/// ## VerboseMessage
/// A function that can be used to provide verbose feedback.

        let (optimizedModel, nMisses) = TrainSequentialClassifier(
            Mapped(
                SequentialModel(ClassifierStructure(), _, 0.0),
                initialParameters
            ),
            samples,
            DefaultTrainingOptions()
            w/ LearningRate <- 2. // mine fuck you what do you want form me youre nto my boss
            // w/ MinibatchSize <- 1000 // 15
            w/ MaxEpochs <- 16 // 16
            w/ Tolerance <- 0.0005,
            // w/ NMeasurements <- 500 // 10000
            // w/ LearningRate <- 2.0 // MLAD options
            // w/ Tolerance <- 0.0005,
            // DefaultTrainingOptions() // Half moon options
                // w/ LearningRate <- 0.1
                // w/ Tolerance <- 0.005
                // w/ VerboseMessage <- Message,
            DefaultSchedule(engineeredData),
            DefaultSchedule(engineeredData)
        );  
        Message($"Training complete, found optimal parameters: {optimizedModel::Parameters}, {optimizedModel::Bias} with {nMisses} misses");
        // Message($"Training complete, found optimal parameters: {optimizedModel::Parameters}");
        return (optimizedModel::Parameters, optimizedModel::Bias);
    }

    operation ValidateModel(
        validationVectors : Double[][],
        validationLabels : Int[],
        engineeringMode: Int,
        engineeringParameters: Double[],
        parameters : Double[],
        bias : Double
    ) : Double {
        let engineeredData = Mapped(FeaturesPreprocess(engineeringMode, engineeringParameters, _), validationVectors);
        let data = Mapped(
            LabeledSample,
            Zip(engineeredData, validationLabels)
        );
        let N = Length(data);
        let model = SequentialModel(ClassifierStructure(), parameters, bias);
        let tolerance = 0.005;
        let nMeasurements = 10000;
        let results = ValidateSequentialClassifier(
            model,
            data,
            tolerance,
            nMeasurements,
            DefaultSchedule(engineeredData)
        );
        return IntAsDouble(results::NMisclassifications) / IntAsDouble(Length(data));
    }

    operation ClassifyModel(
        features : Double[][],
        parameters : Double[],
        bias : Double,
        tolerance  : Double,
        nMeasurements : Int,
        engineeringMode: Int,
        engineeringParameters: Double[]
    )
    : Int[] {
        // let ((engineeringMode, engineeringParameters), classifierStructure, (modelParameters, bias)) = Solution.Solve();

        // apply the necessary engineering to our original data
        // let engineeredData = Mapped(FeaturesPreprocess(engineeringMode, engineeringParameters, _), features);
        let engineeredData = Mapped(FeaturesPreprocess(engineeringMode, engineeringParameters, _), features);

        // classify the data using the model/parameters provided by the solution
        let model = SequentialModel(ClassifierStructure(), parameters, bias);
        let probabilities = EstimateClassificationProbabilities(
            tolerance, model,
            engineeredData, nMeasurements
        );
        return InferredLabels(model::Bias, probabilities);
    }


    // ------------------------------------------------------
    // Call this operation from the classical driver which reads the data
    operation TestOperation (features : Double[][], labels : Int[]) : Bool {
        // get the solution's model (don't pass any parameters to the solution)
        let ((engineeringMode, engineeringParameters), classifierStructure, (modelParameters, bias)) = Solution.Solve();

        // apply the necessary engineering to our original data
        let engineeredData = Mapped(FeaturesPreprocess(engineeringMode, engineeringParameters, _), features);

        // get the final data and combine it with labels
        let data = Mapped(
            LabeledSample,
            Zip(engineeredData, labels)
        );
        let N = Length(data);

        // classify the data using the model/parameters provided by the solution
        let model = SequentialModel(classifierStructure, modelParameters, bias);
        let tolerance = 0.005;
        let nMeasurements = 10000;
        let results = ValidateSequentialClassifier(
            model,
            data,
            tolerance,
            nMeasurements,
            SamplingSchedule([0 .. N - 1])
        );

        let errorRate = IntAsDouble(results::NMisclassifications) / IntAsDouble(N);

        // we don't require perfect results, but a low enough error rate
        let threshold = 0.05;
        if (errorRate > threshold) {
            // we can offer debug message here, since we know the test will fail regardless of it
            Message($"Error rate {errorRate} above threshold {threshold}");
        }
        return errorRate < threshold;
    }

    operation TestOperation_params (features : Double[][], labels : Int[],
            engineeringMode: Int,
            engineeringParameters: Double[]
        ) : (Bool, Double) {
        // get the solution's model (don't pass any parameters to the solution)
        let ((_a, _b), classifierStructure, (modelParameters, bias)) = Solution.Solve();

        // apply the necessary engineering to our original data
        let engineeredData = Mapped(FeaturesPreprocess(engineeringMode, engineeringParameters, _), features);

        // get the final data and combine it with labels
        let data = Mapped(
            LabeledSample,
            Zip(engineeredData, labels)
        );
        let N = Length(data);

        // classify the data using the model/parameters provided by the solution
        let model = SequentialModel(classifierStructure, modelParameters, bias);
        let tolerance = 0.005;
        let nMeasurements = 10000;
        let results = ValidateSequentialClassifier(
            model,
            data,
            tolerance,
            nMeasurements,
            SamplingSchedule([0 .. N - 1])
        );

        let errorRate = IntAsDouble(results::NMisclassifications) / IntAsDouble(N);

        // we don't require perfect results, but a low enough error rate
        let threshold = 0.05;
        if (errorRate > threshold) {
            // we can offer debug message here, since we know the test will fail regardless of it
            Message($"Error rate {errorRate} above threshold {threshold}");
        } else {
            Message($"Error rate {errorRate} below threshold {threshold}");
        }
        // return errorRate < threshold;
        return (errorRate < threshold, errorRate);
    }
}
