# Load libraries
library(readr)
library(dplyr)
library(tidyr)

# Read dataset 
data <- read_csv("C:\\Users\\User\\Desktop\\CentralBankDashboard\\Downloaded Dataset.csv", skip = 4)

# Filter essential Central Bank related indicators
essential_data <- data %>%
  filter(`Indicator Name` %in% c(
    "Inflation, consumer prices (annual %)",
    "GDP growth (annual %)",
    "Money supply, M2 (% of GDP)",
    "Real interest rate (%)",
    "Lending interest rate (%)",
    "Deposit interest rate (%)",
    "Official exchange rate (LCU per US$, period average)",
    "Foreign direct investment, net inflows (% of GDP)",
    "Current account balance (% of GDP)",
    "Unemployment, total (% of total labor force)"
  ))

# Convert to tidy format: columns = Indicator Name, rows = Year, values = indicator values
clean_data <- essential_data %>%
  pivot_longer(
    cols = starts_with("19") | starts_with("20"),
    names_to = "Year",
    values_to = "Value"
  ) %>%
  select(`Indicator Name`, Year, Value) %>%
  mutate(Year = as.numeric(Year)) %>%
  pivot_wider(
    names_from = `Indicator Name`,
    values_from = Value
  ) %>%
  arrange(Year)

# Save cleaned dataset
write_csv(clean_data, "Cleaned Dataset.csv")

# Load libraries
library(ggplot2)
library(zoo)

# Read your cleaned dataset
data <- read_csv("C:\\Users\\User\\Desktop\\CentralBankDashboard\\Cleaned Dataset.csv")

# Interpolate missing values for each indicator (linear interpolation)
data_filled <- data %>%
  arrange(Year) %>%
  mutate(across(-Year, ~ na.approx(., Year, na.rm = FALSE)))

# Central Bank Indicator Dashboard (Shiny)


# Load required libraries
library(shiny)


#  Load and prepare data
data <- read_csv("C:\\Users\\User\\Desktop\\CentralBankDashboard\\Cleaned Dataset.csv")

# Create a list of available indicators
indicator_list <- colnames(data)[-1]  # Exclude "Year"

#  Build the User Interface
ui <- fluidPage(
  titlePanel("Central Bank Indicators Dashboard - Sri Lanka"),
  sidebarLayout(
    sidebarPanel(
      selectInput(
        "indicator",
        "Select Indicator:",
        choices = indicator_list,
        selected = "GDP growth (annual %)"
      ),
      checkboxInput("showInterpolated", "Show interpolated trend", TRUE),
      hr(),
      helpText("Missing data are filled only for visualization (not saved).")
    ),
    
    mainPanel(
      plotOutput("indicatorPlot", height = "500px"),
      hr(),
      tableOutput("dataTable")
    )
  )
)

#  Define Server Logic
server <- function(input, output) {
  
  # Reactive data for plotting
  plot_data <- reactive({
    df <- data %>% arrange(Year)
    if (input$showInterpolated) {
      df <- df %>%
        mutate(across(-Year, ~ na.approx(., Year, na.rm = FALSE)))
    }
    df
  })
  
  # Plot the selected indicator
  output$indicatorPlot <- renderPlot({
    df <- plot_data()
    
    ggplot(df, aes(x = Year, y = .data[[input$indicator]])) +
      geom_line(color = "#0072B2", size = 1.2) +
      geom_point(color = "#E69F00", size = 2) +
      theme_minimal(base_size = 14) +
      labs(
        title = paste("Trend of", input$indicator),
        x = "Year",
        y = "Value"
      )
  })
  
  # Show a small data preview table
  output$dataTable <- renderTable({
    data %>%
      select(Year, all_of(input$indicator)) %>%
      tail(15)
  })
}

#  Run the Application
shinyApp(ui = ui, server = server)
