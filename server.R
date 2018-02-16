library(ggmap)

shinyServer(
    function(input, output, session) {

        latlong <- eventReactive(input$push, {
            ggmap::geocode(input$location, output = "latlon")
        })

        output$res <- renderTable(latlong())

        output$instructors <- renderUI(lapply(seq_len(input$n_instructors), function(x) {
            textInput(paste0("inst-", x), paste0("Instructor ", x, ": "))
        }))

        output$helpers <- renderUI(lapply(seq_len(input$n_helpers), function(x) {
            textInput(paste0("helper-", x), paste0("Helper ", x, ": "))
        }))

        output$curriculum_selector <- renderUI({
            if (is.null(input$workshop_type))
                return()

            switch(input$workshop_type,
                   "swc" = checkboxGroupInput("swc_options", "Software Carpentry",
                                              choices = c("Shell" = "shell",
                                                          "Git" = "git",
                                                          "R (gapminder)" = "r_gapminder",
                                                          "R (inflammation)" = "r_inflammation",
                                                          "Python" = "python_inflammation",
                                                          "SQL" = "sql")),
                   "dc_ecology" = checkboxGroupInput("dc_ecology_options", "DC - Ecology",
                                                     choices = c("Spreadsheets" = "spreadsheets",
                                                                 "OpenRefine" = "openrefine",
                                                                 "SQL" = "sql",
                                                                 "R Ecology" = "r_ecology",
                                                                 "Python Ecology" = "python_ecology"),
                                                     selected = c("spreadsheets",
                                                                  "openrefine",
                                                                  "sql")),
                   "instructor_training" = return()
                   )
        })

    }
)
