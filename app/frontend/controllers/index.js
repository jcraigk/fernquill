import { Application } from "@hotwired/stimulus"

const application = Application.start()
const controllers = import.meta.glob("./**/*_controller.js", { eager: true })

for (const [path, module] of Object.entries(controllers)) {
  const name = path.replace("./", "").replace("_controller.js", "").replaceAll("/", "--").replaceAll("_", "-")
  application.register(name, module.default)
}

export { application }
