
# 애니메이션 제작 스크립트 -----------------------
library(gifski)
library(gganimate)
library(tidyverse)
library(plotly)


# 1. 모의시험 데이터 --------------------------------
mc_data <- function(n) {
  x0 <- 0  # origin x co-ordinate
  y0 <- 0  # origin y co-ordinate
  
  x <- runif(n, -1, 1)
  y <- runif(n, -1, 1)
  
  distances <- ((x - x0)**2 + (y - y0)**2)**.5
  in_out <- ifelse(distances < 1, "Inside", "Outside")
  id <- 1:n
  pi_hat <- cumsum(in_out == "Inside")/id * 4
  
  data <- data.frame(id, x, y, distances, in_out, pi_hat)
  return(data)
}

# the_data(10)

# 2. MC 애니메이션 --------------------------------

make_circle_anim <-  function(the_data) {
  
  n = nrow(the_data)
  
  c1 = "#393f47"  # color inside
  c2 = "#88837d"
  
  circle_g <- ggplot() +
    geom_circle(aes(x0 = 0, y0 = 0, r = 1), color = "#515960") +
    geom_rect(aes(xmin = -1,ymin = -1, xmax = 1, ymax = 1),
              alpha = 0, color = "#515960") +
    geom_point(aes(x = x, y = y, group = seq_along(id), color = in_out), size = .7, data = the_data) +
    hrbrthemes::theme_ft_rc() +
    theme(plot.background = element_rect(fill = "#272b30"),
          panel.background = element_rect(fill = "#272b30", color = "#272b30"),
          legend.position = "none",
          plot.title = element_text(color = "#88837d"),
          plot.caption = element_text(size = 10)) +
    scale_color_manual(values = c(c1, c2)) + 
    labs(
      title = "p: {the_data$p[frame_along]}",
      caption = "Can you smell the rain?"
    ) +
    transition_reveal(along = id)
  
  circle_anim = animate(circle_g, nframes = 80, fps = 8,
                  width = 550, height = 540, res = 90,
                  renderer = gifski_renderer(loop = F))
  
  return(circle_anim)
}

## 2.1. 100/1000/10000 모의시험 --------------------------------

make_circle_anim(mc_data(100))
anim_save("www/circle_100.gif", animation = last_animation())

make_circle_anim(mc_data(1000))
anim_save("www/circle_1000.gif", animation = last_animation())

make_circle_anim(mc_data(10000))
anim_save("www/circle_10000.gif", animation = last_animation())

# 3. Progress 애니메이션 --------------------------------

make_progress_anim <-  function(the_data) {
  
  progress_g <- ggplot(the_data) +
    geom_line(aes(x = id, y = pi_hat), color = "#E7553C") + 
    geom_hline(yintercept = pi, color = "#75AADB", alpha = .5, linetype = "longdash") +
    hrbrthemes::theme_ft_rc(base_family = "NanumGtohic") +
    ylim(0, 6) +
    theme(plot.background = element_rect(fill = "#272b30"),
          panel.background = element_rect(fill = "#272b30", color = "#272b30"),
          plot.title = element_text(color = "#88837d"),
          plot.caption = element_text(size = 10)) +
    labs(
      title = "원주율 (pi) 추정: {the_data$pi_hat[frame_along]}",
      caption = "실시간 난수",
      y = "원주율 추정값"
    ) +
    xlab("누적 난수 갯수") +
    transition_reveal(along = id)
  
  progress_anim <- animate(progress_g, nframes = 80, fps = 8,
                  width = 550, height = 540, res = 90,
                  renderer = gifski_renderer(loop = F))
    
  return(progress_anim)
}

## 3.1. 100/1000/10000 모의시험 --------------------------------

make_progress_anim(mc_data(100))
anim_save("www/progress_100.gif", animation = last_animation())


make_progress_anim(mc_data(1000))
anim_save("www/progress_100.gif", animation = last_animation())


make_progress_anim(mc_data(10000))
anim_save("www/progress_100.gif", animation = last_animation())
