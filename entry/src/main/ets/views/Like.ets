import { PullToRefresh } from '@ohos/pulltorefresh'
import { BasePullToRefreshConfigurator } from 'entry/ets/model/BasePullToRefreshConfigurator'
import { UsersModel } from 'entry/ets/model/UsersModel'
import { OFFSET_BOTTOM, PADDING, PADDING_L } from  'entry/ets/constants/size'
import  { LikeSearch } from 'entry/ets/components/LikeSearch'
import { LikeCard } from 'entry/ets/components/LikeCard'
import Logger from '../utils/Logger'

@ComponentV2
export struct Like {
  @Require @Param pageInfos: NavPathStack | null = null

  @Local searchWord: string = ''

  private scroller: Scroller = new Scroller()
  private refreshConfigurator = new BasePullToRefreshConfigurator().setHasRefresh(false)
  private  viewModel: UsersModel = UsersModel.getInstance()

  aboutToAppear(): void {
    this.viewModel.getUsers()
  }

  @Monitor('searchWord')
  onSearchWordChange() {
    console.log('onSearchWordChange', this.searchWord)
  }

  @Builder
  private getListView() {
    LikeCard({
      users: this.viewModel.users,
      scroller: this.scroller
    })
      .onClick(() => {
        Logger.info(this.pageInfos?.pushPathByName)
        this.pageInfos?.pushPathByName('likeDetailPage', null)
      })
  }

  build() {
    Column() {
      // 搜索和头像
      LikeSearch({
        searchWord: this.searchWord!!
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
            this.viewModel.getUsers()
              .then(() => {
                resolve('')
              })
          })
        },
        mHeight: 590,
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