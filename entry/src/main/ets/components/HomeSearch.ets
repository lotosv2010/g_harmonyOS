import { FONT_SIZE, PADDING, PADDING_L } from  'entry/ets/constants/size'

@ComponentV2
export struct  HomeSearch {
  @Require @Param searchWord:string = ''
  @Require @Param pageInfos: NavPathStack | null = null
  @Event $searchWord: (value: string) => void

  jumpAppLogin() {
    this.pageInfos?.pushPathByName?.('loginPage', null)
  }

  build() {
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
        .onChange(this.$searchWord)
        .onSubmit(this.$searchWord)
      Image($r('app.media.home_avatar'))
        .width(30)
        .height(30)
        .onClick(() => {
          this.jumpAppLogin()
        })
    }
    .margin({
      bottom: PADDING_L
    })
  }
}