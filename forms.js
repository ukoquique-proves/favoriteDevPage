(function () {
    document.addEventListener('DOMContentLoaded', function () {
        document.querySelectorAll('form[data-formspree-form]').forEach(function (form) {
            const endpoint = form.dataset.formspreeEndpoint || window.PUPPYTEACH_FORM_CONFIG?.formspreeEndpoint || 'https://formspree.io/f/mnjyeeod';
            form.action = endpoint;
            form.setAttribute('accept-charset', 'utf-8');
        });
    });
})();
