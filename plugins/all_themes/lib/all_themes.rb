
module Redcar
  class AllThemes

    def self.menus
      Menu::Builder.build do
        sub_menu "View" do
          sub_menu "Appearance" do
            group(:priority => :last) do
              sub_menu "All Themes" do
	              EditView.themes.sort.each do |theme|
                  item theme, :command => AllThemes::ShowTheme, :value => theme, :type => :radio, :active => (theme == EditView.theme)
                end
              end
            end
          end
        end
      end
    end 

    class ShowTheme < Command
      def execute(options)
        if options[:value]
          Redcar::EditView.theme=options[:value]
        end
      end
    end

  end
end
