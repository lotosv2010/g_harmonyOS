import axios, {
  AxiosError,
  AxiosHeaders,
  AxiosInstance,
  AxiosRequestConfig,
  AxiosResponse,
  InternalAxiosRequestConfig
} from '@ohos/axios'
import { HashMap } from '@kit.ArkTS'
import { http } from '@kit.NetworkKit'
import { HttpRequestConfigMethod } from '../enum/HttpRequest'
import Logger from './Logger'

export class HttpRequest {
  private instance: AxiosInstance
  constructor(header?: HashMap<string, ESObject>) {
    let config: AxiosRequestConfig = {
      baseURL: 'https://my-json-server.typicode.com/lotosv2010/json-server',
      timeout: 1000 * 10
    }
    const headers: AxiosHeaders = new AxiosHeaders()
    headers.set('Accept', '*/*')
    headers.set('Content-Type', 'application/x-www-form-urlencoded')
    headers.set('Accept-Language', 'zh_CN')
    headers.set('Timestamp', new Date().getTime())
    headers.set('Client-Info', '{"clientAppVersion":"0.0.1", "deviceCode":"0.0.1","trader":"HarmonyOS","traderName":"gt_travel"}')

    header?.forEach((value: ESObject, key) => {
      headers.set(key, value)
    })
    config.headers = headers
    this.instance = axios.create(config)
    this.createInterceptors()
  }

  createInterceptors() {
    this.instance.interceptors.request.use((config: InternalAxiosRequestConfig) => {
      return config
    }, (error: AxiosError) => {
      return Promise.reject(error)
    })
    this.instance.interceptors.response.use((response: AxiosResponse) => {
      return response
    }, (error: AxiosError) => {
      return Promise.reject(error)
    })
  }

  private request<T>(config: AxiosRequestConfig): Promise<T> {
    return new Promise((resolve, reject) => {
      this.instance.request(config)
        .then((res: AxiosResponse<T>) => {
          if (res.status === http.ResponseCode.OK) {
            resolve(res.data)
          } else {
            reject(res.data)
          }
        })
        .catch((error: AxiosError) => {
          Logger.error(error.message)
          reject(error.message)
        })
    })
  }

  get<T>(url: string, params?: ESObject): Promise<T> {
    return this.request<T>({
      url,
      method: HttpRequestConfigMethod.GET,
      params
    })
  }

  post<T>(url: string, data: ESObject): Promise<T> {
    return this.request<T>({
      url,
      method: HttpRequestConfigMethod.POST,
      data,
    })
  }

  put<T>(url: string, data: ESObject): Promise<T> {
    return this.request<T>({
      url,
      method: HttpRequestConfigMethod.PUT,
      data
    })
  }

  delete<T>(url: string, data: ESObject): Promise<T> {
    return this.request<T>({
      url,
      method: HttpRequestConfigMethod.DELETE,
      data
    })
  }
}