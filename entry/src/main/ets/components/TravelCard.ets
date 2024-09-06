import { IComment } from  'entry/ets/Interface/IComment'
import { FONT_SIZE_S, PADDING, PADDING_L, BORDER_RADIUS, PADDING_S } from  'entry/ets/constants/size'

@ComponentV2
export struct TravelCard {
  @Param comments: Array<IComment> = []
  @Param scroller: Scroller = new Scroller()

  @Builder

  build() {
    List({ scroller: this.scroller}) {
      ForEach(this.comments, (item: IComment, index: number) => {
        ListItem() {
          Flex({ justifyContent: FlexAlign.Start }) {
            Image($r(`app.media.travel_list_${index % 4 + 1}`))
              .height(134)
              .width(134)
              .flexShrink(0)
              .borderRadius({
                topLeft: BORDER_RADIUS,
                bottomLeft: BORDER_RADIUS
              })
            Flex({ direction: FlexDirection.Column }) {
              Flex({ justifyContent: FlexAlign.SpaceBetween, alignItems: ItemAlign.Center }) {
                Text(item.title)
                  .fontSize(18)
                  .fontWeight(FontWeight.Bold)
                  .fontColor($r('app.color.gt_black_5'))
                  .textOverflow({ overflow: TextOverflow.Ellipsis })
                  .maxLines(1)
                  .width('100%')
                Text(`${item.score?.toFixed(1)}`)
                  .width(50)
                  .height(24)
                  .textAlign(TextAlign.Center)
                  .fontSize(14)
                  .fontWeight(FontWeight.Bold)
                  .borderRadius(12)
                  .fontColor($r('app.color.gt_white'))
                  .backgroundColor($r('app.color.gt_red'))
              }
              .margin({
                bottom: PADDING,
              })

              Text(item.body)
                // .height(30)
                .fontSize(FONT_SIZE_S)
                .fontWeight(500)
                .textOverflow({ overflow: TextOverflow.Ellipsis })
                .maxLines(3)
                .width('100%')
                .fontColor($r('app.color.gt_gray_5'))
            }
            .margin({
              left: PADDING_S,
              top: PADDING_L,
              bottom: PADDING_S,
              right: PADDING
            })
          }
        }
        .shadow({
          type: ShadowType.COLOR,
          color: 'rgba(0, 0, 0, 0.1)',
          radius: BORDER_RADIUS,
          offsetX: 0,
          offsetY: 5,
        })
        .backdropBlur(27)
        .backgroundColor('rgba(255, 255, 255, 0.9)')
        .borderRadius(BORDER_RADIUS)
        .margin({
          bottom: 14
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