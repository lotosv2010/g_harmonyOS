import { FONT_SIZE_ML, PADDING_L } from  'entry/ets/constants/size'

@ComponentV2
export struct HomeCategories {
  @Local categories: Array<Resource> = [
    $r('app.media.category_compass'),
    $r('app.media.category_map'),
    $r('app.media.category_airplane'),
    $r('app.media.category_like')
  ]

  build() {
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
  }
}