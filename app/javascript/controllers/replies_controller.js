import { Controller } from "stimulus";

export default class extends Controller {
  static targets = ["content"];

  cancelEdit(event) {
    event.preventDefault();
    this.element.innerHTML = this.data.get("originalContent");
  }
}
