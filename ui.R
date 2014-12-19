library(shiny)

shinyUI(fluidPage(
  titlePanel("Bivariate Distribution"),
  
  sidebarLayout(position = 'right',
    sidebarPanel(
      h2("Inputs"),
      numericInput("mean_a","Mean of A:",round(runif(1,min=-10,max=10),4)),
      numericInput("sd_a", "Standard Deviation of A:",min = 0.0001,value = round(runif(1,min=0.0001,max=5),4)),
      numericInput("mean_b", "Mean of B:", round(runif(1,min=-10,max=10),4)),
      numericInput("sd_b", "Standard Deviation of B:", min = 0.0001, value = round(runif(1,min=0.0001,max=5),4)),
      sliderInput("rho","Correlation",min = -0.9999, max = 0.9999, value = round(runif(1,min=-1,max=1),4),step = 0.0001, format = "0.00%"),
      sliderInput("x_rot", "Rotation of the X axis", min = 0, max = 360, value = 130),
      sliderInput("y_rot", "Rotation of the Y axis", min = 0, max = 90, value = 15),
      helpText("This is a demonstration of the bivariate normal distribution. Tweak the inputs to see how it affects the probabilities. Tweak the sliders to manipulate the plot")),
    mainPanel(
      tabsetPanel(
        tabPanel("Documentation",h1("Bivariate Normal Distribution"),
                 p("This is a visualization and demonstration of the a specific case of the multivariate normal distribution - the bivariate normal distribution."),
                 p("Here we give the user the ability to select the parameters for each of two variables which follow a normal distribution and observe the effects these changes have on the density function."),
                 h2("The inputs"),
                 p("The application has seven inputs in total using a combination of numeric and slider inputs. Five of them affect the shape of the density function. These are the means and standard deviations of the variables as well as the correlation between the variables. The most visible effect on the distribution is the one coming from altering the correlation. Play around with it (as well as the other 4 parameters) to see what happens."),
                 p("The other two slider inputs allow the user to change the perspective angle. This is useful in exploring how shape of the density function reacts."),
                 h2("The output"),
                 p("On the plot tab you will be able to see a perspective plot as well as a contour plot of the data. These will give the user an idea of how the probabilities are distributed for a combination of 2 variables having their parameters set in the input section (the sidebar).")
                 ),
        tabPanel("Plot",plotOutput('bivar'),plotOutput('bivar2'))
        
      )
    ))
  ))