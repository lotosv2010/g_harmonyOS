import { HttpRequest } from 'entry/ets/utils/HttpRequest'
import { IComment } from 'entry/ets/Interface/IComment'
import Logger from 'entry/ets/utils/Logger'
import LoadingDialog from '@lyb/loading-dialog'

@ObservedV2
export class CommentsModel {
  private static instance: CommentsModel
  private request: HttpRequest = new HttpRequest()
  @Trace comments: Array<IComment> = []

  public static getInstance(): CommentsModel {
    if (!CommentsModel.instance) {
      CommentsModel.instance = new CommentsModel()
    }
    return CommentsModel.instance
  }

  getComments() {
    LoadingDialog.showLoading('数据正在加载中...')
    return this.request.get<Array<IComment>>('/comments')
      .then((res) => {
        Logger.json(res)
        this.comments = res
      })
      .catch((error: Error) => {
        Logger.error(error)
      })
      .finally(() => {
        LoadingDialog.hide()
      })
  }
}