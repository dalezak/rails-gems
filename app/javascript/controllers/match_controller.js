import BaseController from "./base_controller"
export default class extends BaseController {

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
    let user = this.current("user-slug");
    if (user && user.length > 0 && user != this.userValue) {
      let gems = this.current("user-gems", true);
      let matches = this.gemsValue.filter(gem => gems.includes(gem));
      this.matchesTarget.innerHTML = matches.length;
      this.element.classList.remove("invisible");
    } else {
      this.element.classList.add("invisible");
    }
  }

}