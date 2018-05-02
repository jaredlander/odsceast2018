library(shiny)
library(shinythemes)

statePanel <- tabPanel(
    title='State Info',
    # this is the selector of states
    selectInput(
        inputId='StateSelector',
        label='Choose a state',
        choices=list(
            'NY', 'NJ', 'MA', 'TX'
        )
    ),
    # this will display the
    # selected state
    textOutput(
        outputId='DisplayState'
    )
)

plotPanel <- tabPanel(
    title='Simple Plot',
    fluidRow(
        column(
            width=3,
            selectInput(
                inputId='CarColumn',
                label='Please choose a column to plot',
                choices=names(mtcars)
            )
        ),
        column(
            width=9,
            plotOutput(outputId='CarHist')
        )
    )
)

navbarPage(
    title='Flight of the Navigator',
    selected='Simple Plot',
    theme=shinytheme(theme='spacelab'),
    # themeSelector(),
    tabPanel(
        title='First Page',
        'Hi'
    ),
    tabPanel(
        title='Second Page',
        'Hello, there'
    ),
    statePanel,
    plotPanel
)
