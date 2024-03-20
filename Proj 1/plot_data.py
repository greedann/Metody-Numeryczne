import pandas as pd
import matplotlib.pyplot as plt
from datetime import datetime


def main(stocs_name):
    # Load the data
    data = pd.read_csv('data/daily_' + stocs_name +
                       '_with_macd_and_buy_sell.csv')

    # take the last 1000 rows of the data
    data = data.tail(1000)

    # to plot buy and sell signals with enhanced macd
    sell = data[data['Sell1'] == 1]
    buy = data[data['Buy1'] == 1]
    # to plot buy and sell signals with simple macd
    # sell = data[data['Sell'] == 1]
    # buy = data[data['Buy'] == 1]
    sell_line_color = 'red'
    buy_line_color = 'green'

    dates = [datetime.strptime(d, '%Y-%m-%d') for d in data['timestamp']]
    sales = [datetime.strptime(d, '%Y-%m-%d') for d in sell['timestamp']]
    buys = [datetime.strptime(d, '%Y-%m-%d') for d in buy['timestamp']]

    # plot high values from the date
    plt.plot(dates, data['close'], label="Cost")
    plt.plot(dates, data['MACD'], label="MACD")
    plt.plot(dates, data['Signal Line'], label="Signal Line")

    # plot the buy and sell signals
    plt.scatter(sales, sell['close'], color=sell_line_color, label="Sell")
    plt.scatter(buys, buy['close'], color=buy_line_color, label="Buy")

    # set size of the plot
    plt.gcf().set_size_inches(15, 8)
    plt.xlabel('Date')
    plt.ylabel('Close')
    plt.title('Value of '+stocs_name+' stock and MACD indicator')
    plt.legend()
    plt.xticks(rotation=90)
    plt.subplots_adjust(bottom=0.25)
    plt.show()

    # to save the plot uncomment the next line
    # plt.savefig('graphics/daily_' + stocs_name + '_with_buy_sell_1000.png')
    plt.close()


stocs = ['BP', 'INTC']

for stoc in stocs:
    main(stoc)
