import pandas as pd


def calculate_macd(data):
    # Calculate the MACD and signal line indicators
    # Calculate the short term exponential moving average (EMA)
    ShortEMA = data['close'].ewm(span=12, adjust=False).mean()
    # Calculate the long term exponential moving average (EMA)
    LongEMA = data['close'].ewm(span=26, adjust=False).mean()
    # Calculate the MACD line
    MACD = ShortEMA - LongEMA
    # Calculate the signal line
    signal = MACD.ewm(span=9, adjust=False).mean()

    # Create new columns for the data
    data['MACD'] = MACD
    data['Signal Line'] = signal

    return data


def calculate_buy_sell_signals(data):
    delta = data['MACD'] - data['Signal Line']

    # Calculate the buy and sell signals
    buy = []
    sell = []
    buy.append(None)
    sell.append(None)
    for i in range(1, len(delta)):
        if delta[i] > 0:
            if delta[i-1] < 0:
                buy.append(1)
                sell.append(None)
            else:
                buy.append(None)
                sell.append(None)
        else:
            if delta[i-1] > 0:
                buy.append(None)
                sell.append(1)
            else:
                buy.append(None)
                sell.append(None)

    # Create new columns for the data
    data['Buy'] = buy
    data['Sell'] = sell

    return data


def save_data(data, filename):
    data.to_csv(filename, index=False)

def calculate_income(data, start_shares, start_cash):
    # calculate the income
    start_capital = start_shares * data['close'][0] + start_cash
    cash = start_cash
    shares = start_shares

    for i in range(len(data)):
        if data['Buy'][i] and cash > 0:
            shares = cash / data['close'][i]
            cash = 0
        elif data['Sell'][i] == 1 and shares > 0:
            cash = shares * data['close'][i]
            shares = 0

    end_capital = cash + shares * data['close'][len(data)-1]
    print("Start date: ", data['timestamp'][0])
    print("End date: ", data['timestamp'][len(data)-1])
    print("Start capital: ", start_capital)
    print("End capital: ", end_capital)
    print("Profit: ", end_capital - start_capital)
    return start_capital, end_capital


stocs_name = 'NVDA'
filename = 'data/daily_' + stocs_name + '.csv'
# Load the data
data = pd.read_csv(filename)

# reverse the data
data = data.iloc[::-1].copy()
# reset the index
data.reset_index(inplace=True, drop=True)

data = calculate_macd(data)
data = calculate_buy_sell_signals(data)
save_data(data, 'data/daily_' + stocs_name + '_with_macd_and_buy_sell.csv')

start_shares = 0
start_cash = 1000
start_capital, end_capital = calculate_income(data, start_shares, start_cash)
