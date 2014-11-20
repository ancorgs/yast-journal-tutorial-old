require 'yast'
require 'systemd_journal/mockup_view'

module SystemdJournal
  class MockupController

    include Yast::Logger

    def run
      @view = MockupView.new

      return unless @view.open_main_dialog

      begin
        return event_loop
      ensure
        @view.close
      end
    end

  private

    def event_loop
      keep_running = true
      while keep_running
        method = :"#{@view.event.to_s}_callback"
        if respond_to?(method, true)
          keep_running = send(method)
        else
          log.warn "Method #{method} not implemented"
        end
      end
    end

    def cancel_callback
      false
    end
  end
end
