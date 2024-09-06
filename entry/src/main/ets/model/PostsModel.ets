import { HttpRequest } from 'entry/ets/utils/HttpRequest'
import { IPost } from 'entry/ets/Interface/IPost'
import Logger from 'entry/ets/utils/Logger'
import LoadingDialog from '@lyb/loading-dialog'

@ObservedV2
export class PostsModel {
  private static instance: PostsModel
  private request: HttpRequest = new HttpRequest()
  @Trace posts: Array<IPost> = []

  public static getInstance(): PostsModel {
    if (!PostsModel.instance) {
      PostsModel.instance = new PostsModel()
    }
    return PostsModel.instance
  }

  getPosts() {
    LoadingDialog.showLoading('数据正在加载中...')
    return this.request.get<Array<IPost>>('/posts')
      .then((res) => {
        Logger.json(res)
        this.posts = res
      })
      .catch((error: Error) => {
        Logger.error(error)
      })
      .finally(() => {
        LoadingDialog.hide()
      })
  }
}