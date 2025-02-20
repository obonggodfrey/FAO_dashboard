library(shiny)
library(DT)
library(shinydashboard)
library(tidyverse)
library(shinya11y)
library(learnr)
library(plotly)
library(gradethis)
library(scales)
library(dplyr)
library(rsconnect)





ui <- dashboardPage(
  skin = "green",
  
  #dashboardHeader(title = span(icon("seedling"),HTML("<b>FAO</b>"), style="color: #ffffff; background-color: #008a45;", alt = "Company Logo")),
  

  dashboardHeader(title = span(
    img(src = "logo1.png", height = 30, alt = "Company Logo"),
    HTML("<b style='color: #ffffff;'>FAO</b>"),
    style = "background-color: #008a45; display: flex; align-items: center; gap: 10px;"
  )),
  #dashboardHeader(
  # title = div(
  #    tags$img(src = "logo1", height = "40px", alt = "Company Logo", style="color: #ffffff"),
  #    "FAO"
  #  ),
  #  titleWidth = 250
  #),
  dashboardSidebar(
    sidebarMenu(
      id = "sidebar",
      menuItem(text = "Summary", icon=icon("home"), tabName = "summary", selected = TRUE),
      tags$br(),
      menuItem(text = "Visualization", icon=icon("image"), tabName = "plots"),
      tags$br(),
      menuItem(text = "Data Table",icon=icon("table"),tabName = "table"),
      tags$br(),
      menuItem(text="FAQ", icon=icon("question-circle"), tabName="FAQ"),
      tags$br(),tags$br(),tags$br(),tags$br(),tags$br(),tags$br(),tags$br(),tags$br(),
      tags$img(src="https://www.strath.ac.uk/media/1newwebsite/documents/brand/strath_main.jpg",
               alt="University of Strathclyde Faculty of Science logo (smaller)",
               width="200px",height="100px")
    )
  ),
  
  dashboardBody(
    use_tota11y(),
    
    tags$html(lang="en"),
    
    tags$head(
      tags$title("FAO"),
      
      tags$style(HTML("
      
        .content-wrapper {
        background-color: #e6ffee !important; /* Background color */
        color: #112A46 !important; /* Text color */
        }
        
        .tota11y-label-text {
        font-size: 1.5em;  /* Similar to h2 */
        font-weight: bold;
        }
        
        .small-box {
          min-height: 80px !important;  /* Adjust height */
          font-size: 22px !important;  /* Adjust text size */
        }
        
        .content-wrapper .content h1,
        .content-wrapper .content h2 {
          font-weight: bold !important;  /* Makes tab headers bold */
        }
        .small-box .inner {
          padding: 10px;  /* Adjust padding */
        }

        .content-wrapper, .right-side {
        min-height: 100vh !important; /* Ensure full height */
        overflow-x: hidden; /* Prevent horizontal scrolling */
        }
        .skin-blue .main-sidebar {
          background-color: #0e1f17;
        }
        #stacked_bar_chart img {
          border: 5px solid black;
        }
        
        /* Value Box Styling */
        .small-box {
        background-color:#048049  !important; /* Value Box Background */
        color: #ffffff !important; /* Value Box Text Color */
        }
        
        .custom-box {
        background-color: #80ffa8 !important;  /* Light Orange */
        color: black !important;  /* Text color */
        border-radius: 10px;  /* Rounded corners */
        padding: 15px;
        }
        
        /* Make sidebar menu items bold */
        .sidebar-menu > li > a {
        font-weight: bold !important;
        }
        
        /* Increase the font size of main menu items */
        .sidebar-menu > li > a {
        font-size: 18px !important; /* Adjust size as needed */
        font-weight: bold !important;
        }
        
        /* Change the background color of the box title */
        .box-header {
        background-color: #ffffff !important; /* Change to your preferred color */
        color: #171145 !important; /* Change text color */
        padding: 10px !important; /* Adjust spacing */
        border-radius: 5px 5px 0px 0px !important; /* Rounded corners */
        }
       
        .custom-title {
        text-align: center;  /* Centers the text */
        white-space: normal; /* Allows text wrapping */
        word-wrap: break-word; /* Breaks long words */
        max-width: 80%; /* Optional: Restricts width for better readability */
        margin: auto; /* Centers the block itself */
        }
        
        .skin-green .main-header .logo{
        color: black;
        }
        
        .skin-green .main-header .navbar .sidebar-toggle {
        color: black;
        }
        
        .btn, .form-control {
        min-height: 44px; /* Ensures sufficient touch area */
        padding: 10px; 
        }
        
      "))
    ),
    
    tabItems(
      
      tabItem(
        tabName = "summary",
        tags$h1("SUMMARY METRICS"),
        HTML("<P>The FAO tracks the annual production, domestic supply and nutritional value of food sources across the globe to describe the food security of the population.</p>"),
        HTML("<p>The tabs indicated on this page are selected indicators that reflecting annual values that can be tracked by country and specific Item. <strong>All variables are given in units of 1000 tonnes</strong>"),
        # Filters
        tags$h2("FILTERS"),

      
        fluidRow(
          
          column(width = 4,selectInput("selected_country1", tags$span("Select Area/Country"), choices = c("Afghanistan", "Albania", "Algeria", "Angola", "Antigua and Barbuda", "Argentina", "Armenia", "Australia", "Austria", "Azerbaijan", "Bahamas", "Bahrain", "Bangladesh", "Barbados", "Belarus", "Belgium", "Belize", "Benin", "Bhutan", "Bolivia (Plurinational State of)", "Bosnia and Herzegovina", "Botswana", "Brazil", "Bulgaria", "Burkina Faso", "Burundi", "Cabo Verde", "Cambodia", "Cameroon", "Canada", "Central African Republic", "Chad", "Chile", "China", "China, Hong Kong SAR", "China, Macao SAR", "China, mainland", "China, Taiwan Province of", "Colombia", "Comoros", "Congo", "Costa Rica", "Cote d'Ivoire", "Croatia", "Cuba", "Cyprus",	"Czechia", "Democratic People's Republic of Korea", "Democratic Republic of the Congo",	"Denmark", "Djibouti", "Dominica", "Dominican Republic", "Ecuador", "Egypt", "El Salvador", "Estonia", "Eswatini", "Ethiopia", "Fiji", "Finland", "France", "French Polynesia", "Gabon", "Gambia",	"Georgia", "Germany", "Ghana", "Greece", "Grenada", "Guatemala", "Guinea", "Guinea-Bissau", "Guyana", "Haiti", "Honduras", "Hungary", "Iceland",	"India", "Indonesia", "Iran (Islamic Republic of)", "Iraq", "Ireland", "Israel", "Italy", "Jamaica", "Japan", "Jordan", "Kazakhstan", "Kenya", "Kiribati", "Kuwait", "Kyrgyzstan", "Lao People's Democratic Republic", "Latvia", "Lebanon",	"Lesotho", "Liberia", "Libya", "Lithuania", "Luxembourg", "Madagascar",	"Malawi", "Malaysia", "Maldives",	"Mali",	"Malta", "Marshall Islands", "Mauritania", "Mauritius",	"Mexico", "Micronesia (Federated States of)", "Mongolia", "Montenegro", "Morocco", "Mozambique", "Myanmar", "Namibia", "Nauru",	"Nepal", "Netherlands (Kingdom of the)", "Netherlands Antilles (former)", "New Caledonia", "New Zealand", "Nicaragua",	"Niger", "Nigeria", "North Macedonia", "Norway", "Oman", "Pakistan", "Panama", "Papua New Guinea", "Paraguay", "Peru", "Philippines", "Poland", "Portugal", "Qatar", "Republic of Korea", "Republic of Moldova", "Romania", "Russian Federation", "Rwanda", "Saint Kitts and Nevis",  "Saint Lucia", "Saint Vincent and the Grenadines", "Samoa",  "Sao Tome and Principe", "Saudi Arabia", "Senegal", "Serbia", "Seychelles", "Sierra Leone", "Slovakia", "Slovenia", "Solomon Islands", "Somalia", "South Africa", "South Sudan", "Spain", "Sri Lanka", "Sudan", "Suriname", "Sweden", "Switzerland", "Syrian Arab Republic", "Tajikistan", "Thailand", "Timor-Leste", "Togo", "Tonga", "Trinidad and Tobago", "Tunisia", "Türkiye", "Turkmenistan", "Tuvalu", "Uganda", "Ukraine", "United Arab Emirates", "United Kingdom of Great Britain and Northern Ireland", "United Republic of Tanzania", "United States of America", "Uruguay", "Uzbekistan", "Vanuatu", "Venezuela (Bolivarian Republic of)", "Viet Nam", "Yemen",	"Zambia", "Zimbabwe"))) , 
          column(width = 4, selectInput("selected_year1", tags$span("Select year"), choices = c("2010","2011","2012","2013","2014","2015", "2016", "2017", "2018", "2019", "2020", "2021", "2022"), selected="2022")),
          column(width = 4, selectInput("selected_item1", tags$span("Select Item_Group"), choices = c("Alcoholic Beverages", "Animal fats", "Animal Products", "Aquatic Products, Other", "Cereals - Excluding Beer", "Eggs", "Fish, Seafood", "Fruits - Excluding Wine", "Meat", "Milk - Excluding Butter", "Miscellaneous", "Offals", "Oilcrops", "Pulses", "Spices", "Starchy Roots", "Stimulants", "Sugar & Sweeteners", "Sugar Crops", "Treenuts", "Vegetable Oils", "Vegetables", "Vegetal Products")))
         ),
      
        
        box(
          title=tags$h2(class="box-title","Domestic supply(Production + Import - Stock - Export)"),
          width = 12,
          #background = "green",
          fluidRow(
            column(width = 12, align = "center",
                   valueBoxOutput("domestic_supply", width = 12))
          )
          
        ),
        
        
        box(
          width = 12,
          title=tags$h2(class="box-title", "Domestic supply use cases(Sum up to domestic supply)"),
          status="primary",
          solidHeader = FALSE,
          #background = "green",
          fluidRow(
            valueBoxOutput("feeds", width=3),
            valueBoxOutput("seed", width=3),
            valueBoxOutput("losses", width=3),
            valueBoxOutput("processing", width=3)
          ),
          fluidRow(
            valueBoxOutput("other_uses", width=3),
            valueBoxOutput("residual", width=3),
            valueBoxOutput("food", width=3),
            valueBoxOutput("tourist", width=3)
          )
        ),
        # Production & Import Side by Side
        box(
          width = 12,
          title=tags$h2(class="box-title", "Production, Import & Export"),
          #background = "green",
          fluidRow(
            valueBoxOutput("production", width=6),
            valueBoxOutput("import", width=6)
          )
        ),
        box(
          title=tags$h2(class="box-title","Stock variation (Production + Import - Domestic_supply - Export)"),
          width = 12,
          #background = "green",
          fluidRow(
            column(width = 12, align = "center",
                   valueBoxOutput("variation", width = 12))
          )
        )
        
      ),
      
      tabItem(
        tabName = "plots",
        tags$h2("Domestic supply per population annual trend"),
        box(width = 12,
            fluidRow(
              column(width=6,
                     selectInput("selected_country", "Select Area/Country", choices = c("Afghanistan", "Albania", "Algeria", "Angola", "Antigua and Barbuda", "Argentina", "Armenia", "Australia", "Austria", "Azerbaijan", "Bahamas", "Bahrain", "Bangladesh", "Barbados", "Belarus", "Belgium", "Belize", "Benin", "Bhutan", "Bolivia (Plurinational State of)", "Bosnia and Herzegovina", "Botswana", "Brazil", "Bulgaria", "Burkina Faso", "Burundi", "Cabo Verde", "Cambodia", "Cameroon", "Canada", "Central African Republic", "Chad", "Chile", "China", "China, Hong Kong SAR", "China, Macao SAR", "China, mainland", "China, Taiwan Province of", "Colombia", "Comoros", "Congo", "Costa Rica", "Cote d'Ivoire", "Croatia", "Cuba", "Cyprus",	"Czechia", "Democratic People's Republic of Korea", "Democratic Republic of the Congo",	"Denmark", "Djibouti", "Dominica", "Dominican Republic", "Ecuador", "Egypt", "El Salvador", "Estonia", "Eswatini", "Ethiopia", "Fiji", "Finland", "France", "French Polynesia", "Gabon", "Gambia",	"Georgia", "Germany", "Ghana", "Greece", "Grenada", "Guatemala", "Guinea", "Guinea-Bissau", "Guyana", "Haiti", "Honduras", "Hungary", "Iceland",	"India", "Indonesia", "Iran (Islamic Republic of)", "Iraq", "Ireland", "Israel", "Italy", "Jamaica", "Japan", "Jordan", "Kazakhstan", "Kenya", "Kiribati", "Kuwait", "Kyrgyzstan", "Lao People's Democratic Republic", "Latvia", "Lebanon",	"Lesotho", "Liberia", "Libya", "Lithuania", "Luxembourg", "Madagascar",	"Malawi", "Malaysia", "Maldives",	"Mali",	"Malta", "Marshall Islands", "Mauritania", "Mauritius",	"Mexico", "Micronesia (Federated States of)", "Mongolia", "Montenegro", "Morocco", "Mozambique", "Myanmar", "Namibia", "Nauru",	"Nepal", "Netherlands (Kingdom of the)", "Netherlands Antilles (former)", "New Caledonia", "New Zealand", "Nicaragua",	"Niger", "Nigeria", "North Macedonia", "Norway", "Oman", "Pakistan", "Panama", "Papua New Guinea", "Paraguay", "Peru", "Philippines", "Poland", "Portugal", "Qatar", "Republic of Korea", "Republic of Moldova", "Romania", "Russian Federation", "Rwanda", "Saint Kitts and Nevis",  "Saint Lucia", "Saint Vincent and the Grenadines", "Samoa",  "Sao Tome and Principe", "Saudi Arabia", "Senegal", "Serbia", "Seychelles", "Sierra Leone", "Slovakia", "Slovenia", "Solomon Islands", "Somalia", "South Africa", "South Sudan", "Spain", "Sri Lanka", "Sudan", "Suriname", "Sweden", "Switzerland", "Syrian Arab Republic", "Tajikistan", "Thailand", "Timor-Leste", "Togo", "Tonga", "Trinidad and Tobago", "Tunisia", "Türkiye", "Turkmenistan", "Tuvalu", "Uganda", "Ukraine", "United Arab Emirates", "United Kingdom of Great Britain and Northern Ireland", "United Republic of Tanzania", "United States of America", "Uruguay", "Uzbekistan", "Vanuatu", "Venezuela (Bolivarian Republic of)", "Viet Nam", "Yemen",	"Zambia", "Zimbabwe"))),    
              column(width=6,
                     selectInput("selected_item", "Select Item_Group", choices = c("Alcoholic Beverages", "Animal fats", 
                                                                             "Animal Products", "Aquatic Products, Other", "Cereals - Excluding Beer", "Eggs", "Fish, Seafood", "Fruits - Excluding Wine", "Meat", "Milk - Excluding Butter", "Miscellaneous", "Offals", "Oilcrops", "Pulses", "Spices", "Starchy Roots", "Stimulants", "Sugar & Sweeteners", "Sugar Crops", "Treenuts", "Vegetable Oils", "Vegetables", "Vegetal Products")))
              
            ),
            plotlyOutput("line_chart")),
        
        
        tags$h2("Production source breakdown (Production, Import)"),
        box(width = 12,
            fluidRow(
              column(width=6,
                     selectInput("YearId", "Select year", choices = c("2010","2011","2012","2013","2014","2015", "2016", "2017", "2018", "2019", "2020", "2021", "2022"), selected="2022")),
              column(width=6,
                     radioButtons("x_axis", "Select X-axis:", choices = c("Continents", "UN_Regional_groups"), selected = "Continents"))),
            plotlyOutput("stacked_bar_chart"),
            HTML("<p><em><strong>NB</strong>:The percentages consider a summation of total production and imports</em></p>")
        
           )
        ),  
                    
                
      
      
      tabItem(tabName = "table",
              tags$h2("Data Table"),
              box(width=12,
                  checkboxGroupInput("columns", "Columns to show in table", c('Area','Year','Item', 'Production', 'Import_quantity', 'Stock_Variation', 'Export_quantity', 'Domestic_supply_quantity', 'Feed', 'Seed', 'Losses', 'Processing'), selected=c('Area','Year','Item', 'Production', 'Import_quantity', 'Stock_Variation', 'Export_quantity', 'Domestic_supply_quantity', 'Feed', 'Seed', 'Losses', 'Processing'), inline = TRUE)
                  
              ),
              
              fluidRow(
                column(4,
                       selectInput("country2",
                                   "Select Area/Country ",
                                   c("All", "Afghanistan", "Albania", "Algeria", "Angola", "Antigua and Barbuda", "Argentina", "Armenia", "Australia", "Austria", "Azerbaijan", "Bahamas", "Bahrain", "Bangladesh", "Barbados", "Belarus", "Belgium", "Belize", "Benin", "Bhutan", "Bolivia (Plurinational State of)", "Bosnia and Herzegovina", "Botswana", "Brazil", "Bulgaria", "Burkina Faso", "Burundi", "Cabo Verde", "Cambodia", "Cameroon", "Canada", "Central African Republic", "Chad", "Chile", "China", "China, Hong Kong SAR", "China, Macao SAR", "China, mainland", "China, Taiwan Province of", "Colombia", "Comoros", "Congo", "Costa Rica", "Cote d'Ivoire", "Croatia", "Cuba", "Cyprus",	"Czechia", "Democratic People's Republic of Korea", "Democratic Republic of the Congo",	"Denmark", "Djibouti", "Dominica", "Dominican Republic", "Ecuador", "Egypt", "El Salvador", "Estonia", "Eswatini", "Ethiopia", "Fiji", "Finland", "France", "French Polynesia", "Gabon", "Gambia",	"Georgia", "Germany", "Ghana", "Greece", "Grenada", "Guatemala", "Guinea", "Guinea-Bissau", "Guyana", "Haiti", "Honduras", "Hungary", "Iceland",	"India", "Indonesia", "Iran (Islamic Republic of)", "Iraq", "Ireland", "Israel", "Italy", "Jamaica", "Japan", "Jordan", "Kazakhstan", "Kenya", "Kiribati", "Kuwait", "Kyrgyzstan", "Lao People's Democratic Republic", "Latvia", "Lebanon",	"Lesotho", "Liberia", "Libya", "Lithuania", "Luxembourg", "Madagascar",	"Malawi", "Malaysia", "Maldives",	"Mali",	"Malta", "Marshall Islands", "Mauritania", "Mauritius",	"Mexico", "Micronesia (Federated States of)", "Mongolia", "Montenegro", "Morocco", "Mozambique", "Myanmar", "Namibia", "Nauru",	"Nepal", "Netherlands (Kingdom of the)", "Netherlands Antilles (former)", "New Caledonia", "New Zealand", "Nicaragua",	"Niger", "Nigeria", "North Macedonia", "Norway", "Oman", "Pakistan", "Panama", "Papua New Guinea", "Paraguay", "Peru", "Philippines", "Poland", "Portugal", "Qatar", "Republic of Korea", "Republic of Moldova", "Romania", "Russian Federation", "Rwanda", "Saint Kitts and Nevis",  "Saint Lucia", "Saint Vincent and the Grenadines", "Samoa",  "Sao Tome and Principe", "Saudi Arabia", "Senegal", "Serbia", "Seychelles", "Sierra Leone", "Slovakia", "Slovenia", "Solomon Islands", "Somalia", "South Africa", "South Sudan", "Spain", "Sri Lanka", "Sudan", "Suriname", "Sweden", "Switzerland", "Syrian Arab Republic", "Tajikistan", "Thailand", "Timor-Leste", "Togo", "Tonga", "Trinidad and Tobago", "Tunisia", "Türkiye", "Turkmenistan", "Tuvalu", "Uganda", "Ukraine", "United Arab Emirates", "United Kingdom of Great Britain and Northern Ireland", "United Republic of Tanzania", "United States of America", "Uruguay", "Uzbekistan", "Vanuatu", "Venezuela (Bolivarian Republic of)", "Viet Nam", "Yemen",	"Zambia", 
                                     "Zimbabwe")))),
              
              
              downloadButton("download_csv", "Download CSV"),
              box(width = 12, dataTableOutput(outputId = "tab"))
      
              ),
      
              
     
      tabItem(tabName="FAQ",
              tags$h2("Acronyms"),
              HTML("<P> <strong>FAO: </strong> Food and Agriculture Organization of the United Nations"),
              tags$h2("What are the definations of the metrics reported on the summary tab"),
              HTML("<p> <strong>Area:</strong>  The name of the country or region."),
              HTML("<p> <strong>Year:</strong>  The year of the data entry."),
              HTML("<p> <strong>Item:</strong>  The definition of the product."),
              HTML("<p> <strong>Item_group:</strong> Categorization of individual food items."),
              HTML("<p> <strong>Production:</strong>  The quantity produced in the country or region."),
              HTML("<p> <strong>Import_quantity:</strong>  The quantity imported."),
              HTML("<p> <strong>Export_quantity:</strong>  The quantity exported."),
              HTML("<p> <strong>Domestic_supply_quantity:</strong>  The quantity available for domestic use."),
              HTML("<p> <strong>Feed:</strong>  The quantity of domestic supply used as animal feeds."),
              HTML("<p> <strong>Seed:</strong>  The quantity of domestic supply used as seeds for planting."),
              HTML("<p> <strong>Losses:</strong>  The quantity of domestic supply lost."),
              HTML("<p> <strong>Processing:</strong>  The quantity of domestic supply used in processing sector."),
              HTML("<p> <strong>Other_uses_non_food:</strong>  The quantity of domestic supply used for non-food purposes."),
              HTML("<p> <strong>Residuals:</strong>  The quantity of domestic supply used for residual use or the imbalance in supply."),
              HTML("<p> <strong>Food:</strong>  The quantity of domestic supply used as food."),
              HTML("<p> <strong>Tourist_consumption:</strong>  The quantity of domestic supply used for tourist consumption."),
              tags$h2("What's the formular to calculate domestic supply"),
              HTML("<p> Domestic supply=Production + Import - Stock - Export"),
              tags$h2("What's the formular to calculate stock variation"),
              HTML("<p> Stock variation=Production + Import - Domestic supply"),
              tags$h2("NOTE"),
              HTML("<p> %production=(Production/(Imports+production))*100"),
              HTML("<p> %Import=(Imports/(Imports+production))*100")
              
      )
    
  )
 )
)

server <- function(input, output){
  
 ##-----------------------------------------------------------
  #read in data
  output_data <- reactive({
    read_csv("data/output.csv") %>%
      mutate(across(where(is.numeric), ~ ifelse(is.na(.), 0, .)))  # Replace NA with 0 for numeric columns
  })
  
  continents_data <- reactive({
    read_csv("data/continent_groups.csv")
  })
  
  item_group <- reactive({
    read_csv("data/Item_Groups.csv")
  })
  
  
  merged <- reactive({
    output_data() %>%
      left_join(continents_data, by = "Area")%>%
      filter(Item %in% unique(item_group()$Group))
  })
  
  
  merged <- reactive({
    req(output_data(), continents_data())  # Ensure both datasets are available
    merge(output_data(), continents_data(), by = "Area", all = TRUE)
  })
  
  
  
  ##---------------reactive_summary page-------------------------------  
  #Reactive filter for summary page
  filtered_summary <- reactive({
    req(merged()) %>%
      filter(Area == input$selected_country1, Item == input$selected_item1, Year==input$selected_year1)
  })
  
  #reactive sums domestic_supply_quantity
  reactive_domestic_supply <- reactive({
    sum(filtered_summary()$Domestic_supply_quantity, na.rm = TRUE) # Calculate the sum
  })
  #reactive sum production
  reactive_production <- reactive({
    sum(filtered_summary()$Production, na.rm = TRUE) # Calculate sum of production
  })
  
  #reactive sum import
  reactive_import <- reactive({
    sum(filtered_summary()$Import_quantity, na.rm = TRUE) # Calculate sum of production
  }) 
  
  #reactive sum feed
  reactive_feed <- reactive({
    sum(filtered_summary()$Feed, na.rm = TRUE) # Calculate sum of feed
  })
  
  #reactive sum seed
  reactive_seed <- reactive({
    sum(filtered_summary()$Seed, na.rm = TRUE) # Calculate sum of seed
  })
  
  #reactive sum Losses
  reactive_losses <- reactive({
    sum(filtered_summary()$Losses, na.rm = TRUE) # Calculate sum of losses
  })
  
  #reactive sum Processing
  reactive_processing <- reactive({
    sum(filtered_summary()$Processing, na.rm = TRUE) # Calculate sum of Processing
  })
  
  #reactive sum Other_uses_non_food
  reactive_Other_uses <- reactive({
    sum(filtered_summary()$Other_uses_non_food, na.rm = TRUE) # Calculate sum of Other_uses_non_food
  })
  
  #reactive sum Residuals
  reactive_residuals <- reactive({
    sum(filtered_summary()$Residuals, na.rm = TRUE) # Calculate sum of Processing
  })  
  
  #reactive sum Food
  reactive_food <- reactive({
    sum(filtered_summary()$Food, na.rm = TRUE) # Calculate sum of food
  })  
  
  #reactive sum Tourist_consumption
  reactive_tourist <- reactive({
    sum(filtered_summary()$Tourist_consumption, na.rm = TRUE) # Calculate sum of tourist
  })   
  
  #reactive sum variation
  reactive_variation <- reactive({
    sum(filtered_summary()$Stock_Variation, na.rm = TRUE) # Calculate sum of tourist
  })  
  
  ##------------------summary_page_render----------------------------------------------------------------------------------------------------------------------------------------- 
  
  
  #render sum domestic_supply_quantity
  output$domestic_supply <- renderValueBox({
    valueBox(
      value=comma(reactive_domestic_supply()),
      subtitle = "Domestic supply",
      color="green"
    )
  })
  
  #render sum production
  output$production <- renderValueBox({
    valueBox(
      value=comma(reactive_production()),
      subtitle = "Production",
      color="green"
    )
  })
  #render sum import
  output$import <- renderValueBox({
    valueBox(
      value=comma(reactive_import()),
      subtitle = "Import",
      color="green"
    )
  })  
  
  #render sum Feeds
  output$feeds <- renderValueBox({
    valueBox(
      value=comma(reactive_feed()),
      subtitle = "feeds",
      color="green"
    )
  }) 
  
  #render sum seed
  output$seed <- renderValueBox({
    valueBox(
      value=comma(reactive_seed()),
      subtitle = "Seeds",
      color="green"
    )
  }) 
  
  #render sum losses
  output$losses <- renderValueBox({
    valueBox(
      value=comma(reactive_losses()),
      subtitle = "losses",
      color="green"
    )
  }) 
  
  #render sum processing
  output$processing <- renderValueBox({
    valueBox(
      value=comma(reactive_processing()),
      subtitle = "processing",
      color="green"
    )
  })
  
  #render sum other_uses
  output$other_uses <- renderValueBox({
    valueBox(
      value=comma(reactive_Other_uses()),
      subtitle = "other_uses",
      color="green"
    )
  })
  
  #render sum residual
  output$residual <- renderValueBox({
    valueBox(
      value=comma(reactive_residuals()),
      subtitle = "residual",
      color="green"
    )
  })
  
  #render sum food
  output$food <- renderValueBox({
    valueBox(
      value=comma(reactive_food()),
      subtitle = "food",
      color="green"
    )
  })
  
  #render sum tourist
  output$tourist <- renderValueBox({
    valueBox(
      value=comma(reactive_tourist()),
      subtitle = "tourist",
      color="green"
    )
  })
  
  #render sum variation
  output$variation <- renderValueBox({
    valueBox(
      value=comma(reactive_variation()),
      subtitle = "Stock_variation",
      color="green"
    )
  })
  
  ##----visualize line graph-------------------------
  
  # Reactive data filtered by selected country and item
  filtered_data1 <- reactive({
    req(merged()) %>%
      filter(Area == input$selected_country,Item == input$selected_item)
  })
  
  
  
  
  
  # Render the line plot
  output$line_chart <- renderPlotly({
    
    line1 <- filtered_data1() %>%
      mutate(Domestic_supply_per_pop=Domestic_supply_quantity/Population) %>%
      group_by(Year) %>%
      summarize(sum_value = sum(Domestic_supply_per_pop, na.rm=TRUE))
    
    plot_ly(line1, x = ~Year, y = ~sum_value, type = 'scatter', mode = 'lines+markers') %>%
      layout(
        title = list(text=paste("Annual production of",input$selected_item, "per capita in",  input$selected_country),font=list(size=17), yanchor="top",xanchor="center"),
        width=NULL,
        xaxis = list(title = "Year"),
        yaxis = list(title = "Domestic supply per popollation(tons/person)"),
        margin=list(t=80)
      )
  })
  
  ##---------Visualisation---bar chart--------------------------------------------------  
  filtered_data <- reactive({
    req(merged()) %>%
      filter(Year == input$YearId) %>%
      group_by(.data[[input$x_axis]]) %>%  # Dynamically change x-axis variable
      summarise(
        Total_Production = sum(Production, na.rm = TRUE),
        Total_Import = sum(Import_quantity, na.rm = TRUE),
        Total_Supply=sum(Domestic_supply_quantity, na.rm = TRUE)
      ) %>%
      mutate(
        Production_percentage = (Total_Production / (Total_Production+Total_Import)) * 100,
        Import_percentage = (Total_Import / (Total_Production+Total_Import)) * 100
      ) %>%
      tidyr::pivot_longer(cols = c(Production_percentage, Import_percentage), 
                          names_to = "Category", 
                          values_to = "Value")  # Reshape for stacked bars
  })
  
  
  # Render Stacked Bar Chart
  output$stacked_bar_chart <- renderPlotly({
    req(input$YearId)  # Ensure Year is selected
    
    plot_data <- filtered_data() %>%
      mutate(Label = paste0(get(input$x_axis), ":", round(Value, 1), "%"))
    
    plot_ly(
      data = plot_data,
      x = ~get(input$x_axis),  # Dynamic x-axis
      y = ~Value,
      color = ~Category,  # Color by Production and Import
      type = "bar",
      text=~paste0(Category, ":", round(Value,1),"%"),
      textposition="inside",
      hoverinfo = "text",
      hovertext = ~paste0(Category, ":", round(Value,1),"%")
    ) %>%
      layout(
        title = list(text=paste("Production vs Import for", input$x_axis, "in", input$YearId), font=list(size=17)),
        xaxis = list(title = input$x_axis),
        yaxis = list(title = "Total Quantity"),
        barmode = "stack"  # Stacked bars
      )
  })
  
  #Reactive filter for table download
  filtered_table <- reactive({
    if(input$country2=="All"){
      merged()  #show entire dataset
    }else{
      merged() %>% filter(Area==input$country2)
    }
    
  })
  
  # Reactive columns selection
  selected_columns <- reactive({
    req(input$columns)  # Ensure at least one column is selected
    input$columns
  })
  
  # CSV Download Handler
  output$download_csv <- downloadHandler(
    filename = function() {
      paste("filtered_dataset_", Sys.Date(), ".csv", sep = "")
    },
    content = function(file) {
      write.csv(filtered_table(), file, row.names = FALSE)
    }
  )
  
  output$tab <- renderDataTable({
    
    filtered_table()[, selected_columns(), drop = FALSE]  # Apply column selection
  }, options = list(scrollX = TRUE))
}


shinyApp(ui, server)


