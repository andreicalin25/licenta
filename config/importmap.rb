# Pin npm packages by running ./bin/importmap

pin "application", preload: true
pin "@hotwired/turbo-rails", to: "turbo.min.js", preload: true
pin "@hotwired/stimulus", to: "stimulus.min.js", preload: true
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js", preload: true
# pin "jquery", to: "https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js", preload: true
# pin "jquery_ujs", to: "https://cdnjs.cloudflare.com/ajax/libs/jquery-ujs/1.2.3/rails.min.js", preload: true
pin "@popperjs/core", to: "https://unpkg.com/@popperjs/core@2/dist/umd/popper.js", preload: true
pin "bootstrap", to: "https://ga.jspm.io/npm:bootstrap@5.1.3/dist/js/bootstrap.esm.js", preload: true
pin_all_from "app/javascript/controllers", under: "controllers"
pin_all_from "app/javascript/custom", under: "custom"
pin "my_scripts"

