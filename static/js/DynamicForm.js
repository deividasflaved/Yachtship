class DynamicForm {
    constructor(prefix) {
        this.prefix = prefix;
        this.init();
    }

    init() {
        // Initialize events

        this.tmpl = document.getElementById(this.prefix + '-template');
        this.formCounter = document.getElementById('id_' + this.prefix + '-TOTAL_FORMS');
        this.initChoices();
        this.addListenersToDeleteButtons();

        let addButton = document.getElementById('addForm');

        addButton.addEventListener('click', (event) => {
                this.addForm();
            }

        );
    }

    addForm() {
        let compiledTmpl = this.tmpl.innerHTML.replace(/__prefix__/g, this.formCounter.value);
        document.getElementById(this.prefix + '-form-container').insertAdjacentHTML('beforeend', compiledTmpl);

        let removeBtn = document.getElementById('remove-' + this.prefix + '-' + this.formCounter.value + '-row');

        removeBtn.addEventListener('click', (event) => {
                this.deleteForm(removeBtn);
            }

        );

        let choicesBtn = document.getElementById('id_' + this.prefix + '-' + this.formCounter.value + '-referee');
        new Choices(choicesBtn, {
            removeItemButton: true,
                searchFields: ['label'],
                placeholderValue: 'Select referees',
                position: 'inherit',
        });

        this.formCounter.value++;
    }

    deleteForm(btn) {
        let btnRow = btn.closest("tr");
        let idNum = btnRow.getAttribute('id').replace(/\D/g, '');
        let btnRowCheckbox = document.getElementById('id_' + this.prefix + '-' + idNum + '-DELETE');

        btnRow.hidden = true;
        btnRowCheckbox.checked = true;
    }

    addListenersToDeleteButtons() {
        let i = 0;

        while (document.getElementById('remove-' + this.prefix + '-' + i + '-row') != null) {
            let removeBtn = document.getElementById('remove-' + this.prefix + '-' + i + '-row');

            removeBtn.addEventListener('click', (event) => {
                    this.deleteForm(removeBtn);
                }
            );
            i++;
        }
    }
    initChoices(){
        let i = 0;
        while (document.getElementById('id_' + this.prefix + '-' + i + '-referee') != null) {
            let btn = document.getElementById('id_' + this.prefix + '-' + i + '-referee');
            new Choices(btn, {
                removeItemButton: true,
                searchFields: ['label'],
                placeholderValue: 'Select referees',
                position: 'inherit',
            });
            i++;
        }
    }
}

export {
    DynamicForm
}

export default DynamicForm