import { PullToRefresh } from '@ohos/pulltorefresh'
import { BasePullToRefreshConfigurator } from 'entry/ets/model/BasePullToRefreshConfigurator'
import { CommentsModel } from 'entry/ets/model/CommentsModel'
import { OFFSET_BOTTOM, PADDING, PADDING_L } from  'entry/ets/constants/size'
import  { TravelSearch } from 'entry/ets/components/TravelSearch'
import  { TravelCard } from 'entry/ets/components/TravelCard'
import Logger from '../utils/Logger'

@ComponentV2
export struct Travel {
  @Require @Param pageInfos: NavPathStack | null = null

  @Local searchWord: string = ''

  private scroller: Scroller = new Scroller()
  private refreshConfigurator = new BasePullToRefreshConfigurator().setHasRefresh(false)
  private  viewModel: CommentsModel = CommentsModel.getInstance()

  @Monitor('searchWord')
  onSearchWordChange() {
    Logger.info(this.searchWord)
  }

  @Builder
  private getListView() {
    TravelCard({
      comments: this.viewModel.comments,
      scroller: this.scroller
    })
      .onClick(() => {
        Logger.info(this.pageInfos?.pushPathByName)
        this.pageInfos?.pushPathByName('travelDetailPage', null)
      })
  }

  build() {
    Column() {
      // 搜索和头像
      TravelSearch({
        searchWord: this.searchWord!!,
        pageInfos: this.pageInfos
      })
      // 列表卡片
      PullToRefresh({
        scroller: this.scroller,
        customList: () => {
          this.getListView()
        },
        refreshConfigurator: this.refreshConfigurator,
        onLoadMore: () => {
          return new Promise<string>((resolve) => {
            this.viewModel.getComments()
              .then(() => {
                resolve('')
              })
          })
        },
        mHeight: 530,
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