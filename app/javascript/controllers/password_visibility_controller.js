import { Controller } from 'stimulus';

export default class extends Controller {
  static targets = ['toggleLink', 'passwordInput'];

  toggle() {
    if (this.toggleLink.textContent === 'show') {
      this.toggleLink.textContent = 'hide';
      this.passwordInput.type = 'text';
    } else {
      this.toggleLink.textContent = 'show';
      this.passwordInput.type = 'password';
    }
  }

  get toggleLink() {
    return this.toggleLinkTarget;
  }

  get passwordInput() {
    return this.passwordInputTarget;
  }
}
