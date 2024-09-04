import { IPost } from  'entry/ets/Interface/IPost'
import { FONT_SIZE_ML, FONT_SIZE_S, PADDING, PADDING_L, SHADOW_RADIUS, BORDER_RADIUS } from  'entry/ets/constants/size'

@ComponentV2
export struct HomeCard {
  @Param posts: Array<IPost> = []
  @Param scroller: Scroller = new Scroller()

  @Builder

  build() {
    List({ scroller: this.scroller}) {
      ForEach(this.posts, (item: IPost, index: number) => {
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
}