if (window.location.toString().endsWith("content_manager/chambas")) {
  document.addEventListener('DOMContentLoaded', function () {
    let alert = document.querySelector('.alert')
    let salary = document.querySelector('#chamba_salary')
    let title = document.querySelector('#chamba_title')
    let location = document.querySelector('#chamba_location')
    let organization = document.querySelector('#chamba_organization')
    let date = document.querySelector('#chamba_exp_date')
    let stall = document.querySelector('#chamba_stall')
    let description = document.querySelector('#chamba_description')
    let requirements = document.querySelector('#chamba_requirements')
    let updateBtn = document.querySelector('#createChambaBtn')
    const editBtn = document.querySelectorAll("#editBtn")
    const form = document.querySelector('#new_chamba')
    const inputHidden = document.createElement('input')
    const cancelBtn = document.createElement('button')
    inputHidden.type = 'hidden'
    inputHidden.name = 'chamba[id]'
    inputHidden.value = ''
    form.appendChild(inputHidden)

    document.querySelector('html').style.scrollBehavior = 'smooth'

    editBtn.forEach(element => {
      scrollTo(0, 0)
      let fields = {
        id: element.getAttribute('data-id'),
        title: element.getAttribute('data-title'),
        location: element.getAttribute('data-location'),
        organization: element.getAttribute('data-organization'),
        date: element.getAttribute('data-exp_date'),
        stall: element.getAttribute('data-stall'),
        salary: element.getAttribute('data-salary'),
        description: element.getAttribute('data-description'),
        requirements: element.getAttribute('data-requirements')
      }

      element.addEventListener('click', () => {
        window.scrollTo(0, 0)
        updateBtn.innerHTML = 'Actualizar chambita'
        form.action = "/admin/content_manager/update_chamba_list"

        updateFields(fields)
        createCancelBtn()

        cancelBtn.addEventListener('click', cleanForm)
      })
    })

    if (alert) {
      setTimeout(() => {
        alert.remove()
      }, 5000);
    }

    salary.addEventListener('keypress', e => {
      if (!onlyNumbers(event)) {
        e.preventDefault()
      }
    })
    function onlyNumbers(e) {
      var key = e.charCode;
      return key >= 48 && key <= 57;
    }

    function createCancelBtn() {
      cancelBtn.setAttribute('id', 'cancelUpdateBtn')
      cancelBtn.setAttribute('class', 'btn btn-primary')
      cancelBtn.style.backgroundColor = '#e9ecef'
      cancelBtn.style.color = '#495057'
      cancelBtn.style.border = 'none'
      cancelBtn.innerText = 'Cancelar'
      form.appendChild(cancelBtn)
    }

    function cleanForm() {
      form.reset()
      updateBtn.innerHTML = 'Crear chambita'
      form.action = "/chambas"
      form.removeChild(cancelBtn)
    }

    function updateFields(fields) {
      inputHidden.value = `${fields.id}`
      title.value = fields.title
      location.value = fields.location
      organization.value = fields.organization
      date.value = fields.date
      stall.value = fields.stall
      salary.value = fields.salary
      description.value = fields.description
      requirements.value = fields.requirements
    }

  }, false);
}