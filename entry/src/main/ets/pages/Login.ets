import { BORDER_RADIUS_S, FONT_SIZE } from '../constants/size'

@Builder
export function LoginPageBuilder() {
  Login()
}

@Entry
@ComponentV2
struct Login {

  @Local phoneNumber: string = ''
  @Local password: string = ''

  build() {
    NavDestination() {
      Column() {
        Image($r('app.media.login_bg'))
          .height(268)
          .width(292)
          .objectFit(ImageFit.Fill)
        Text('登录')
          .fontSize(36)
          .fontWeight(FontWeight.Bold)
          .fontColor($r('app.color.gt_gray_8'))
          .lineHeight(52)
          .alignSelf(ItemAlign.Start)
          .margin({
            top: 30
          })
        TextInput({
          text: this.phoneNumber,
          placeholder: '请输入手机号码'
        })
          .type(InputType.PhoneNumber)
          .fontColor($r('app.color.gt_black_6'))
          .placeholderColor($r('app.color.gt_gray_5'))
          .borderRadius(BORDER_RADIUS_S)
          .margin({
            top: 26
          })
        Stack() {
          Text('111')
          TextInput({
            text: this.password,
            placeholder: '请输入密码'
          })
            .type(InputType.Password)
            .fontColor($r('app.color.gt_black_6'))
            .placeholderColor($r('app.color.gt_gray_5'))
            .borderRadius(BORDER_RADIUS_S)
            .showPasswordIcon(false)
            .margin({
              top: 20
            })
        }
        Button('登录', { type: ButtonType.Normal, stateEffect: true })
          .borderRadius(4)
          .height(48)
          .width('100%')
          .backgroundColor($r('app.color.gt_black_7'))
          .border({
            width: 1,
            radius: 4,
            style: BorderStyle.Solid,
            color: $r('app.color.gt_black_7')
          })
          .margin({
            top: 48
          })
        Row() {
          Text('还没有账号？ 点击 ')
            .fontColor($r('app.color.gt_black_5'))
            .fontSize(FONT_SIZE)
          Text('注册')
            .decoration({
              type: TextDecorationType.Underline,
              color: $r('app.color.gt_black_5')
            })
            .fontColor($r('app.color.gt_black_5'))
            .fontSize(FONT_SIZE)
            .onClick(() => {
              console.log('注册')
            })
        }
        .margin({
          top: 15
        })
      }
      .width('100%')
      .padding({
        top: 30,
        left: 30,
        right: 30
      })
    }
    .onBackPressed(() => {
      return true
    })
    .hideTitleBar(true)
  }
}