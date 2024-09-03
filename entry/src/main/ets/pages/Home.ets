import { PullToRefresh } from '@ohos/pulltorefresh'
import { BasePullToRefreshConfigurator } from 'entry/ets/model/BasePullToRefreshConfigurator'
import { PostsModel } from 'entry/ets/model/PostsModel'
import { IPost } from  'entry/ets/Interface/IPost'
import { FONT_SIZE, PADDING, PADDING_S } from  'entry/ets/constants/size'

@ComponentV2
export struct Home {
  @Param viewModel: PostsModel = PostsModel.getInstance()

  private scroller: Scroller = new Scroller()
  private refreshConfigurator = new BasePullToRefreshConfigurator().setHasRefresh(false)

  aboutToAppear(): void {
    this.viewModel.getPosts()
  }

  @Builder
  private getListView() {
    List({ scroller: this.scroller}) {
      ForEach(this.viewModel.posts, (item: IPost) => {
        ListItem() {
          Text(item.id + item.title)
            .fontSize(FONT_SIZE)
            .fontColor($r('app.color.gt_gray_6'))
        }
      })
    }
    .scrollBar(BarState.Off)
    .edgeEffect(EdgeEffect.None) // 必须设置列表为滑动到边缘无效果
    .nestedScroll({
      scrollForward: NestedScrollMode.PARENT_FIRST,
      scrollBackward: NestedScrollMode.SELF_FIRST
    })
  }

  build() {
    Column() {
      PullToRefresh({
        scroller: this.scroller,
        customList: () => {
          this.getListView()
        },
        refreshConfigurator: this.refreshConfigurator,
        onLoadMore: () => {
          return new Promise<string>((resolve) => {
            this.viewModel.getPosts()
              .then(() => {
                resolve('')
              })
          })
        },
        customLoad: null,
        customRefresh: null,
      })
    }
    .padding({
      top: PADDING,
      left: PADDING,
      right: PADDING
    })
    .backgroundColor($r('app.color.gt_green'))
    .layoutWeight(1)
  }
}