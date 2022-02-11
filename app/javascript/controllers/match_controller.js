import {
  Controller
} from "@hotwired/stimulus"
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
    let profile = document.getElementById('profile');
    if (profile) {
      let user = profile.getAttribute('data-user')
      if (user != this.userValue) {
        let gems = profile.getAttribute('data-gems');
        let matches = this.gemsValue.filter(gem => gems.includes(gem));
        this.matchesTarget.innerHTML = matches.length;
        this.element.classList.remove("invisible");
      }
    }
  }

}