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


def trend(prices, period=14):
    if len(prices) < period:
        return "neutral"
    sma = sum(prices[-period:]) / period
    if prices.iloc[-1] > sma:
        return "up"
    elif prices.iloc[-1] < sma:
        return "down"
    else:
        return "neutral"


def calculate_buy_sell_signals(data):
    # Calculate the buy and sell signals using the MACD and signal line and the trend data with spike tracking
    delta = data['MACD'] - data['Signal Line']
    trend_data = [trend(data["close"][:i]) for i in range(len(data["close"]))]

    buy_signal = []
    sell_signal = []
    currently_selled = True

    for i in range(len(data)):
        if data['MACD'].iloc[i] > data['Signal Line'].iloc[i] and trend_data[i] == "up" and currently_selled:
            buy_signal.append(1)
            currently_selled = False
        elif data['close'].iloc[i] < 0.95 * data['close'].iloc[i-1] and currently_selled:
            buy_signal.append(1)
            currently_selled = False
        else:
            buy_signal.append(None)

        if data['MACD'].iloc[i] < data['Signal Line'].iloc[i] and trend_data[i] == "down" and not currently_selled:
            sell_signal.append(1)
            currently_selled = True
        elif data['close'].iloc[i] > 1.05 * data['close'].iloc[i-1] and not currently_selled:
            sell_signal.append(1)
            currently_selled = True
        else:
            sell_signal.append(None)

    # Create new columns for the data
    data['Buy1'] = buy_signal
    data['Sell1'] = sell_signal

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
    # calculate the income for simple macd and buy sell signals
    start_capital = start_shares * data['close'][0] + start_cash
    cash = start_cash
    shares = start_shares

    for i in range(len(data)):
        if data['Buy'][i] == 1 and cash > 0:
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

    # calculate the income for enhanced macd and buy sell signals
    print("\nIncome using trend data")

    cash = start_cash
    shares = start_shares
    for i in range(len(data)):
        if data['Buy1'][i] == 1 and cash > 0:
            shares = cash / data['close'][i]
            cash = 0
        elif data['Sell1'][i] == 1 and shares > 0:
            cash = shares * data['close'][i]
            shares = 0

    end_capital = cash + shares * data['close'][len(data)-1]
    print("End capital: ", end_capital)
    print("Profit: ", end_capital - start_capital)


stocs_name = 'BP'
filename = 'data/daily_' + stocs_name + '.csv'
# Load the data
data = pd.read_csv(filename)

# to take the last 2000 rows of the data uncomment the next line
# data = data.head(2000)
# reverse the data
data = data.iloc[::-1].copy()
# reset the index
data.reset_index(inplace=True, drop=True)

data = calculate_macd(data)
data = calculate_buy_sell_signals(data)
save_data(data, 'data/daily_' + stocs_name + '_with_macd_and_buy_sell.csv')

start_shares = 0
start_cash = 1000
calculate_income(data, start_shares, start_cash)
