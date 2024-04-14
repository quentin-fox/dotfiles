vim.filetype.add({
  filename = {
    ['Fastfile'] = 'ruby',
    ['Pluginfile'] = 'ruby',
    ['Appfile'] = 'ruby',
    ['Podfile'] = 'ruby'
  }
})

vim.filetype.add({
  extension = { templ = 'templ' }
})
