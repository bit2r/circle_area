# 원주율 (π)

**원주율(π)**은 원둘레와 지름의 비 즉, 원의 지름에 대한 둘레의 비율을 나타내는 
수학 상수로 정의되는데 이를 컴퓨터 모의시험(Simulation)을 통해 구해보자.

[Shiny Contest 2020](https://blog.rstudio.com/2020/07/13/winners-of-the-2nd-shiny-contest/)에서 
**Honorable Mention**을 수상한 수상작의 코드를 한글화하여 통계 개념을 소개하고 
Shiny 웹앱 기능으로 편입한 것입니다.

- [Life of Pi: Shiny 웹앱](https://shahreyar-abeer.shinyapps.io/life_of_pi/)
- [Life of Pi: 소스코드](https://github.com/shahreyar-abeer/life_of_pi)

# 역사와 알고리즘

몬테카를로 모의시험 기법을 이용하여 원주율(π)을 구하는 과정을 살펴보는 것이다.
1700년 이전 원주율은 지름에 무언가 곱하게 되면 원둘레를 구하는 무엇으로 불렀다.
원주율은 William Jones가 1706년 원주율을 π 기호로 사용하여 단순화했다.

- 반지름이 r=1인 원을 길이가 2r 인 정사각형에 넣어 정의한다.
- 원의 면적과 정사각형 면적을 구해둔다.
- 난수를 생성하여 점을 무작위로 떨군다.
- 난수로 떨군 점 중에서 원내부에 떨어진 점과 전체 점의 비율을 구한다.

