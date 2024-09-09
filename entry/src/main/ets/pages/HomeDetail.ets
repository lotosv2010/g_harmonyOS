import { BORDER_RADIUS, FONT_SIZE_ML, PADDING_L, SHADOW_RADIUS } from '../constants/size';

@Builder
export function HomeDetailPageBuilder() {
  HomeDetail()
}

interface ICard {
  title: string,
  imageUrl: Resource
}

@Entry
@ComponentV2
struct HomeDetail {
  scroller: Scroller = new Scroller()
  private  pageInfos: NavPathStack = new NavPathStack()
  private cardList: Array<ICard> = [
    { title: '一键入住酒店', imageUrl: $r('app.media.home_detail_card_1')},
    { title: '交通指南', imageUrl:  $r('app.media.home_detail_card_2')},
    { title: '附近美食', imageUrl:  $r('app.media.home_detail_card_1')}
  ]

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
          Text('详情')
            .fontColor($r('app.color.gt_black_5'))
            .fontWeight(FontWeight.Bold)
            .fontSize(18)
        }
        .width('100%')
        .height(50)
        .id('title')
        Column() {
          Text('发现你的旅伴')
            .fontSize(18)
            .fontColor($r('app.color.gt_black_5'))
            .fontWeight(FontWeight.Bold)
            .width('100%')
            .padding({
              left: 20,
              right: 20
            })
            .margin({
              top: 25
            })
          Text('走得远了，最后也许会遇到一个人。像樵夫，像路人，出现在你与高山流水中。短短几句，让你充满温暖，引为莫逆之交。')
            .width('100%')
            .fontSize(12)
            .lineHeight(17)
            .letterSpacing(0)
            .fontColor($r('app.color.gt_gray_5'))
            .fontWeight(FontWeight.Bold)
            .padding({
              left: 20,
              right: 20
            })
            .margin({
              top: 6
            })
          Image($r('app.media.home_detail_main_bg'))
            .height(229)
            .objectFit(ImageFit.Fill)
        }
        .height(366)
        .margin({
          top: 12
        })
        .borderRadius(BORDER_RADIUS)
        .shadow({
          color: 'rgba(0, 0, 0, 0.1)',
          radius: BORDER_RADIUS,
          offsetX: 0,
          offsetY: SHADOW_RADIUS
        })
        Column() {
          Text('目的地小帮手')
            .fontSize(FONT_SIZE_ML)
            .fontColor($r('app.color.gt_black_5'))
            .fontWeight(FontWeight.Bold)
            .width('100%')
            .margin({
              top: 30,
              bottom: 8
            })
          Scroll(this.scroller) {
            Row() {
              ForEach(this.cardList, (card: ICard) => {
                Flex({ direction: FlexDirection.Column, alignItems: ItemAlign.Center }) {
                  Image(card.imageUrl)
                    .width(129)
                    .height(172)
                    .objectFit(ImageFit.Fill)
                  Text(card.title)
                    .width('100%')
                    .fontSize(14)
                    .fontWeight(FontWeight.Bold)
                    .fontColor($r('app.color.gt_black_5'))
                    .padding({
                      left: 20,
                      right: 20
                    })
                    .margin({
                      top: 17,
                      bottom: 17
                    })
                }
                .shadow({
                  color: 'rgba(0, 0, 0, 0.1)',
                  radius: BORDER_RADIUS,
                  offsetX: 0,
                  offsetY: SHADOW_RADIUS
                })
                .flexShrink(0)
                .width(141)
                .height(230)
                .borderRadius(BORDER_RADIUS)
                .backgroundColor($r('app.color.gt_white'))
                .margin({
                  right: 25,
                  bottom: 8
                })
              })
            }
          }
          .scrollable(ScrollDirection.Horizontal) // 滚动方向
          .scrollBar(BarState.Off) // 滚动条常驻显示
        }
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