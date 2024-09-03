import { PullToRefresh } from '@ohos/pulltorefresh'
import { BasePullToRefreshConfigurator } from 'entry/ets/model/BasePullToRefreshConfigurator'
import { PostsModel } from 'entry/ets/model/PostsModel'
import { IPost } from  'entry/ets/Interface/IPost'
import { FONT_SIZE, FONT_SIZE_ML, FONT_SIZE_S, PADDING, PADDING_L, PADDING_S } from  'entry/ets/constants/size'
import { HashSet } from '@kit.ArkTS'

@ComponentV2
export struct Home {
  @Param viewModel: PostsModel = PostsModel.getInstance()
  @Local searchWord: string = ''
  @Local categories: Array<Resource> = [
    $r('app.media.category_compass'),
    $r('app.media.category_map'),
    $r('app.media.category_airplane'),
    $r('app.media.category_like')
  ]

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
          Flex({ justifyContent: FlexAlign.Start, direction: FlexDirection.Column }) {
            Image($r('app.media.home_card'))
              .height(189)
            Text(item.title)
              .fontSize(FONT_SIZE_S)
              .fontColor($r('app.color.gt_gray_4'))
              .textOverflow({ overflow: TextOverflow.Ellipsis })
              .maxLines(1)
              .width('100%')
              .margin({
                top: PADDING
              })
            Text(item.body)
              .margin({
                top: PADDING_S
              })
              .fontSize(FONT_SIZE_ML)
              .fontWeight(FontWeight.Bold)
              .textOverflow({ overflow: TextOverflow.Ellipsis })
              .maxLines(1)
              .width('100%')
              .fontColor($r('app.color.gt_black_5'))
          }
        }
        .margin({
          bottom: PADDING_L
        })
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
      // 搜索框
      Search({
        value: this.searchWord,
        placeholder: '发现有趣的事物'
      })
        .searchIcon({
          src: $r('app.media.search')
        })
        .height(40)
        .fontColor($r('app.color.gt_black_6'))
        .placeholderColor($r('app.color.gt_gray_5'))
        .placeholderFont({ size: FONT_SIZE, weight: FontWeight.Normal})
        .textFont({ size: FONT_SIZE, weight: FontWeight.Normal})
        .margin({
          top: 0,
          bottom: PADDING_L
        })
        .onChange((value: string) => {
          this.searchWord = value
        })
        .onSubmit((value: string) => {
          this.searchWord = value
        })
      // 类别 categories
      Column() {
        Flex({ justifyContent: FlexAlign.Start }) {
          Text('即将到来的活动')
            .fontSize(FONT_SIZE_ML)
            .fontWeight(FontWeight.Bold)
            .fontColor($r('app.color.gt_black_5'))
            .textAlign(TextAlign.Start)
            .margin({
              bottom: PADDING_L
            })
        }
        Flex({justifyContent: FlexAlign.SpaceBetween}) {
          ForEach(this.categories, (item: Resource) => {
            Image(item)
              .width(74).height(74)
          })
        }
      }
      .margin({
        bottom: PADDING_L
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
      top: PADDING_S,
      left: PADDING,
      right: PADDING
    })
    .backgroundColor($r('app.color.gt_white'))
    .layoutWeight(1)
  }
}