import { SwiperItem } from 'entry/ets/components/StartSwiperItem'
import { ISwiperItem } from '../Interface/SwiperItem'

@Entry
@ComponentV2
struct Start {
  private pageInfos: NavPathStack = new NavPathStack()
  private swiperController: SwiperController = new SwiperController()
  private data: Array<ISwiperItem> = [
    {
      title: '发现你的旅伴',
      body: '你在找旅伴嘛？我们已帮助百万旅游爱好者找到了它们完美的旅伴…',
      imageSource: $r('app.media.start_bg_1'),
      flexDirection: FlexDirection.Column,
      textAlign: TextAlign.Center
    },
    {
      title: '发现你的旅伴',
      body: '幸福的旅途，是有人和你一拍即合，旅途的美景美事与志同道合的人分享，我们已帮助百万旅游爱好者找到了它们完美的旅伴…',
      imageSource: $r('app.media.start_bg_2'),
      flexDirection: FlexDirection.ColumnReverse,
      textAlign: TextAlign.Start
    }
  ]

  build() {
    Navigation(this.pageInfos) {
      Column({ space: 5 }) {
        Swiper(this.swiperController) {
          ForEach(this.data, (item: ISwiperItem) => {
            SwiperItem({
              flexDirection: item.flexDirection,
              imageSource: item.imageSource,
              title: item.title,
              body: item.body,
              textAlign: item.textAlign
            })
          })
        }
        .cachedCount(2)
        .index(1)
        .autoPlay(false)
        .interval(4000)
        .loop(true)
        .indicatorInteractive(true)
        .duration(1000)
        .itemSpace(0)
        .indicator( // 设置圆点导航点样式
          new DotIndicator()
            .bottom(0)
            .itemWidth(5)
            .itemHeight(3)
            .selectedItemWidth(11)
            .selectedItemHeight(3)
            .color($r('app.color.gt_gray_2'))
            .selectedColor('#FFBB00')
        )
        .displayArrow({ // 设置导航点箭头样式
          showBackground: true,
          isSidebarMiddle: true,
          backgroundSize: 24,
          backgroundColor: Color.White,
          arrowSize: 18,
          arrowColor: Color.Blue
        }, false)
        .curve(Curve.Linear)

        Row({ space: 12 }) {
          Button('跳过', { type: ButtonType.Normal, stateEffect: true })
            .borderRadius(4)
            .height(48)
            .width(152)
            .fontColor($r('app.color.gt_black_7'))
            .backgroundColor($r('app.color.gt_white'))
            .border({
              width: 1,
              style: BorderStyle.Solid,
              radius: 4,
              color: $r('app.color.gt_black_7')
            })
            .onClick(() => {
              this.pageInfos.replacePathByName('homePage', null)
            })
          Button('下一步', { type: ButtonType.Normal, stateEffect: true })
            .borderRadius(4)
            .height(48)
            .width(152)
            .backgroundColor($r('app.color.gt_black_7'))
            .border({
              width: 1,
              radius: 4,
              style: BorderStyle.Solid,
              color: $r('app.color.gt_black_7')
            })
            .onClick(() => {
              this.pageInfos.replacePathByName('loginPage', null)
            })
        }.margin(5)
      }.width('100%')
      .margin({ top: 30 })
    }
    .hideTitleBar(true)
  }
}