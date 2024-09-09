@Builder
export function LikeDetailPageBuilder() {
  LikeDetail()
}

interface IChart {
  name: string,
  avatar: Resource,
  status: string,
  time: string,
  context: string
}

@Entry
@ComponentV2
struct LikeDetail {
  scroller: Scroller = new Scroller()
  private  pageInfos: NavPathStack = new NavPathStack()
  @Local chartList: Array<IChart> = [
    { name: '步行倒计时', avatar: $r('app.media.like_detail_avatar_1'), status: '在线', time: '2分钟前', context: '走得远了，最后也许会遇到一个人。像樵夫，像路人，出现在你与高山流水中。短短几句，让你充满温暖，引为莫逆之交。' },
    { name: '微声祈月', avatar: $r('app.media.like_detail_avatar_2'), status: '离线', time: '2024-09-01', context: '姆巴巴内森林茂密，雨量适中，气候温和，周围风光优美，是一座四季如春的山城。' },
    { name: '微声祈月', avatar: $r('app.media.like_detail_avatar_2'), status: '离线', time: '2024-09-02', context: '姆巴巴内森林茂密，雨量适中，气候温和，周围风光优美，是一座四季如春的山城。' },
    { name: '步行倒计时', avatar: $r('app.media.like_detail_avatar_1'), status: '在线', time: '2024-09-03', context: '走得远了，最后也许会遇到一个人。像樵夫，像路人，出现在你与高山流水中。短短几句，让你充满温暖，引为莫逆之交。' }
  ]

  build() {
    NavDestination(){
      Column() {
        Column() {
          Image($r('app.media.back_arrow'))
            .height(13)
            .width(20)
            .position({
              top: 20,
              left: 20
            })
            .onClick(() => {
              this.pageInfos.pop()
            })
          Image($r('app.media.like_detail_bg'))
            .height(252)
            .width(299)
            .objectFit(ImageFit.Fill)
          Text('愉快的旅途， ')
            .fontSize(18)
            .fontColor($r('app.color.gt_black_5'))
            .fontWeight(FontWeight.Bold)
            .width('100%')
            .lineHeight(26)
            .padding({
              left: 31
            })
            .margin({
              top: 22
            })
          Text('是有人和你一拍即合')
            .fontSize(18)
            .fontColor($r('app.color.gt_black_5'))
            .fontWeight(FontWeight.Bold)
            .width('100%')
            .lineHeight(26)
            .padding({
              left: 31
            })
        }
        .height(343)
        .backgroundColor($r('app.color.gt_green_0'))
        Scroll(this.scroller) {
          Column() {
            ForEach(this.chartList, (c: IChart) => {
              Flex() {
                Image(c.avatar)
                  .height(48)
                  .width(48)
                  .flexShrink(0)
                Flex({ direction: FlexDirection.Column}) {
                  Text(c.name)
                    .font({
                      size: 18,
                      weight: FontWeight.Bold,
                    })
                    .fontColor($r('app.color.gt_black_5'))
                    .lineHeight(26)
                  Text(c.status)
                    .font({
                      size: 12,
                      weight: FontWeight.Bold,
                    })
                    .fontColor( c.status === '在线' ? $r('app.color.gt_green') : $r('app.color.gt_gray_5'))
                    .lineHeight(17)
                  Text(c.context)
                    .fontSize(13)
                    .fontWeight(500)
                    .fontColor($r('app.color.gt_gray_5'))
                    .lineHeight(20)
                    .backgroundColor($r('app.color.gt_blue_0'))
                    .borderRadius({
                      topLeft: 0,
                      topRight: 16,
                      bottomLeft: 16,
                      bottomRight: 16
                    })
                    .padding(15)
                    .margin({
                      top: 10
                    })
                  Text(c.time)
                    .fontSize(12)
                    .fontWeight(FontWeight.Bold)
                    .fontColor($r('app.color.gt_gray_6'))
                    .lineHeight(17)
                    .margin({
                      top: 10
                    })
                }
                .margin({
                  left: 16
                })
              }
              .padding({
                left: 30,
                right: 30
              })
              .margin({
                bottom: 27
              })
            })
          }
          .padding({
            top: 31
          })
        }
        .backgroundColor('#FEFEFE')
        .scrollable(ScrollDirection.Vertical) // 滚动方向
        .scrollBar(BarState.Off) // 滚动条常驻显示
      }
      .height('calc(100% - 343vp)')
      .width('100%')
      .backgroundColor($r('app.color.gt_white_1'))
    }
    .hideTitleBar(true)
    .onReady((context:  NavDestinationContext) => {
      this.pageInfos = context.pathStack
    })
  }
}