
module Redcar
  class EditTabPlugin < Redcar::Plugin
    def self.load(plugin) #:nodoc:
      puts "loading EditTabPlugin"
      puts caller
      Hook.register :tab_changed
      Hook.register :tab_save
      Hook.register :tab_load
      
      Sensitive.register(:edit_tab, 
                         [:open_window, :new_tab, :close_tab, 
                          :after_focus_tab]) do
        Redcar.win and Redcar.tab and Redcar.tab.is_a? EditTab
      end
      
      Sensitive.register(:modified?, 
                         [:open_window, :new_tab, :close_tab, 
                          :after_focus_tab, :tab_changed, 
                          :after_tab_save]) do
        Redcar.tab and Redcar.tab.is_a? EditTab and Redcar.tab.modified
      end
      
      Sensitive.register(:modified_and_filename?, 
                         [:open_window, :new_tab, :close_tab, 
                          :after_focus_tab, :tab_changed, 
                          :after_tab_save]) do
        Redcar.tab and Redcar.tab.is_a? EditTab and Redcar.tab.modified and Redcar.tab.filename
      end
      
#       Sensitive.register(:selected_text, 
#                          [:open_window, :new_tab, :close_tab, 
#                           :after_focus_tab]) do
#         win and tab and tab.is_a? EditTab
#       end

      Dir[File.dirname(__FILE__) + "/lib/*"].each {|f| Kernel.load f}
      Dir[File.dirname(__FILE__) + "/tabs/*"].each {|f| load f}
      require File.dirname(__FILE__) + "/commands/edit_tab"
      Dir[File.dirname(__FILE__) + "/commands/*"].each {|f| load f}

      Redcar::EditTab::Indenter.lookup_indent_rules
      Redcar::EditTab::AutoPairer.lookup_autopair_rules

      plugin.transition(FreeBASE::LOADED)
    end

    def self.start(plugin) #:nodoc:
      Redcar::EditTab::SnippetInserter.load_snippets
      plugin.transition(FreeBASE::RUNNING)
    end
  end
end