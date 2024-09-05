import Logger from 'entry/ets/utils/Logger'
import LoadingDialog from '@lyb/loading-dialog';
import { BORDER_RADIUS_S, FONT_SIZE } from 'entry/ets/constants/size'
import { UsersModel } from 'entry/ets/model/UsersModel'

@Builder
export function LoginPageBuilder() {
  Login()
}

@Entry
@ComponentV2
struct Login {
  @Local phoneNumber: string = '15209876543'
  @Local password: string = '15209876543'
  private viewModel: UsersModel = UsersModel.getInstance()
  private  pageInfos: NavPathStack = new NavPathStack()

  private login() {
    if (!this.phoneNumber) {
      LoadingDialog.showToast('请输入手机号')
      return
    }
    if (!this.password) {
      LoadingDialog.showToast('请输入密码')
      return
    }
    LoadingDialog.showLoading()
    this.viewModel.getUserByPhone(this.phoneNumber)
      .then(() => {
        console.log('getUserByPhone1', JSON.stringify(this.viewModel.user))
        if(this.viewModel.user) {
          Logger.json(this.viewModel.user)
          this.pageInfos.pushPathByName('homePage', null)
        } else {
          LoadingDialog.showFailure('用户名或密码错误')
        }
      })
      .finally(() => {
        LoadingDialog.hide()
      })
  }

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
        Stack() {
          Image($r('app.media.login_phone_number'))
            .height(17)
            .width(17)
            .objectFit(ImageFit.Fill)
            .margin({
              left: 20
            })
          TextInput({
            text: this.phoneNumber,
            placeholder: '请输入手机号码'
          })
            .type(InputType.PhoneNumber)
            .fontColor($r('app.color.gt_black_6'))
            .placeholderColor($r('app.color.gt_gray_5'))
            .borderRadius(BORDER_RADIUS_S)
            .padding({
              left: 49
            })
            .onChange((value: string) => {
              this.phoneNumber = value
            })
        }
        .margin({
          top: 26
        })
        .align(Alignment.Start)
        Stack() {
          Image($r('app.media.login_password'))
            .height(17)
            .width(17)
            .objectFit(ImageFit.Fill)
            .margin({
              left: 20
            })
          TextInput({
            text: this.password,
            placeholder: '请输入密码'
          })
            .type(InputType.Password)
            .fontColor($r('app.color.gt_black_6'))
            .placeholderColor($r('app.color.gt_gray_5'))
            .borderRadius(BORDER_RADIUS_S)
            .showPasswordIcon(false)
            .padding({
              left: 49
            })
            .onChange((value: string) => {
              this.password = value
            })
        }
        .margin({
          top: 20
        })
        .align(Alignment.Start)
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
          .onClick(() => this.login())
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
    .onReady((context: NavDestinationContext) => {
      this.pageInfos = context.pathStack
    })
    .hideTitleBar(true)
  }
}