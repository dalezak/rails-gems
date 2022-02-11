import BaseController from "./base_controller"
export default class extends BaseController {

  static targets = ["icon"]
  static values = {
    gem: {
      type: String,
      default: ""
    }
  }

  connect() {
    let user = this.current("user-slug");
    if (user && user.length > 0) {
      let gems = this.current("user-gems", true);
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
      this.element.classList.remove("invisible");
    } else {
      this.element.classList.add("invisible");
    }
  }

}