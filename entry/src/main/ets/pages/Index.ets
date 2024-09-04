import { Home } from './Home'

@Builder
export function HomePageBuilder() {
  Index()
}

@Entry
@ComponentV2
struct Index {
  @Local currentIndex: number = 0
  private pageInfos: NavPathStack = new NavPathStack()

  IsActivated(index: number) {
    return this.currentIndex === index
  }

  color(index: number) {
    return this.currentIndex === index ? $r('app.color.gt_blue') : $r('app.color.gt_gray_6')
  }

  @Builder
  tabBarBuilder(title: string, index: number, normalImage: Resource, selectedImage: Resource ) {
    Column() {
      Image(this.IsActivated(index) ? selectedImage : normalImage)
        .size({ width: 20, height: 20})
        .objectFit(ImageFit.Contain)
        .align(Alignment.Center)
        .margin({
          bottom: 5
        })
      Text(title)
        .fontColor(this.color(index))
        .fontSize(12)
    }
    .width('100%')
    .height(50)
    .justifyContent(FlexAlign.Center)
  }

  build() {
    NavDestination() {
      Tabs({ barPosition: BarPosition.End }) {
        TabContent() {
          Home()
        }
        .tabBar(this.tabBarBuilder('首页', 0, $r('app.media.tab_home_normal'), $r('app.media.tab_home_selected')))

        TabContent() {
          Text('旅行').fontSize(30)
        }
        .tabBar(this.tabBarBuilder('旅行', 1, $r('app.media.tab_travel_normal'), $r('app.media.tab_travel_selected')))

        TabContent() {
          Text('喜欢').fontSize(30)
        }
        .tabBar(this.tabBarBuilder('喜欢', 2, $r('app.media.tab_like_normal'), $r('app.media.tab_like_selected')))

        TabContent() {
          Text('我的内容').fontSize(30)
        }
        .tabBar(this.tabBarBuilder('我的', 4, $r('app.media.tab_my_normal'), $r('app.media.tab_my_selected')))
      }
      .barHeight(50)
      .scrollable(false)
      .animationDuration(100)
      .onChange((index: number) => {
        this.currentIndex = index
      })
    }
    .onBackPressed(() => {
      return true
    })
    .hideTitleBar(true)
  }
}