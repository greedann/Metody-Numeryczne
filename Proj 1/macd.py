import pandas as pd

# Load the data
data = pd.read_csv('daily_NVDA.csv')

# take the first 1000 rows of the data
data = data.head(1001)

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

save = data.to_csv('daily_NVDA_with_macd.csv', index=False)

