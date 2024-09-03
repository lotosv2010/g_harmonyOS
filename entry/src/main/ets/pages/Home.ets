import { PullToRefresh } from '@ohos/pulltorefresh'
import { BasePullToRefreshConfigurator } from 'entry/ets/model/BasePullToRefreshConfigurator'
import { PostsModel } from 'entry/ets/model/PostsModel'
import { IPost } from  'entry/ets/Interface/IPost'
import { FONT_SIZE, FONT_SIZE_ML, FONT_SIZE_S, PADDING, PADDING_L, SHADOW_RADIUS, BORDER_RADIUS } from  'entry/ets/constants/size'

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
      ForEach(this.viewModel.posts, (item: IPost, index: number) => {
        ListItem() {
          Flex({ justifyContent: FlexAlign.Start, direction: FlexDirection.Column }) {
            Image(index % 2 ?$r('app.media.home_card') : $r('app.media.home_card_2'))
              .height(189)
              .borderRadius({
                topLeft: BORDER_RADIUS,
                topRight: BORDER_RADIUS
              })
            Text(item.title)
              .fontSize(FONT_SIZE_S)
              .fontColor($r('app.color.gt_gray_4'))
              .textOverflow({ overflow: TextOverflow.Ellipsis })
              .maxLines(1)
              .width('100%')
              .padding({
                left: PADDING_L
              })
              .margin({
                top: PADDING,
              })
            Text(item.body)
              .padding({
                left: PADDING_L
              })
              .margin({
                bottom: 15,
              })
              .height(30)
              .fontSize(FONT_SIZE_ML)
              .fontWeight(FontWeight.Bold)
              .textOverflow({ overflow: TextOverflow.Ellipsis })
              .maxLines(1)
              .width('100%')
              .fontColor($r('app.color.gt_black_5'))
          }
        }
        .shadow({
          color: 'rgba(0, 0, 0, 0.1)',
          radius: BORDER_RADIUS,
          offsetX: 0,
          offsetY: SHADOW_RADIUS
        })
        .borderRadius(BORDER_RADIUS)
        .margin({
          bottom: 15
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
      Flex({ justifyContent: FlexAlign.SpaceBetween, alignItems: ItemAlign.Center }) {
        // 搜索框
        Search({
          value: this.searchWord,
          placeholder: '发现有趣的事物'
        })
          .searchIcon({
            src: $r('app.media.search')
          })
          .height(40)
          .width(284)
          .fontColor($r('app.color.gt_black_6'))
          .placeholderColor($r('app.color.gt_gray_5'))
          .placeholderFont({ size: FONT_SIZE, weight: FontWeight.Normal})
          .textFont({ size: FONT_SIZE, weight: FontWeight.Normal})
          .margin({
            top: 0,
            bottom: 0
          })
          .onChange((value: string) => {
            this.searchWord = value
          })
          .onSubmit((value: string) => {
            this.searchWord = value
          })
        Image($r('app.media.home_avatar'))
          .width(30)
          .height(30)
      }
      .margin({
        bottom: PADDING_L
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
        mHeight: 510,
        customLoad: null,
        customRefresh: null,
      })
    }
    .padding({
      top: PADDING,
      left: PADDING_L,
      right: PADDING_L
    })
    .backgroundColor($r('app.color.gt_white'))
    .layoutWeight(1)
  }
}