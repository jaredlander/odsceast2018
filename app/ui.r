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

navbarPage(
    title='Flight of the Navigator',
    selected='State Info',
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
    statePanel
)
