fluidPage(
    h3("Dates for the workshop:"),
    dateRangeInput("workshop_dates", "What are the dates for the workshops?"),

    h3("Start time for the workshop: "),
    numericInput("time_start_hour", "Start time (hours): ", value = 9, min = 1, max = 11),
    selectInput("time_start_min", "Start time (minutes):",
                choices = c("00", "15", "30", "45")),
    radioButtons("time_start_ampm", "AM/PM", choices = c(am = "am", pm = "pm"), inline = TRUE),

    h3("End time for the workshop: "),
    numericInput("time_stop_hour", "Stop time (hours): ", value = 5, min = 1, max = 11),
    selectInput("time_stop_min", "Stop time (minutes):",
                 choices = c("00", "15", "30", "45")),
    radioButtons("time_stop_ampm", "AM/PM", choices = c(am = "am", pm = "pm"), selected = "pm", inline = TRUE),

    h3("Where is the workshop taking place?"),
    textInput("short_name", "Short name (slug):"),
    textInput("location", "Address of the workshop:"),
    actionButton("push", "Search"),
    textOutput("lat"),
    textOutput("lon"),
    tableOutput("res"),

    h3("Who is teaching?"),
    numericInput("n_instructors", "Number of instructors: ", value = 2, min = 1, max = 10),
    uiOutput("instructors"),
    numericInput("n_helpers", "Number of helpers: ", value = 2, min = 0, max = 10),
    uiOutput("helpers"),

    h3("What are you teaching?"),
    selectInput("workshop_type", label = "Curriculum:",
                choices = c("SWC" = "swc",
                            "DC - Ecology" = "dc_ecology",
                            "Instructor Training" = "instructor_training")),
    uiOutput("curriculum_selector"),

    h3("Misc"),
    checkboxInput("use_etherpad", "Are you going to use an Etherpad?", value = FALSE),
    textInput("etherpad_address", "Etherpad suggested address: ", value = ""),

    h3("Done"),
    uiOutput("submit_button")


)
