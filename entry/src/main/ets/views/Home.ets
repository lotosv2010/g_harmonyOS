import { PullToRefresh } from '@ohos/pulltorefresh'
import { BasePullToRefreshConfigurator } from 'entry/ets/model/BasePullToRefreshConfigurator'
import { PostsModel } from 'entry/ets/model/PostsModel'
import { OFFSET_BOTTOM, PADDING, PADDING_L } from  'entry/ets/constants/size'
import  { HomeSearch } from 'entry/ets/components/HomeSearch'
import { HomeCard } from 'entry/ets/components/HomeCard'
import { HomeCategories } from 'entry/ets/components/HomeCategories'
import Logger from '../utils/Logger'

@ComponentV2
export struct Home {
  @Require @Param pageInfos: NavPathStack | null = null

  @Local searchWord: string = ''

  private scroller: Scroller = new Scroller()
  private refreshConfigurator = new BasePullToRefreshConfigurator().setHasRefresh(false)
  private  viewModel: PostsModel = PostsModel.getInstance()

  @Monitor('searchWord')
  onSearchWordChange() {
    console.log('onSearchWordChange', this.searchWord)
  }

  @Builder
  private getListView() {
    HomeCard({ posts: this.viewModel.posts, scroller: this.scroller })
      .onClick(() => {
        Logger.info(this.pageInfos?.pushPathByName)
        this.pageInfos?.pushPathByName('homeDetailPage', null)
      })
  }

  build() {
    Column() {
      // 搜索和头像
      HomeSearch({
        searchWord: this.searchWord!!,
        pageInfos: this.pageInfos
      })
      // 类别 categories
      HomeCategories()
      // 列表卡片
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
        mHeight: 500,
        customLoad: null,
        customRefresh: null,
      })
    }
    .height('100%')
    .width('100%')
    .padding({
      top: PADDING,
      left: PADDING_L,
      right: PADDING_L
    })
    .backgroundColor($r('app.color.gt_white_1'))
    .layoutWeight(1)
  }
}