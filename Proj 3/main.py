import os
import pandas as pd
from matplotlib import pyplot as plt
from lagrange_interpolation import lagrange_interpolation
from spline import cubic_spline
import glob

data_dir = 'data'


def load_data(filename):
    return pd.read_csv(filename)


def ploat_data(data, x, y, interpolation_y, title):
    plt.figure(figsize=(10, 5))
    plt.plot(data['Distance'], data['Height'], label='Original data')
    plt.scatter(x, y, label='Interpolation points')
    plt.plot(data['Distance'], interpolation_y, label='Interpolation')
    plt.xlabel('Distance')
    plt.ylabel('Height')
    plt.legend()
    plt.title(title)
    plt.grid(True)
    plt.show()


files = glob.glob(os.path.join(data_dir, '*.csv'))

for file in files:
    print(f"Processing file: {file}")
    data = load_data(file)[50:151]
    data.reset_index(drop=True, inplace=True)

    # interpolation_data = []
    # interpolation_data.append(data.loc[0])
    # range_ = max(data['Height']) - min(data['Height'])
    # for i in range(1, len(data)):
    #     if i != len(data) - 1:
    #         if abs(data.loc[i]['Height'] - interpolation_data[-1]['Height']) > range_ / 20:
    #             interpolation_data.append(data.loc[i+1])
    #     else:
    #         interpolation_data.append(data.loc[i])
    # interpolation_data = pd.DataFrame(interpolation_data)

    interpolation_data = data[::5]

    x = interpolation_data["Distance"].copy().reset_index(drop=True)
    y = interpolation_data["Height"].copy().reset_index(drop=True)

    interpolate_y = lagrange_interpolation(data['Distance'], x, y)

    ploat_data(data, x, y, cubic_spline(
        data['Distance'], x, y), f"Cubic Spline, Points amound: {len(x)}")
    ploat_data(data, x, y, interpolate_y, f"Lagrange interpolation, Points amound: {len(x)}")
