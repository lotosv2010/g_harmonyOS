import { PullToRefreshConfigurator } from '@ohos/pulltorefresh';
import { FONT_SIZE } from  'entry/ets/constants/size'

export class BasePullToRefreshConfigurator extends PullToRefreshConfigurator {
  constructor() {
    super();
    // 设置属性
    this
      .setRefreshTextColor($r('app.color.gt_gray_7'))// 下拉加载完毕后提示文本的字体颜色
      .setRefreshTextSize(FONT_SIZE)// 下拉加载完毕后提示文本的字体大小
      .setLoadTextColor($r('app.color.gt_gray_7'))// 上拉文本的字体颜色
      .setLoadTextSize(FONT_SIZE)// 上拉文本的字体大小
      .setLoadImgHeight(20)
      .setLoadTextPullUp1('请继续上拉...')// 上拉1阶段文本
      .setLoadTextPullUp2('释放即可刷新')// 上拉2阶段文本
      .setLoadTextLoading('加载中...') // 上拉加载更多中时的文本
  }
}