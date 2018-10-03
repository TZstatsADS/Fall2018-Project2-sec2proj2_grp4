


library(leaflet)

# Choices for drop-downs
location = c("-----","AK","AL","AR","AS","AZ","CA","CO","CT","DC","DE"
             ,"FL","FM","GA","GU","HI","IA","ID","IL","IN","KS","KY","LA","MA","MD"
             ,"ME","MH","MI","MN","MO","MP","MS","MT","NC","ND","NE","NH","NJ","NM","NV"
             ,"NY","OH","OK","OR"
             ,"PA","PR","PW","RI","SC","SD","TN","TX","UT","VA","VI","VT"
             ,"WA","WI","WV","WY")

Major = c("-----",
          "Agriculture, Agriculture Operations, and Related Sciences","Natural Resources and Conservation","Architecture and Related Services",
          "Area, Ethnic, Cultural, Gender, and Group Studies","Communication, Journalism, and Related Programs","Communications Technologies/Technicians and Support Services",
          "Computer and Information Sciences and Support Services","Personal and Culinary Services","Education","Engineering","Engineering Technologies and Engineering-Related Fields",
          "Foreign Languages, Literatures, and Linguistics","Family and Consumer Sciences/Human Sciences","Legal Professions and Studies","English Language and Literature/Letters",
          "Liberal Arts and Sciences, General Studies and Humanities","Library Science","Biological and Biomedical Sciences","Mathematics and Statistics",
          "Military Technologies and Applied Sciences","Multi/Interdisciplinary Studies","Parks, Recreation, Leisure, and Fitness Studies","Philosophy and Religious Studies",
          "Theology and Religious Vocations","Physical Sciences","Science Technologies/Technicians","Psychology","Homeland Security, Law Enforcement, Firefighting and Related Protective Services",
          "Public Administration and Social Service Professions","Social Sciences","Construction Trades","Mechanic and Repair Technologies/Technicians","Precision Production",
          "Transportation and Materials Moving","Visual and Performing Arts","Health Professions and Related Programs",
          "Business, Management, Marketing, and Related Support Services","History")


navbarPage("Find your university!", id="nav",
           
           tabPanel("Map",
                    div(class="outer",
                        
                        tags$head(
                          # Include our custom CSS
                          includeCSS("style.css"),
                          includeScript("gomap.js")
                        ),
                        
                        # If not using custom CSS, set height of leafletOutput to a number instead of percent
                        leafletOutput("mymap", width="100%", height="100%"),
                        
                        # Shiny versions prior to 0.11 should use class = "modal" instead.
                        absolutePanel(id = "controls", class = "panel panel-default", fixed = TRUE,
                                      draggable = TRUE, top = "auto", left = 20, right = "auto", bottom = 10,
                                      width = 330, height = "auto",
                                      
                                      h2("Choose the university"),
                                      
                                      sliderInput("cost", label = "Cost by Year ", min = 0, max =80000, value = c(1,80000)),
                                      sliderInput(inputId="sat",label = "SAT Score",value = 1600,min = 0,max = 1600,step = 1 ),
                                      sliderInput("act",label = "ACT Score",min=0,max=36, value =36,step = 1 ),
                                      
                                      selectInput("location", "Where you want to take your college in?", choices = location),
                                      selectInput("major", "Major", choices = Major),
                                      selectInput("city", "City Size", choices = c("-----","City","Suburb","Town","Rural")),
                                      selectInput("schtype", "Control of Instituion", choices = c("-----","Public","Private nonprofit","Private for-profit")),
                                      selectInput("hdeg", "Highest Degree", choices = c("-----","Graduate","Bachelor","Associate","Certificate","Non-degree-granting"))
                                      
                        )
                        
                        # tags$div(id="cite",
                        #          'Data compiled for ', tags$em('Coming Apart: The State of White America, 1960–2010'), ' by Charles Murray (Crown Forum, 2012).'
                        #  )
                    )
           ),
           
           tabPanel("Ranking",
                    fluidRow(
                      
                      dataTableOutput("universities.table"),
                      tags$style(type="text/css", '#myTable tfoot {display:none;}')), 
                    
                
          
                    hr()
                    
           ),
       
           tabPanel(title="Detailed Summary", width = 12, solidHeader = T, 
                               fluidRow(
                                 column(3,tableOutput("table.summary")),
                                 column(3,tableOutput("table.summary2")),
                                 column(4,tableOutput("table.summary3"))
                                 
                                 
                               )),
                    
           tabPanel(title = "Admission Rate Trend", width = 12, solidHeader = T, plotlyOutput("ADM")),
           tabPanel(title = "Average SAT Trend", width = 12, solidHeader = T, plotlyOutput("SAT")),
           tabPanel(title = "MID ACT Trend", width = 12, solidHeader = T, plotlyOutput("ACT")),
           tabPanel(title = "Share of Female Students Trend", width = 12, solidHeader = T, plotlyOutput("FEM")),
           tabPanel(title = "Total Enrollments Trend", width = 12, solidHeader = T, plotlyOutput("ENR")),         
       
           
           conditionalPanel("false", icon("crosshair"))
        
          
)