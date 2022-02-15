import {
  Controller
} from "@hotwired/stimulus"
import {
  current
} from "../helpers/current_helpers"
export default class extends Controller {

  static targets = ["icon"]
  static values = {
    gem: {
      type: String,
      default: ""
    }
  }

  connect() {
    let user = current.user.slug;
    if (user && user.length > 0) {
      let gems = JSON.parse(current.user.gems);
      this.iconTarget.classList.remove("fas", "far");
      this.element.classList.remove("btn-primary", "btn-outline-primary");
      if (gems.includes(this.gemValue)) {
        this.element.title = "Liked";
        this.iconTarget.classList.add("fas");
        this.element.classList.add("btn-primary");
      } else {
        this.element.title = "Like";
        this.iconTarget.classList.add("far");
        this.element.classList.add("btn-outline-primary");
      }
    }
  }

}