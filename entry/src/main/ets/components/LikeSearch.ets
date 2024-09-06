import { FONT_SIZE, PADDING_L } from  'entry/ets/constants/size'

@ComponentV2
export struct  LikeSearch {
  @Require @Param searchWord:string = ''
  @Event $searchWord: (value: string) => void

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
        .width('100%')
        .fontColor($r('app.color.gt_black_6'))
        .placeholderColor($r('app.color.gt_gray_5'))
        .placeholderFont({ size: FONT_SIZE, weight: FontWeight.Normal})
        .textFont({ size: FONT_SIZE, weight: FontWeight.Normal})
        .margin({
          top: 0,
          bottom: 0
        })
        .onChange(this.$searchWord)
        .onSubmit(this.$searchWord)

      // 小标题
      Text('高匹配度旅伴推荐')
        .fontSize(20)
        .fontColor($r('app.color.gt_black_5'))
        .fontWeight(FontWeight.Bold)
        .textAlign(TextAlign.Start)
        .height(30)
        .width('100%')
        .margin({
          top: PADDING_L
        })
    }
    .margin({
      bottom: PADDING_L
    })
  }
}