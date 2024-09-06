import { HttpRequest } from 'entry/ets/utils/HttpRequest'
import { IUser } from 'entry/ets/Interface/IUser'
import Logger from 'entry/ets/utils/Logger'
import LoadingDialog from '@lyb/loading-dialog'

@ObservedV2
export class UsersModel {
  private static instance: UsersModel
  private request: HttpRequest = new HttpRequest()
  @Trace users: Array<IUser> = []
  @Trace user: IUser | null = null

  public static getInstance(): UsersModel {
    if (!UsersModel.instance) {
      UsersModel.instance = new UsersModel()
    }
    return UsersModel.instance
  }

  getUsers() {
    LoadingDialog.showLoading('数据正在加载中...')
    return this.request.get<Array<IUser>>('/users')
      .then((res) => {
        Logger.json(res)
        this.users = res
      })
      .catch((error: Error) => {
        Logger.error(error)
      })
      .finally(() => {
        LoadingDialog.hide()
      })
  }

  getUserById(id: number) {
    LoadingDialog.showLoading('数据正在加载中...')
    return this.request.get<IUser>(`/users/${id}`)
      .then((res) => {
        Logger.json(res)
        this.user = res
      })
      .catch((error: Error) => {
        Logger.error(error)
      })
      .finally(() => {
        LoadingDialog.hide()
      })
  }

  getUserByPhone(phone: string) {
    LoadingDialog.showLoading('数据正在加载中...')
    return this.request.get<Array<IUser>>(`/users?phone=${phone}`)
      .then((res) => {
        Logger.json(res)
        if (res.length) {
          this.user = res[0]
        } else {
          this.user = null
        }
      })
      .catch((error: Error) => {
        Logger.error(error)
      })
      .finally(() => {
        LoadingDialog.hide()
      })
  }
}