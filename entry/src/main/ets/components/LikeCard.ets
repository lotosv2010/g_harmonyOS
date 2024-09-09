import { IUser } from  'entry/ets/Interface/IUser'
import { FONT_SIZE_S, PADDING, PADDING_L, BORDER_RADIUS, PADDING_S } from  'entry/ets/constants/size'

@ComponentV2
export struct LikeCard {
  @Param users: Array<IUser> = []
  @Param scroller: Scroller = new Scroller()

  @Builder

  build() {
    List({ scroller: this.scroller}) {
      ForEach(this.users, (item: IUser, index: number) => {
        ListItem() {
          Flex({ justifyContent: FlexAlign.SpaceBetween, alignItems: ItemAlign.Center }) {
            Flex({  justifyContent: FlexAlign.SpaceBetween, alignItems: ItemAlign.Center }) {
              Image(index % 2 ? $r('app.media.start_bg_1') : $r('app.media.home_avatar'))
                .height(56)
                .width(56)
                .flexShrink(0)
                .borderRadius('50%')
              Flex({ direction: FlexDirection.Column, justifyContent: FlexAlign.Center }) {
                Text(item.name)
                  .fontSize(18)
                  .fontWeight(FontWeight.Bold)
                  .fontColor($r('app.color.gt_black_5'))
                  .textOverflow({ overflow: TextOverflow.Ellipsis })
                  .maxLines(1)
                  .width('100%')
                Text(item.remark)// .height(30)
                  .fontSize(FONT_SIZE_S)
                  .fontWeight(500)
                  .textOverflow({ overflow: TextOverflow.Ellipsis })
                  .maxLines(3)
                  .width('100%')
                  .fontColor($r('app.color.gt_gray_5'))
                  .margin({
                    top: 5
                  })
              }
              .margin({
                left: PADDING,
              })
            }
            Image($r('app.media.like_more'))
              .height(12)
              .width(3)
          }
        }
        .height(96)
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
        .padding({
          left: 20,
          right: 20
        })
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