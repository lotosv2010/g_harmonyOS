import { FONT_SIZE_S } from '../constants/size'

@ComponentV2
export struct SwiperItem {
  @Param flexDirection = FlexDirection.Column
  @Param imageSource: Resource = $r('app.media.start_bg_1')
  @Param textAlign = TextAlign.Start
  @Param title: string = ''
  @Param body: string = ''

  build() {
    Flex({ direction: this.flexDirection, justifyContent: FlexAlign.SpaceBetween, alignItems: ItemAlign.Center }) {
      Image(this.imageSource)
        .height(300)
        .width(300)
        .margin({
          top: this.flexDirection === FlexDirection.Column ? 0 : 8
        })
        .objectFit(ImageFit.Fill)
      Column() {
        Text(this.title)
          .lineHeight(32)
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .textAlign(this.textAlign)
          .alignSelf(this.flexDirection === FlexDirection.Column ?ItemAlign.Center : ItemAlign.Start)
        Text(this.body)
          .fontSize(13)
          .fontColor($r('app.color.gt_gray_6'))
          .textAlign(this.textAlign)
          .margin({
            top: 8
          })
      }
      .width('100%')
    }
    .margin({
      top: 115,
      bottom: 30
    })
    .padding({
      left: 30,
      right: 30
    })
    .width('100%')
    .height(410)
  }
}