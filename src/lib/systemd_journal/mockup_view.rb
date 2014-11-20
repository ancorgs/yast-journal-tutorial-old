require 'yast'

Yast.import "UI"
Yast.import "Label"

module SystemdJournal
  class MockupView

    include Yast::UIShortcuts
    include Yast::I18n

    def initialize
      textdomain "systemd_journal"
    end
     
    def open_main_dialog
      Yast::UI.OpenDialog(
        Opt(:decorated, :defaultsize),
        VBox(

          Frame(
            _("Log entries for"),
            RadioButtonGroup(
              Id(:time),
              VBox(*time_buttons)
            )
          ),
          VSpacing(0.3),

          Frame(
            _("Log entries generated by"),
            RadioButtonGroup(
              Id(:source),
              VBox(*source_buttons)
            )
          ),
          VSpacing(0.3),

          Right(PushButton(Id(:refresh), _("Refresh"))),
          VSpacing(0.3),

          entries_table,
          VSpacing(0.3),

          PushButton(Id(:cancel), Yast::Label.QuitButton)
        )
      )
    end

    def close
      Yast::UI.CloseDialog
    end

    def event
      Yast::UI.UserInput
    end

  private

    # Table widget (plus wrappers) to display log entries
    def entries_table
      HWeight(
        9,
        Table(
          Id(:entries_table),
          Opt(:notify, :immediate, :vstretch),
          Header(
            _("Time"),
            _("Process"),
            _("Unit"),
            _("Message"),
          ),
          []
        )
      )
    end

    # Array of radio buttons to select the time frame
    def time_buttons
      # For each option, we'll need an id, a label and, optionally,
      # some extra content
      options = [
        [:time_boot_0, _("This boot")],
        [:time_boot_1, _("Previous boot")],
      ]

      # DateField and TimeField widgets are not available in ncurses interface
      if Yast::UI.HasSpecialWidget(:DateField) && Yast::UI.HasSpecialWidget(:TimeField)
        range_extra = [
          Label(_("since")),
          DateField(Id(:time_start_date), "", ""),
          TimeField(Id(:time_start_time), "", ""),
          Label(_("until")),
          DateField(Id(:time_end_date), "", ""),
          TimeField(Id(:time_end_time), "", "")
        ]

        options << [:time_range, _("Time range"), range_extra ]
      end

      options.map do |id, label, extra|
        Left(HBox(RadioButton(Id(id), label), *extra))
      end
    end

    # Array of radio buttons to select the source to filter the entries
    def source_buttons

      # Temporary hack for mockup purposes, let's populate the units ComboBox
      # with some example values
      units = [
        "Arbitrary Executable File Formats File System Automount Point",
        "Automounts filesystems on demand",
        "ACPI Event Daemon"
      ]

      # For each option, we'll need an id, a label and, optionally,
      # some extra content
      options = [
        [:source_all, _("Any source")],     
        [:source_unit, _("Unit"), ComboBox(Id(:unit_name), "", units)],
        [:source_file, _("File"), InputField(Id(:file_name), "", "") ]
      ]

      options.map do |id, label, extra|
        Left(HBox(RadioButton(Id(id), label), *extra))
      end
    end
  end
end

