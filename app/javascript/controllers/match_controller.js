import {
  Controller
} from "@hotwired/stimulus"
import {
  current
} from "../helpers/current_helpers"
export default class extends Controller {

  static targets = ["matches"]
  static values = {
    user: {
      type: String,
      default: ""
    },
    gems: {
      type: Array,
      default: []
    }
  }

  connect() {
    let user = current.user.slug
    if (user && user.length > 0 && user != this.userValue) {
      let gems = JSON.parse(current.user.gems);
      let matches = this.gemsValue.filter(gem => gems.includes(gem));
      this.matchesTarget.innerHTML = matches.length;
      this.element.classList.remove("invisible");
    } else {
      this.element.classList.add("invisible");
    }
  }

}