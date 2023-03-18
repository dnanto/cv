-- https://gist.github.com/tarleb/afee1b1d97e52aca888f410e77b3624a?permalink_comment_id=3783260#gistcomment-3783260


local highlight_author_filter = {
  Para = function(el)
    if el.t == "Para" then
    for k, _ in ipairs(el.content) do
      if el.content[k].t == "Str" and el.content[k].text == "Negrón,"
      and el.content[k+1].t == "Space"
      and el.content[k+2].t == "Str" and el.content[k+2].text:find("^D.") then
          local _, e = el.content[k+2].text:find("^D.")
          local rest = el.content[k+2].text:sub(e+1) 
          el.content[k] = pandoc.Strong { pandoc.Str("Negrón, D.") }
          el.content[k+1] = pandoc.Str(rest)
          table.remove(el.content, k+2) 
      end
    end
  end
  return el
  end
}

function Block (div)
    return pandoc.walk_block(div, highlight_author_filter)
end
