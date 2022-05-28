

bs_theme_new(version = "4", bootswatch = "slate")


bs_theme_accent_colors(secondary = "#f8f8f8e6")
bs_theme_add_variables(black = "#88837d")


ui = tagList(
  
  ## functions required to be used in the ui
  bootstrap(),
  use_waiter(include_js = FALSE),
  use_bs_popover(),
  useShinyjs(),
  withMathJax(),
  
  tags$footer(
    
    fluidRow(
      column(
        width = 4
      ),
      
      column(
        width = 8,
        tagList(
          tags$img(src = "RStudio-Logo-White.png", width = "80px", height = "30px"),
          tags$img(src = "pipe.png", width = "60px", height = "67px"),
          tags$img(src = "shiny.png", width = "60px", height = "67px"),
          tags$img(src = "tidyverse.png", width = "60px", height = "67px"),
          tags$img(src = "gganimate.png", width = "60px", height = "67px"),
          tags$img(src = "waiter.png", width = "60px", height = "67px"),
          tags$img(src = "ggforce.png", width = "60px", height = "67px"),
          tags$img(src = "glue.png", width = "60px", height = "67px")
        )
      )
    ),
    style = "position:absolute; bottom:0; width:95%;
    height:77px; /* Height of the footer */
    color: white; padding: 10px;
    background-color: #272b30; z-index: 1000;"
  ),
  
  ## color of the action button, height of the input n box
  tags$head(
    tags$style(HTML("#run{color:#272727; height: 47px}
                     #n{background:#272b30;}
                     .irs-bar {background:#272b30; border-top: #272b30; border-bottom: #272b30}
                     .irs-bar-edge {background:#272b30; border: #272b30;}
                     .irs-single {background:#272b30;}
                     .irs-max {background:#E7553C; color: #f8f8f8}
                     .irs-min {background:#f8f8f8}
                     .irs-grid-pol {background: #272b30}
                     #go_to_work{color:#e9ecef; height: 45px; background-color:#447099"))
  ),
  
  ## the actual page starts here!
  navbarPage(
    id = "navbar",
    windowTitle = "원주율 - 몬테카를로 모의시행",
    
    ## title
    title = tagList(
      fluidRow(
        div(
          tags$img(src = "koRea_logo.png", width = "32px", height = "26px"), HTML("&nbsp;"),
          "원주율 - 몬테카를로 모의시행", HTML("&nbsp;"), style = "color:#aaa;"
        )
      ) 
    ),
    #############################################
    ## Home tab
    tabPanel(
      title = "소개",
      fluidRow(
        column(
          width <- 2,
          br(),
          br()
        ),
        
        column(
          width <- 8,
          
          p("2020년 Shiny 경진대회 수상작 Shiny App을 한글화한 것입니다. 
             원주율 \\(\\pi\\) 를 몬테카를로 모의시험으로 찾아가는 과정을
             시각적으로 표현하여 이해하기 쉬운 형태로 구현한 사례입니다."),
          p("2020년 작성된 코드라 현재 시점 패키지와 코드를 가독성 높게 다시 작성한 것으로 
            자세한 사항은 한국 R 사용자회 GitHub 저장소에서 확인할 수 있습니다."),
          div(h4("원주율을 계산하는 모의시행 알고리즘"), align = "center"),
          p(" "),
          div(p("원면적: \\(A = \\pi r^2 = \\pi\\)"), align = "center"),
          div(p("정사각형 면적: \\((2r)^2 = 4\\)"), align = "center"),
          div(p("\\(P(원내부에 \\ 떨어지는 \\ 점의 \\ 수  ) = \\pi/4\\)"), align = "center"),
          div(p("\\(p = \\pi/4 \\implies \\pi = 4 p\\)"), align = "center"),
          p("상기 수식을 사용해서 원주율 \\(\\pi\\) 를 계산한다."),
          br(),
          div(actionButton("go_to_work", "바로 드가쟈~~~", status = "success"), align = "center")
        ),
      column(
        width <- 2,
        br(),
        br()
        )
      ),
    ),
    
    #############################################
    ## Work tab
    tabPanel(
      title = "모의시행",
      sidebarLayout(
        sidebarPanel(
          width = 3,
          shinyWidgets::sliderTextInput("n", "시행횟수", slider_vals, 1000, F, T)%>%
            shinyInput_label_embed(
              shiny_iconlink() %>%
                bs_embed_popover(
                  title = "range: (100-10002)",
                  content = "시행횟수를 100, 1000, 10000 으로 설정하면 빠르게 결과를 확인할 수 있습니다.",
                  placement = "right"
                )
            ),
          
          div(actionButton("run", "좋아 바로 시행", icon = icon("walking"), width = "40%"), align = "center"),
          br(),
          p("꼭 알아두면 좋은 사항: 원주율 모든 자리수를 구할 수 없는데 이유는 무리수이기 때문이다. 바빌로니아에서 
          3 ⅛을 사용했고, 중국인은 3을 사용했으며 1665년 아이작 뉴튼은 16자리까지 계산을 했다."),
          p("스위스 과학자는 2017년 원주율 22조 자리수 이상 계산했는데 100일 이상 걸렸다고 한다."),
          p("특별한 10002 시행횟수도 있으니 꼭 시행해보시기 바랍니다."),
          hr()
        ),
        
        mainPanel(
          width = 9,
          fluidRow(
            column(
              width = 6,
              imageOutput("circle_anim")
            ),
            column(
              width = 6,
              imageOutput("progress_anim")
            )
          )
        )
      )
    )
  ),
  waiter_show_on_load(html = spin_loaders(42, color = "#aaa"), color = "#272b30", logo = "logo.png")
)