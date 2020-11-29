library(dashCoreComponents)
library(dashHtmlComponents)
library(dash)
utils <- new.env()

df = read.csv('2018WinterOlympics.csv')

prueba1app <- Dash$new(external_stylesheets = "https://codepen.io/chriddyp/pen/bWLwgP.css")

colors <- list(
    background = '#111111',
    SecondBackground = '#140603',
    #background = '#00FFFF',
    text = '#23BAC4'
    #text = '#7FDBFF'
)
pageTitle <- htmlH1(
    '2018 Winter Olympics',
    style = list(
        textAlign = 'center',
        color = colors$text
    )
)
markdown_text <- "
### *Eduardo Chana - Data Visualization in Rstudio*

"
pageSubTitle <- htmlDiv(
    'categorica: paises NOC::::eje y numero de medallas ganadas',
    style = list(
        textAlign = 'center',
        color = colors$text
    )
)
graph <- dccGraph(
    id = 'example-graph-2',
    figure = list( #componente que permite interactuar en el grafico
        data=list(
            list(
                x = df$NOC,
                y = df$Gold,
                type = "bar",
                text = df$Gold,
                textposition = "auto",
                name = "Gold",
                marker = list(color = "red")
                
            ),
            list(
                
                x = df$NOC,
                y = df$Silver,
                type = "bar",
                name = "Silver",
                text = df$Silver,
                textposition = "auto",
                marker = list(color = "blue")
            ),
            list(
                df,
                x = df$NOC,
                y = df$Bronze,
                type = "bar",
                name = "Bronze",
                text = df$Bronze,
                textposition = "auto",
                marker = list(color = "forestgreen")
            )
        ),
        layout = list(barmode="stack",
                      plot_bgcolor = colors$background,
                      paper_bgcolor = colors$background,
                      font = list(color = colors$text)
        )
    )
)
prueba1app$layout(

    htmlDiv(list(
        
        htmlH1('demo4'), # omitir conflicto
        dccTabs(id="tabs-example", value='tab-1', children=list(
            dccTab(label='1', value='tab-1'),
            dccTab(label='2', value='tab-2')
        )),
        htmlDiv(id='id-htmldiv-layout')      
    ) 
    )    
)
fig <- plot_ly(
    df,
    x = df$NOC,
    y = df$Gold,
    type = "bar",
    text = df$Gold,
    textposition = "auto",
    name = "Gold",
    marker = list(color = "Red")
)
fig <- fig %>% add_trace(
    y = df$Silver,
    name = "Silver",
    text = df$Silver,
    textposition = "auto",
    marker = list(color = "Blue")
)
fig <- fig %>% add_trace(
    y = df$Bronze,
    name = "Bronze",
    text = df$Bronze,
    textposition = "auto",
    marker = list(color = "Green")
)
fig <- fig %>% layout(yaxis = list(title = "count"),
                      barmode = "stack",
                      title = "juegos de invierno 2018")
prueba1app$callback(
   #declaor como salida id de htmldiv layout
    output = list(id='id-htmldiv-layout', property = 'children'),
    #paramertos que tomara de salida
    params = list(input(id = 'tabs-example', property = 'value')),
    #finalmente creo una funcion 'tab'
    #y agrego un if conteniendo las graficas
    function(tab){
        if(tab == 'tab-1'){# tab es igual al valor del layout de dccTab value 
            #value =tab-1 i lo compara con el valor de la funcion tab
            return(htmlDiv(list( #retorna el grafico
                
                htmlH3('Contenido 1'),#contenido H3
                ############
                ##
                dccGraph(
                    id = 'example-graph-2',
                    figure = list( #componente que permite interactuar en el grafico
                        data=list(
                            list(
                                x = df$NOC,
                                y = df$Gold,
                                type = "bar",
                                text = df$Gold,
                                textposition = "auto",
                                name = "Gold",
                                marker = list(color = "red")
                                
                            ),
                            list(
                                
                                x = df$NOC,
                                y = df$Silver,
                                type = "bar",
                                name = "Silver",
                                text = df$Silver,
                                textposition = "auto",
                                marker = list(color = "blue")
                            ),
                            list(
                                df,
                                x = df$NOC,
                                y = df$Bronze,
                                type = "bar",
                                name = "Bronze",
                                text = df$Bronze,
                                textposition = "auto",
                                marker = list(color = "forestgreen")
                            )
                        ),
                        layout = list(barmode="stack",
                                      plot_bgcolor = colors$background,
                                      paper_bgcolor = colors$background,
                                      font = list(color = colors$text)
                        )
                    )
                )
                
                
                ##
                
                
                ################
                
                #dccGraph(
                    #id='graph-2-tabs',
                    
                    
                    #graph#le colocamos un id a dccgraph para reconocer la grafica que vamos a graficar
                    
                    #figure=list(#imprmimimos la figura
                        #crear la figura dataframe
                            #,
                            #,
                            #'type' = 'bar'
                            # llamamos a la grafica
                            
                        
                            
                   # )#hasta aqui imprimos la figura y comenatmos a figure
                #)
            )))#hasta aqui reotna el grafcio
            
        }#corchete del if aqui acaba el if
        #inciia otroc ondicional para el tab-2
        else if(tab == 'tab-2'){
            return(htmlDiv(
                list(
                    htmlH3('Contenido 2'),
                    dccGraph(figure = fig)
                )
                # dccGraph(
                #     id='graph-2-tabs',
                #     figure=list(
                #         'data' = list(list(
                #             'x' = c(1, 2, 3),
                #             'y' = c(5, 10, 6),
                #             'type' = 'bar'
                #         ))
                #     )
                # )
            ))
        }
    }
  
)

prueba1app$run_server()

