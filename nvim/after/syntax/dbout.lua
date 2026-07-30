vim.cmd([[
  syntax match DboutRecord /^-\[ RECORD \d\+ \].*$/
  syntax match DboutSeparator /^[-+ ]\+$/
  syntax match DboutDelimiter /|/
  syntax match DboutRowCount /^(\d\+ rows\?)$/
  syntax match DboutNull /\<NULL\>/
  syntax match DboutError /^ERROR:.*$/
  syntax match DboutNotice /^NOTICE:.*$/

  highlight default link DboutRecord Title
  highlight default link DboutSeparator Comment
  highlight default link DboutDelimiter Delimiter
  highlight default link DboutRowCount MoreMsg
  highlight default link DboutNull NonText
  highlight default link DboutError DiagnosticError
  highlight default link DboutNotice DiagnosticInfo
]])
