-- Word title page, the lines under the author name, taken from `title-page` in the YAML.
function Meta(m)
  if not FORMAT:match("docx") or not m["title-page"] then return nil end
  local lines = pandoc.List()
  if pandoc.utils.type(m.author) == "List" then lines:extend(m.author) else lines:insert(m.author) end
  lines:extend(m["title-page"])
  m.author = pandoc.MetaList(lines)
  m.date = nil
  return m
end
