"""
halfmoon data: 137 training, 15 validation
"""
import json
import math
import random
import sys
from pprint import pformat

import numpy as np
import matplotlib.pyplot as plt
import matplotlib.colors as colors
import matplotlib.cm as cmx
plt.style.use('ggplot')

import qsharp
qsharp.packages.add("Microsoft.Quantum.MachineLearning::0.11.2004.2825")
qsharp.reload()

from Microsoft.Quantum.Problem import TestOperation, ClassifyModel, TrainModel, ValidateModel


# Plotting configuration
# We'll plot four cases:
# - actually 0, classified as 0
# - actually 0, classified as 1
# - actually 1, classified as 1
# - actually 1, classified as 0
cases = [(0, 0), (0, 1), (1, 1), (1, 0)]
markers = [
    '.' if actual == classified else 'X'
    for (actual, classified) in cases
]
colormap = cmx.ScalarMappable(colors.Normalize(vmin=0, vmax=len(cases) - 1))
colors = [colormap.to_rgba(idx_case) for (idx_case, case) in enumerate(cases)]
# colors = ['blue', 'blue', 'red', 'red']

def finish_alert():
    import winsound
    import time
    for _ in range(3):
        winsound.Beep(500,200)
        time.sleep(0.01)

def plot_data (features : list, actual_labels : list, classified_labels : list = None,
               extra_lines : list = None, normalize=False):
    """Plots the data, labeling it with actual labels if there are no classification results provided, 
    and with the classification results (indicating their correctness) if they are provided.
    """
    samples = np.array(features)
    if normalize:
        norms = np.linalg.norm(samples, axis=1)
        l=[]
        for i, s in enumerate(samples):
            l.append(s/norms[i])
        samples = np.array(l)
        
    plt.figure(figsize=(8, 8))
    for (idx_case, ((actual, classified), marker, color)) in enumerate(zip(cases, markers, colors)):
        mask = np.logical_and(np.equal(actual_labels, actual), 
                              np.equal(actual if classified_labels == None else classified_labels, classified))
        if not np.any(mask): continue
        plt.scatter(
            samples[mask, 0], samples[mask, 1],
            label = f"Class {actual}" if classified_labels == None else f"Was {actual}, classified {classified}",
            marker = marker, s = 300, c = [color],
        )
    # Add the lines to show the true classes boundaries, if provided
    if extra_lines != None:
        for line in extra_lines:
            plt.plot(line[0], line[1], color = 'gray')
    plt.legend()

if __name__ == "__main__":
    # fname = 'training_data1.json'
    # fname = 'training_data2.json'
    # fname = 'training_data3.json'
    # fname = 'training_data4.json'
    # fname = 'training_data5.json'
    fname = 'training_data6.json'
    train_fname = "mytrainingdata200.json"
    train_fname = "mytrainingdata400.json"
    train_fname = "mytrainingdata1600.json"
    valid_fname = "mytrainingdata1600.json"
    # valid_fname = "training_data7.json"
    # train_fname = 'training_data7.json'
    with open(train_fname) as f:
        data = json.load(f)
    num_data_points = -1
    num_near_boundary = 150
    num_other = 150
    start = 0
    training_feats = data["Features"]
    training_labels = data["Labels"]
    
    tmp = list(zip(training_feats, training_labels))
    random.shuffle(tmp)
    training_feats, training_labels = zip(*tmp)
    training_feats = list(training_feats)
    training_labels = list(training_labels)

    r = 0.25
    near_boundary = [[], []]
    other = [[], []]
    for i in range(len(training_feats)):
        x, y = training_feats[i]
        if -0.1 < x**2 - y**2 + r**2 < 0.1:
            near_boundary[0].append([x, y])
            near_boundary[1].append(training_labels[i])
        else:
            other[0].append([x, y])
            other[1].append(training_labels[i])
    # plot_data(near_boundary[0][:num_near_boundary], near_boundary[1][:num_near_boundary])
    # plot_data(other[0][:num_near_boundary], other[1][:num_near_boundary])
    
    training_feats = near_boundary[0][:num_near_boundary] + other[0][:num_other]
    training_labels = near_boundary[1][:num_near_boundary] + other[1][:num_other]

    if num_data_points != -1:
        training_feats = list(training_feats)[:num_data_points]
        training_labels = list(training_labels)[:num_data_points]
    with open(valid_fname) as f:
        data = json.load(f)
    valid_feats = data["Features"]
    valid_labels = data["Labels"]
    # print("\n")
    # print(len(feats))
    # print("\n")
    # # boost our data
    # new_feats = []
    # new_labels = []
    # for i, feat in enumerate(feats):
    #     if -0.25 < feat[0] < 0.25 and 0 < feat[1] < 0.5:
    #         new_feats.append([feat[0], -feat[1]])
    #         new_labels.append(labels[i])
    #     elif labels[i] == 1 and feat[0] < -0.5:
    #         new_feats.append([feat[0], -feat[1]])
    #         new_labels.append(labels[i])
    # feats = new_feats + feats
    # labels = new_labels + labels
    # print("\n")
    # print(len(feats))
    # print("\n")

    # shuffle our new data
    # tmp = list(zip(feats, qqlabels))
    # random.shuffle(tmp)
    # feats, labels = zip(*tmp)
    # feats = list(feats)
    # labels = list(labels)

    data['TrainingData'] = {
        "Features": training_feats,
        "Labels": training_labels
    }
    data['ValidationData'] = {
        "Features": valid_feats,
        "Labels": valid_labels
    }
    # data['ValidationData'] = {
    #     "Features": data["Features"],
    #     "Labels": data["Labels"]
    # }

    # d1 and d3
    # num_gates, num_starting_points = 5, 4
    # d4 custom
    # num_gates, num_starting_points = 10, 4
    # d4 custom n=3
    num_gates, num_starting_points = 10, 15
    # half moon
    # num_gates, num_starting_points = 8, 4
    # half moon modfiied
    # num_gates, num_starting_points = 7, 4
    # half moon modfiied different
    # num_gates, num_starting_points = 9, 10
    # N = 3
    # num_gates, num_starting_points = 14, 4
    parameter_starting_points = [
        [math.pi * 2 * random.random() for _ in range(num_gates)] for __ in range(num_starting_points)
    ]
    # for sp in parameter_starting_points:
    #     for i in range(6): # force cnots
    #         sp[i] = math.pi 

    # override 
    parameter_starting_points = [
        # [4.5174503241617385,4.131931839709061,0.898496272917857,1.394999207152873,2.7266427306592935,2.7426381053771256,2.4601471375603756,3.4212828205223476,3.6227987037909513,2.809494758636318]
        [3.6044908621217573,4.9157658869032295,4.338500781637337,5.167303114267877,0.23636764210777347,2.4417917393399917,0. ,2.2572489125567308,  3.3058205779995875, 5.4]
    ]
    # for j in range(len(parameter_starting_points)):
    #     for i in range(len(parameter_starting_points[j])):
    #         parameter_starting_points[j][i] += random.uniform(-0.75, 0.75)


    # for i in range(len(ref)):
    #     n = ref[:]
    #     n[i] = 0.
    #     parameter_starting_points.append(n)
    

    pre_mode = 1
    pre_params = [0., 0., 0., 0., 0.25, 0.25]
    pre_params = [0., 0., 0., 0., 0.3, 0.3]

    # pre_mode = 2
    # pre_params = [1., 1., 1., 1.]

    # pre_mode = 3
    # pre_params = [1., 0.]

    # pre_mode = 4
    # pre_params = [1., 1., 1.]

    train = len(sys.argv) == 1

    if train:
        (parameters, bias) = TrainModel.simulate(
            trainingVectors=data['TrainingData']['Features'],
            trainingLabels=data['TrainingData']['Labels'],
            engineeringMode=pre_mode,
            engineeringParameters=pre_params,
            initialParameters=parameter_starting_points
        )
    else:
        (parameters, bias) = ([3.6044908621217573,4.9157658869032295,4.338500781637337,5.167303114267877,0.23636764210777347,2.4417917393399917,5.872063577438946,2.6692004110438896,3.3058205779995875, 0.05], -0.061849357878)


    # miss_rate = ValidateModel.simulate(
    #     validationVectors=data['ValidationData']['Features'],
    #     validationLabels=data['ValidationData']['Labels'],
    #     parameters=parameters, bias=bias
    # )

    # print(f"Miss rate: {miss_rate:0.2%}")
    
    extra_lines = []
    extra_lines.append([[-1., 1.], [-1., 1.]])
    extra_lines.append([[-1., 1.], [1., -1.]])
    print('\n')
    # for i, theta in enumerate(np.linspace( 2., 2.771746737670192, 10)):
    # for i, p in enumerate([0.25, 0.3]):
            # 6: 5.872063577438946
            # 7: 2.6692004110438896
            # 8: 3.3058205779995875

            # bias: -0.061849357878
    # pre_params = [0., 0., 0., 0., p, p]
    
    (parameters, bias) = ([3.6044908621217573,4.9157658869032295,4.338500781637337,5.167303114267877,0.23636764210777347,2.4417917393399917,0 ,2.2572489125567308,  3.3058205779995875, 5.4], -0.061849357878)
    # print(i+1, theta)
    # Classify the validation so that we can plot it.
    actual_labels = data['ValidationData']['Labels']
    classified_labels = ClassifyModel.simulate(
        features=data['ValidationData']['Features'],
        engineeringMode=pre_mode,
        engineeringParameters=pre_params,
        parameters=parameters, bias=bias,
        tolerance=0.005, nMeasurements=10_000
    )
    plot_data(data['ValidationData']['Features'], actual_labels, classified_labels=classified_labels, extra_lines=extra_lines)

    plot_data(data['TrainingData']['Features'], data['TrainingData']['Labels'], extra_lines=extra_lines)


    # operation TestOperation (features : Double[][], labels : Int[]) : Bool {
    # b = TestOperation.simulate(features=feats, labels=labels)


    
    # extra_lines.append([[0.5, 0.5], [0, 1]])
    # if True:
        # plot_data(feats, labels, extra_lines = extra_lines, normalize=True)
    

    # # feats_normalised = [[a/]]
    # if True:
    #     # for m, ps in [(0, [0.]), (1, [0.]), (1, [0., 0.])]:
    #     for m, ps in [(1, [.25]), (1, [10]), (1, [20]), (1, [30]), (1, [40]), (1, [50]), (1, [100])]:
    #         # Classify the validation so that we can plot it.
    #         actual_labels = labels
    #         # operation ClassifyModel(features : Double[][], tolerance  : Double, nMeasurements : Int,
    #         #                         mode_overide: Int, params_override: Double[])
    #         classified_labels = ClassifyModel.simulate(features=feats,
    #             tolerance=0.005, nMeasurements=10_000,
    #             mode_overide=m, params_override=ps
    #         )
    #         # Draw shit
    #         plot_data(feats, labels, classified_labels=classified_labels, extra_lines = extra_lines)
    if train:
        finish_alert()
    plt.show()
