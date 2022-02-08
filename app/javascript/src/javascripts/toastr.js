import toastr from 'toastr';

toastr.options = {
  closeButton: true,
};

window.toastr = toastr;

$(function () {
  const $flashMessages = $('#flash-messages').children('div');
  $flashMessages.each(function () {
    const { type, message } = this.dataset;
    const method = { notice: 'success', alert: 'error' }[type];

    toastr[method](message);
  });
});
