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
                                                          "SQL" = "sql"),
                                              selected = c("git", "shell")),
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

        make_slug <- function(start_date, short_name) {
            if (short_name == "")
                stop("short name (slug) missing for this workshop")
            start_date <- format(start_date, "%Y-%m-%d")
            slug <- paste0(start_date, "-", short_name)
        }

        observe({
            if (input$use_etherpad) {
                etherpad_url <- paste0("https://etherpad.swcarpentry.org/",
                                       make_slug(input$workshop_dates[1],
                                                 input$short_name))
                updateTextInput(session, "etherpad_address", value = etherpad_url)
            } else {
                updateTextInput(session, "etherpad_address", value = "")
            }
        })
        repo <- eventReactive(input$generate_workshop, {
            repo_nm <- make_slug(input$workshop_dates[1],
                                 input$short_name)
            message("creating repo ", repo_nm)
            ## 1. create repository
            repo_create <- gh::gh("POST /user/repos",
                                  name = repo_nm,
                                  description = paste("Website for workshop", repo_nm))
            ## 2. import repository
            res <- gh::gh("PUT /repos/:owner/:repo/import",
                          vcs_url = "https://github.com/swcarpentry/workshop-template",
                          vcs = "git")

        })
    }
)
