export const current = new Proxy({}, {
  get(target, propertyName) {
    const results = {}
    const prefix = `current-${propertyName}`
    for (const {
        name,
        content
      } of document.head.querySelectorAll(`meta[name^=${prefix}]`)) {
      const key = camelize(name.slice(prefix.length))
      if (key.length > 0) {
        results[key] = content;
      } else {
        return content;
      }
    }
    return results
  }
})

function camelize(string) {
  return string.replace(/(?:[_-])([a-z0-9])/g, (_, char) => char.toLowerCase())
}