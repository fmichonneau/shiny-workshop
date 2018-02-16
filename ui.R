fluidPage(
    h3("Dates for the workshop:"),
    dateRangeInput("workshop-dates", "What are the dates for the workshops?"),

    h3("Start time for the workshop: "),
    numericInput("time-start-hour", "Start time (hours): ", value = 9, min = 1, max = 11),
    numericInput("time-start-min", "Start time (minutes):", value = 0, min = 0, max = 59),
    radioButtons("time-start-ampm", "AM/PM", choices = c(am = "am", pm = "pm"), inline = TRUE),

    h3("End time for the workshop: "),
    numericInput("time-stop-hour", "Stop time (hours): ", value = 5, min = 1, max = 11),
    numericInput("time-stop-min", "Stop time (minutes):", value = 0, min = 0, max = 59),
    radioButtons("time-stop-ampm", "AM/PM", choices = c(am = "am", pm = "pm"), selected = "pm", inline = TRUE),

    h3("Where is the workshop taking place?"),
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
    uiOutput("curriculum_selector")



)
