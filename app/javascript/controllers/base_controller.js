import {
  Controller
} from "@hotwired/stimulus"
export default class extends Controller {

  current(propertyName, isArray = false) {
    const results = {};
    const prefix = `current-${propertyName}`;
    for (const {
        name,
        content
      } of document.head.querySelectorAll(`meta[name^=${prefix}]`)) {
      const key = this.camelize(name.slice(prefix.length))
      if (key.length > 0) {
        results[key] = content;
      } else if (isArray) {
        return content && content.length > 0 ? JSON.parse(content) : [];
      } else {
        return content;
      }
    }
    return results;
  }

  camelize(string) {
    return string.replace(/(?:[_-])([a-z0-9])/g, (_, char) => char.toLowerCase());
  }

}