import LoadingDialog from '@lyb/loading-dialog'
import { webview } from '@kit.ArkWeb'
import { IParam } from  'entry/ets/Interface/IBasicWeb'
import Logger from '../utils/Logger'
import { BASIC_WEB_PAGE_NAME } from '../constants/web'

@Builder
export function BasicWebPageBuilder() {
  BasicWeb()
}

@ComponentV2
export struct BasicWeb {
  private controller: webview.WebviewController = new webview.WebviewController()
  private  pageInfos: NavPathStack = new NavPathStack()
  private param: IParam = { url: '' }

  build() {
    NavDestination() {
      Web({src: this.param.url, controller: this.controller})
        .width('100%')
        .height('100%')
        .backgroundColor(Color.White)
        .multiWindowAccess(true)
        .javaScriptAccess(true)// 访问本地资源文件
        .imageAccess(true)// 权限状态开启
        .onlineImageAccess(true)// 权限状态开启
        .fileAccess(true)// 权限状态开启
        .domStorageAccess(true)// 数据存储权限
        .mediaPlayGestureAccess(true)// 媒体权限
        .mixedMode(MixedMode.All)// https 加载
        .layoutMode(WebLayoutMode.FIT_CONTENT)// 自适应布局
        .verticalScrollBarAccess(true)// 滚动条
        .horizontalScrollBarAccess(false)// 滚动条
        .cacheMode(CacheMode.Default)// 缓存
        .zoomAccess(false)// 禁止手势缩放
        .geolocationAccess(true)// 定位权限
        .onPageBegin(() => {
          LoadingDialog.showLoading()
        })// 页面加载结束
        .onPageEnd(() => {
          // 设置webview的UserAgent
          // this.getWebUserAgent()
          LoadingDialog.hide()
        })
        .onOverrideUrlLoading((webResourceRequest: WebResourceRequest) => {
          console.log('[webResourceRequest.getRequestUrl]', webResourceRequest.getRequestUrl())
          if (webResourceRequest && webResourceRequest.getRequestUrl().includes('gl://')) {
            // 解析 gl:// 协议
            // this.analysisGLUrl(webResourceRequest.getRequestUrl())
            return true;
          }
          return false;
        })
    }
    .onReady((context:  NavDestinationContext) => {
      this.pageInfos = context.pathStack
      const params: Array<IParam> = this.pageInfos.getParamByName(BASIC_WEB_PAGE_NAME) as Array<IParam>
      Logger.json(params)
      if (params?.length) {
        this.param = params[0]
      }
    })
    .hideTitleBar(true)
    .height('100%')
    .width('100%')
  }
}