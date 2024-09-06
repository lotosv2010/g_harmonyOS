import { FONT_SIZE, PADDING_L } from  'entry/ets/constants/size'

@ComponentV2
export struct  TravelSearch {
  @Require @Param searchWord:string = ''
  @Require @Param pageInfos: NavPathStack | null = null
  @Event $searchWord: (value: string) => void

  jumpAppLogin() {
    this.pageInfos?.pushPathByName?.('loginPage', null)
  }

  build() {
    Flex({ direction: FlexDirection.Column }) {
      Flex({ justifyContent: FlexAlign.SpaceBetween }) {
        // 标题
        Text('在旅上')
          .fontSize(30)
          .fontColor($r('app.color.gt_black_5'))
          .fontWeight(FontWeight.Bold)
        // 头像
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
      Text('结交世界各地的旅伴')
        .fontSize(20)
        .fontColor($r('app.color.gt_black_5'))
        .fontWeight(FontWeight.Bold)
        .height(30)
        .margin({
          top: 27
        })
    }
    .margin({
      bottom: PADDING_L
    })
    .height(150)
  }
}