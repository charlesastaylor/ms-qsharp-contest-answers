parameter_starting_points = [
        [3.480965715514704,4.7581685219101955,8.879696589341014,3.549990155550857,9.903061332668932,7.968925281946429,6.474576274489208,6.662604972791635]
    ]
for i in range(len(parameter_starting_points[0])):
    n = parameter_starting_points[0][:]
    n[i] = 0.
    parameter_starting_points.append(n)
from pprint import pformat
print(pformat(parameter_starting_points))