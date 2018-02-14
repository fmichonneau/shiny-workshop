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
})
