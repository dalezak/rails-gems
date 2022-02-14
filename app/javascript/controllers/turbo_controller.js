import {
  get,
  post
} from '@rails/request.js'
import {
  Controller
} from "@hotwired/stimulus"
export default class extends Controller {

  getRequest(event) {
    event.preventDefault()
    get(event.target.href, {
      contentType: "text/vnd.turbo-stream.html",
      responseKind: "turbo-stream"
    })
  }

  postRequest(event) {
    event.preventDefault()
    post(event.target.href, {
      contentType: "text/vnd.turbo-stream.html",
      responseKind: "turbo-stream"
    })
  }

}