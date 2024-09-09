import { Home } from 'entry/ets/views/Home'
import { Travel } from 'entry/ets/views/Travel'
import { Like } from 'entry/ets/views/Like'
import { My } from 'entry/ets/views/My'
import { PostsModel } from 'entry/ets/model/PostsModel'
import { CommentsModel } from 'entry/ets/model/CommentsModel'
import { UsersModel } from 'entry/ets/model/UsersModel'

@Builder
export function HomePageBuilder() {
  Index()
}

@Entry
@ComponentV2
struct Index {
  @Local currentIndex: number = 0
  private  pageInfos: NavPathStack = new NavPathStack()

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
          Home({
            pageInfos: this.pageInfos
          })
        }
        .tabBar(this.tabBarBuilder('首页', 0, $r('app.media.tab_home_normal'), $r('app.media.tab_home_selected')))
        .onWillShow(() => {
          PostsModel.getInstance().getPosts()
        })

        TabContent() {
          Travel({
            pageInfos: this.pageInfos
          })
        }
        .tabBar(this.tabBarBuilder('旅行', 1, $r('app.media.tab_travel_normal'), $r('app.media.tab_travel_selected')))
        .onWillShow(() => {
          CommentsModel.getInstance().getComments()
        })

        TabContent() {
          Like({
            pageInfos: this.pageInfos
          })
        }
        .tabBar(this.tabBarBuilder('喜欢', 2, $r('app.media.tab_like_normal'), $r('app.media.tab_like_selected')))
        .onWillShow(() => {
          UsersModel.getInstance().getUsers()
        })

        TabContent() {
          My({
            pageInfos: this.pageInfos
          })
        }
        .tabBar(this.tabBarBuilder('我的', 3, $r('app.media.tab_my_normal'), $r('app.media.tab_my_selected')))
      }
      .barHeight(50)
      .scrollable(false)
      .animationDuration(100)
      .expandSafeArea([SafeAreaType.SYSTEM],[SafeAreaEdge.TOP])
      .onChange((index: number) => {
        this.currentIndex = index
      })
    }
    .onBackPressed(() => {
      return true
    })
    .onReady((context: NavDestinationContext) => {
      this.pageInfos = context.pathStack
    })
    .hideTitleBar(true)
  }
}