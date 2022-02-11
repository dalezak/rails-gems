import {
  get,
  post
} from '@rails/request.js'
import BaseController from "./base_controller"
export default class extends BaseController {

  getTurboSteam(event) {
    event.preventDefault()
    get(event.target.href, {
      contentType: "text/vnd.turbo-stream.html",
      responseKind: "turbo-stream"
    })
  }

  postTurboSteam(event) {
    event.preventDefault()
    post(event.target.href, {
      contentType: "text/vnd.turbo-stream.html",
      responseKind: "turbo-stream"
    })
  }

}