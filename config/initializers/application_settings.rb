# frozen_string_literal: true

# Rails loads initializer files alphabetically! Always make sure to name this file in the beginnings.
# dummy settings hash to prevent growing organizational settings in codebase.
# TODO: will refactor when we decide how to manage organizational settings

settings = {
  "omu" => {
    "host" => "https://nokul.app.omu.sh",
    "email" => {
      "domain" => "omu.edu.tr",
      "default_from" => "noreply@baum.omu.edu.tr",
      "support" => "hotline@baum.omu.edu.tr"
    }
  }
}

current_organization = 'omu'

SETTINGS = settings[current_organization]
