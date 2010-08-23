
Plugin.define do
  name    "all_themes"
  version "1.0"
  file    "lib", "all_themes"
  object  "Redcar::AllThemes"
  dependencies "textmate",  ">0"
end
