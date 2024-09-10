import { AlertDialog } from '@kit.ArkUI';
import { UsersModel } from 'entry/ets/model/UsersModel';
import { PADDING, PADDING_L } from  'entry/ets/constants/size';
import LoadingDialog from '@lyb/loading-dialog';
import Logger from '../utils/Logger';
import { IParam } from  'entry/ets/Interface/IBasicWeb';
import { BASIC_WEB_PAGE_NAME } from '../constants/web';

interface ISetting {
  key: string
  title: string
  icon?: Resource
  hasToggle?: boolean
  onClick?: () => void
}

@ComponentV2
export struct My {
  @Require @Param pageInfos: NavPathStack | null = null
  @Local phoneNumber: string = '15209876543'

  private settings: Array<ISetting> = [
    { key: 'profile', title: '个人信息', icon: $r('app.media.my_icon_profile_circle') },
    { key: 'notification', title: '通知', icon: $r('app.media.my_icon_notification'), onClick: (): void => this.openWeb() },
    { key: 'message', title: 'FAQ', icon: $r('app.media.my_icon_message') },
    { key: 'theme', title: '黑色主题', hasToggle: true },
    { key: 'language', title: '语言', icon: $r('app.media.my_icon_global') },
    { key: 'logout', title: '退出', onClick: (): void => this.logout() }
  ]

  private  viewModel: UsersModel = UsersModel.getInstance()

  aboutToAppear(): void {
    this.viewModel.getUserByPhone(this.phoneNumber)
  }

  logoutDialog: CustomDialogController =  new CustomDialogController({
    builder: AlertDialog({
      primaryTitle: '提示',
      content: '确认要退出当前账号？',
      primaryButton: {
        value: '取消',
        action: () => {
        },
      },
      secondaryButton: {
        value: '确认',
        role: ButtonRole.ERROR,
        action: () => {
          this.pageInfos?.pushPathByName('loginPage', null)
        }
      },
    }),
  })

  logout() {
    Logger.info('logout')
    this.logoutDialog.open()
  }

  openWeb() {
    const param: IParam = {
      url: Math.random() > 0.5 ? 'https://cn.vuejs.org/' : 'https://www.harmonyos.com/'
    }
    this.pageInfos?.pushPath({
      name: BASIC_WEB_PAGE_NAME,
      param
    })
  }

  onPageShow(): void {
    LoadingDialog.showInfo('123')
  }

  build() {
    Column() {
      Flex({ alignItems: ItemAlign.Center }) {
        Image($r('app.media.home_avatar'))
          .width(50)
          .height(50)
          .flexShrink(0)
        Flex({ direction: FlexDirection.Column}) {
          Text(this.viewModel.user?.name)
            .fontSize(18)
            .fontColor($r('app.color.gt_black_5'))
            .fontWeight(FontWeight.Bold)
            .lineHeight(27)
            .letterSpacing('1%')
          Text(this.viewModel.user?.remark)
            .fontSize(12)
            .fontColor($r('app.color.gt_gray_5'))
            .fontWeight(400)
            .lineHeight(22)
            .letterSpacing('1%')
        }
        .margin({
          left: 20
        })
      }
      .width('100%')
      .height(48)
      ForEach(this.settings, (s: ISetting) => {
        Flex({ justifyContent: FlexAlign.SpaceBetween, alignItems: ItemAlign.Center}) {
          Text(s.title)
            .fontSize(14)
            .fontColor($r('app.color.gt_black_5'))
            .fontWeight(500)
            .lineHeight(24)
            .letterSpacing('1%')
          if (s.icon) {
            if (s.key === 'notification') {
              Image(Math.random() > 0.5 ? s.icon : $r('app.media.my_icon_notification_unread'))
                .height(20)
                .width(20)
            } else {
              Image(s.icon)
                .height(20)
                .width(20)
            }
          }
          if (s.hasToggle) {
            Toggle({ type: ToggleType.Switch, isOn: false })
              .height(30)
              .width(55)
          }
        }
        .height(64)
        .padding(20)
        .margin({
          top: 30
        })
        .border({
          width: 1,
          color: $r('app.color.gt_gray_4'),
          style: BorderStyle.Solid,
          radius: 20
        })
        .onClick(() => {
          if(s.onClick) {
            s.onClick()
          }
        })
      })
    }
    .height('100%')
    .width('100%')
    .padding({
      top: PADDING,
      left: PADDING_L,
      right: PADDING_L
    })
    .backgroundColor($r('app.color.gt_white'))
    .layoutWeight(1)
  }
}