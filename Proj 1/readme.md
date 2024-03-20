# Project 1 numerical methods
## MACD stock market indicator

The project is written with the purpose of studying to analyze MACD stock market indicator.

The application calculates MACD parameters for a specific financial instrument and also calculates the profit made on investments based only on this instrument. There is also an algorithm that uses additional conditions to calculate buy and sell points. A more precise description is available in the file Sprawozdanie.pdf.

## Usage

First install all dependencies for aplication with command:
```bash
$ pip install -r requirements.txt 
```

Than to calculate buy and sell signals for stocks, replace the value of the variable "stocs_name" with the desired value in the data.py file. Data for the following stocks are available in the repository:
* BP
* INTC

Then run the data.py file with the command
``` bash
$ python data.py
```
The console will display the results for invistions and will also create files with calculated buy and sell signals. To visualize this data replace the value of the variable "stocs" with the desired value in the plot_data.py file and run the command 

``` bash
$ python plot_data.py
```

You will see charts for the selected stocks.

## Get data for another stocs

To download data from the web about special stocks replace the symbol in the following link with the stock you want to download:
https://www.alphavantage.co/query?function=TIME_SERIES_DAILY&symbol=NVDA&apikey=PS7LZX18M6RJOI7R&datatype=csv&outputsize=full)

Documentation about the API can be found at:
[Documentation](https://www.alphavantage.co/documentation/)