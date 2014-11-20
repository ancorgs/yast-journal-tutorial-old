require 'yast'

Yast.import "UI"
Yast.import "Label"

module SystemdJournal
  class MockupDialog

    include Yast::UIShortcuts
    include Yast::I18n
    include Yast::Logger

    def run

      Yast::UI.OpenDialog(
        Opt(:decorated, :defaultsize),
        Label(_("Hello world!"))
      )

      input = Yast::UI.UserInput

      log.info "Received #{input}"

      Yast::UI.CloseDialog
    end
  end
end
