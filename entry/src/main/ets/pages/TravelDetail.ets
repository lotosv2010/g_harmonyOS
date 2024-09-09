import { PADDING_L } from '../constants/size';

@Builder
export function TravelDetailPageBuilder() {
  TravelDetail()
}

@Entry
@ComponentV2
struct TravelDetail {
  private  pageInfos: NavPathStack = new NavPathStack()

  private body = '\r一个月前比利时知名纹身师Rouslan和俄罗斯设计师Lesya在网上认识并相爱，一周前他们见面并结婚组成家庭。Lesya在脸部纹上了他未婚夫的名字‘RUSLAN’。很多人都说Lesya这次做了草率的决定并且以后会后悔。但是有时最好的决定是你心里一瞬间的想法而不是在你脑中长期争论的犹豫。\n\n\r一瞬间的想法我将意大利、新西兰 、冰岛 、南非 、古巴的选择划掉了前面四项。 美国对古巴的经济、贸易和金融封锁多年，让 古巴 一直停留在旧时代的样子。随着 古巴 美国 关系逐渐缓和，很多地方都在 新建 。恐怕过多没多久， 古巴 就不再是这幅模样了，所以我不想迟到。用相机寻找那些印象中理所当然的残旧，记录这个最好的旧时代模样。'

  build() {
    NavDestination(){
      Column() {
        Flex({ alignItems: ItemAlign.Center, justifyContent: FlexAlign.Center}) {
          Image($r('app.media.back_arrow'))
            .height(13)
            .width(20)
            .position({
              top: 20,
              left: 0
            })
            .onClick(() => {
              this.pageInfos.pop()
            })
          Text('发现')
            .fontColor($r('app.color.gt_black_5'))
            .fontWeight(FontWeight.Bold)
            .fontSize(18)
        }
        .width('100%')
        .height(50)
        Column() {
          Image($r('app.media.travel_detail_bg'))
            .height(285)
            .objectFit(ImageFit.Fill)
          Text('我去过的过去 谁同行 谁远去')
            .fontSize(19)
            .fontColor($r('app.color.gt_black_5'))
            .fontWeight(FontWeight.Bold)
            .width('100%')
            .margin({
              top: 15
            })
          Text('2019/09/07   斯威士兰')
            .width('100%')
            .fontSize(12)
            .lineHeight(17)
            .letterSpacing(0)
            .fontColor($r('app.color.gt_gray_5'))
            .fontWeight(500)
            .margin({
              top: 10
            })
          Text(this.body)
            .width('100%')
            .fontSize(12)
            .lineHeight(17)
            .letterSpacing(0)
            .fontColor($r('app.color.gt_gray_5'))
            .fontWeight(500)
            .margin({
              top: 14
            })
        }
        .padding({
          left: 35,
          right: 35
        })
        .margin({
          top: 12
        })
      }
      .height('100%')
      .width('100%')
      .backgroundColor($r('app.color.gt_white_1'))
      .padding({
        left: PADDING_L,
        right: PADDING_L
      })
    }
    .hideTitleBar(true)
    .onReady((context:  NavDestinationContext) => {
      this.pageInfos = context.pathStack
    })
  }
}