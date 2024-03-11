import pandas as pd
import matplotlib.pyplot as plt
import matplotlib.ticker as ticker

# Load the data
data = pd.read_csv('daily_NVDA_with_macd.csv')

# take the first 1000 rows of the data
data = data.head(1001)
# data['MACD'] = data['MACD'] * 10+300
# data['Signal Line'] = data['Signal Line'] * 10 + 300

# plot high values from the date in reversed order
plt.plot(data['timestamp'], data['high'], label = "Cost")
plt.plot(data['timestamp'], data['MACD'], label = "MACD")
plt.plot(data['timestamp'], data['Signal Line'], label = "Signal Line")
plt.gca().invert_xaxis()
plt.xlabel('Date')
plt.ylabel('High')
plt.title('High value of NVDA stock')
plt.legend()
locator = ticker.MultipleLocator(30)
plt.gca().xaxis.set_major_locator(locator)
plt.xticks(rotation=90)
plt.subplots_adjust(bottom=0.25)
plt.show()

