# 🏦 Central Bank Dashboard (Sri Lanka)

This project is an **interactive Shiny dashboard** built in **R** to visualize and analyze key macroeconomic indicators related to the **Central Bank of Sri Lanka**.  
It uses data obtained from the **World Bank API**, focusing on important indicators such as GDP growth, inflation, interest rates, money supply, and exchange rates.

---

## Features

- Interactive selection of economic indicators  
- Dynamic line plots for year-wise trends  
- Option to interpolate missing values (for smoother visualization only)  
- Clean and modern Shiny dashboard layout  
- Data visualization using `ggplot2`  
- Built entirely in **R**

---

##  Dataset Information

The dataset used here is a cleaned version of World Bank economic data for Sri Lanka.  
It includes yearly data for multiple indicators such as:

- GDP growth (annual %)
- Inflation (consumer prices, %)
- Broad money growth (M2, %)
- Interest rate (lending rate, %)
- Exchange rate (LKR per USD)

File used:  
clean_centralbank_indicators2.csv

If you want to explore your own indicators, you can download the data directly from the [World Bank Data Portal](https://data.worldbank.org/).

---

##  Requirements

Make sure you have **R** and **RStudio** installed.  
Then, install the following packages before running the app:

`r
install.packages(c("shiny", "dplyr", "ggplot2", "tidyr", "zoo", "readr"))

## How to Run the App

Download or clone this repository:
git clone https://github.com/madusha-projects/CentralBankDashboard.git

Open the project folder in RStudio.

Run the app:

library(shiny)
runApp("app.R")


The dashboard will open in your web browser.

## How It Works

The app loads cleaned indicator data from the CSV file.

Users select an indicator from the dropdown menu.

The Shiny server dynamically filters and plots the selected indicator by year.

Missing values are optionally filled using linear interpolation (zoo::na.approx).

A simple table shows the most recent data for the selected indicator.


##  Technologies Used

R (Programming Language)

Shiny (Web Dashboard Framework)

ggplot2 (Data Visualization)

dplyr / tidyr (Data Wrangling)

zoo (Interpolation for missing values)

## Future Improvements

Add comparison of multiple indicators on the same graph

Include summary statistics and correlation analysis

Add export/download options for users

Deploy live app using shinyapps.io

## Author

Madusha Dilrukshi
BSc (Hons) in Financial Mathematics and Industrial Statistics
Individual Project – Central Bank Indicators Dashboard
University Project using R and Shiny

## License

This project is open-source under the MIT License
.
You are free to use, modify, and share it with proper attribution.

## Acknowledgments

World Bank Open Data for providing the dataset

RStudio for the development environment

The Central Bank of Sri Lanka for the research inspiration
