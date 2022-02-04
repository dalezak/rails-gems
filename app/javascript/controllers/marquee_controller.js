import {
  Controller
} from "@hotwired/stimulus"
export default class extends Controller {

  static targets = ["phrase"]
  static values = {
    phrases: {
      type: Array,
      default: []
    }
  }

  connect() {
    this.changePhrase(0);
  }

  changePhrase(index) {
    setInterval(() => {
      this.phraseTarget.classList.add('fade');
      setTimeout(() => {
        this.phraseTarget.innerHTML = this.phrasesValue[index];
        index++;
        index %= this.phrasesValue.length;
        this.phraseTarget.classList.remove('fade');
      }, 1000);
    }, 6000);
  }

}