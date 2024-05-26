def lagrange_interpolation(x0, x,y):
    def L(i, x0, x):
        res = 1
        for j in range(len(x)):
            if j != i:
                res *= (x0 - x[j]) / (x[i] - x[j])
        return res

    res = 0
    for i in range(len(y)):
        res += y[i] * L(i, x0, x)
    return res
