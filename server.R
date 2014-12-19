library(shiny)

# bivariate <- function(x, y){
#   term1 <- 1 / (2 * pi * sig1 * sig2 * sqrt(1 - rho^2))
#   term2 <- (x - mu1)^2 / sig1^2
#   term3 <- -(2 * rho * (x - mu1)*(y - mu2))/(sig1 * sig2)
#   term4 <- (y - mu2)^2 / sig2^2
#   z <- term2 + term3 + term4
#   term5 <- term1 * exp((-z / (2 *(1 - rho^2))))
#   return (term5)
# }

shinyServer(function(input,output) {

  meanA <- reactive({ifelse(is.na(input$mean_a),0,input$mean_a)})
  meanB <- reactive({ifelse(is.na(input$mean_b),0,input$mean_b)})
  sdA <- reactive({ifelse(is.na(input$sd_a),1,input$sd_a)})
  sdB <- reactive({ifelse(is.na(input$sd_b),1,input$sd_b)})
  
  
  bivariate <- function(x,y) { 
    term1 <- 1 / (2 * pi * sdA() * sdB() * sqrt(1 - input$rho^2))
    term2 <- (x - meanA())^2 / sdA()^2
    term3 <- -(2* input$rho * (x - meanA()) * (y - meanB())) / (sdA() * sdB())
    term4 <- (y - meanB())^2 / sdB()^2
    z <- term2 + term3 + term4
    term5 <- term1 * exp((-z / (2 * (1 - input$rho^2))))
  return(term5)}

  z <- reactive({outer(seq(meanA()-3*sdA(),meanA()+3*sdA(),length=300),
                       seq(meanB()-3*sdB(),meanB()+3*sdB(),length=300),bivariate)})
  output$bivar <- renderPlot({
    nrz <- nrow(z())
    ncz <- ncol(z())
    nbcol <- nrz * ncz
    colPal <- colorRampPalette(c("blue","green","yellow","red"))
    color <- colPal(nbcol)
    zfacet <- z()[-1,-1] + z()[-1,-ncz] + z()[-nrz, -1] + z()[-nrz, - ncz]
    facetcol <- cut(zfacet, nbcol)
    persp(z(), main = 'Bivariate Normal Distribution',
          xlab = 'X',
          ylab = 'Y',
          zlab = 'Density',
          col = color[facetcol], border = NA,
          shade = 0.2, 
          theta = input$x_rot, phi = input$y_rot)
  }) 
  output$bivar2 <- renderPlot({
    filled.contour(z(),main = 'Bivariate Contour',
            nlevels = 100, frame.plot = F, color.palette = colorRampPalette(c("blue","green","yellow","red")))
  })
})