import pandas as pd
import matplotlib.pyplot as plt
from datetime import datetime

# Load the data
stocs_name = 'AAPL'
data = pd.read_csv('data/daily_' + stocs_name + '_with_macd_and_buy_sell.csv')

# take the last 1000 rows of the data
# data = data.tail(1001)
# data['MACD'] = data['MACD'] * 10+300
# data['Signal Line'] = data['Signal Line'] * 10 + 300

sell = data[data['Sell'] == 1]
buy = data[data['Buy'] == 1]
sell_line_color = 'red'
buy_line_color = 'green'

dates = [datetime.strptime(d, '%Y-%m-%d') for d in data['timestamp']]
sales = [datetime.strptime(d, '%Y-%m-%d') for d in sell['timestamp']]
buys = [datetime.strptime(d, '%Y-%m-%d') for d in buy['timestamp']]

# plot high values from the date in reversed order
plt.plot(dates, data['close'], label="Cost")
plt.plot(dates, data['MACD'], label="MACD")
plt.plot(dates, data['Signal Line'], label="Signal Line")

plt.axvline(x=sales[0], color=sell_line_color,
            linestyle='dashed', linewidth=1, label="Sell")
for i in range(1, len(sales)):
    plt.axvline(x=sales[i], color=sell_line_color,
                linestyle='dashed', linewidth=1)

plt.axvline(x=buys[0], color=buy_line_color,
            linestyle='dashed', linewidth=1, label="Buy")
for i in range(1, len(buys)):
    plt.axvline(x=buys[i], color=buy_line_color,
                linestyle='dashed', linewidth=1)


plt.xlabel('Date')
plt.ylabel('Close')
plt.title('Value of '+stocs_name+' stock and MACD indicator')
plt.legend()
plt.xticks(rotation=90)
plt.subplots_adjust(bottom=0.25)
plt.show()
