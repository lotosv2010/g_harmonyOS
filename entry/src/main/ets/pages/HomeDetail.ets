@Builder
export function HomeDetailPageBuilder() {
  HomeDetail()
}

@Entry
@Component
struct HomeDetail {
  @State message: string = 'Hello World';

  build() {
    NavDestination(){
      Column() {
        Text(this.message)
          .id('HomeDetailHelloWorld')
          .fontSize(50)
          .fontColor(Color.Black)
          .fontWeight(FontWeight.Bold)
      }
      .height('100%')
      .width('100%')
    }.hideTitleBar(true)
  }
}