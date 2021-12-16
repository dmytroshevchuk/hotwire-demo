import { Controller } from 'stimulus';
import debounce from 'lodash.debounce';

const STATUSES = [
  'not_started',
  'in_progress',
  'testing',
  'accepted',
  'archived'
]

export default class extends Controller {
  static targets = ['status'];

  static values = {
    currentStatus: String,
    issueId: Number
  };

  initialize() {
    this.toggleStatus();
  }

  nextStatus() {
    const nextStatus = this.nextStatusIndex();

    this.setCurrentStatus(STATUSES[nextStatus]);
    this.updateStatus();
  }

  nextStatusIndex() {
    const index = STATUSES.indexOf(this.currentStatusValue) + 1;

    return STATUSES[index] ? index : 0;
  }

  toggleStatus() {
    this.statusTargets.forEach((element, index) => {
      element.classList.toggle('current-status', this.currentStatusValue === STATUSES[index]);
    })
  }

  updateStatus() {
    const csrfToken = document.querySelector("meta[name='csrf-token']").getAttribute('content');

    fetch(`/issues/${this.issueIdValue}.json`, {
      method: 'PUT',
      headers: {
        'Content-Type': 'application/json',
        'X-CSRF-Token': csrfToken
      },
      body: JSON.stringify({
        issue: {
          status: this.currentStatusValue
        }
      })
    })
  }

  setCurrentStatus(status) {
    this.currentStatusValue = status;
    this.toggleStatus();
  }
}
