import { SwiperItem } from 'entry/ets/components/StartSwiperItem'
import { ISwiperItem } from '../Interface/SwiperItem'

@Entry
@ComponentV2
struct Start {
  @Local time = 0
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
  private timer: number | null = null

  onPageShow() {
    this.setTime()
  }

  jumpToAppHome() {
    this.clear()
    this.pageInfos.pushPathByName('homePage', null)
  }

  setTime() {
    this.timer = setInterval(() => {
      this.time++
      if (this.time === 5) {
        this.jumpToAppHome()
      }
    }, 1000)
  }

  clear() {
    if (this.timer !== null) {
      clearInterval(this.timer)
      this.timer = null
    }
  }

  build() {
    Navigation(this.pageInfos) {
      Column({ space: 5 }) {
        Text(`跳过 ${this.time.toString()} s`)
          .fontColor($r('app.color.gt_white'))
          .position({
            top: 0,
            right: 30
          })
          .backgroundColor('#33000000')
          .textAlign(TextAlign.Center)
          .borderRadius(19)
          .height(38)
          .width(90)
          .zIndex(100)
          .onClick(() => {
            this.jumpToAppHome()
          })
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
        .index(0)
        .autoPlay(true)
        .interval(2000)
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
      }.width('100%')
      .margin({ top: 30 })
    }
    .hideTitleBar(true)
  }
}