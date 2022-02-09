import { Controller } from '@hotwired/stimulus';

class FlashController extends Controller {
  static values = { type: String, message: String };

  connect() {
    const toastrType = this.convertToToastrType(this.typeValue);
    toastr[toastrType](this.messageValue);
  }

  convertToToastrType(type) {
    return { notice: 'success', alert: 'error' }[type];
  }
}

export default FlashController;
