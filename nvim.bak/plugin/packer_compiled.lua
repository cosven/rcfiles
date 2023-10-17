-- Automatically generated packer.nvim plugin loader code

if vim.api.nvim_call_function('has', {'nvim-0.5'}) ~= 1 then
  vim.api.nvim_command('echohl WarningMsg | echom "Invalid Neovim version for packer.nvim! | echohl None"')
  return
end

vim.api.nvim_command('packadd packer.nvim')

local no_errors, error_msg = pcall(function()

_G._packer = _G._packer or {}
_G._packer.inside_compile = true

local time
local profile_info
local should_profile = false
if should_profile then
  local hrtime = vim.loop.hrtime
  profile_info = {}
  time = function(chunk, start)
    if start then
      profile_info[chunk] = hrtime()
    else
      profile_info[chunk] = (hrtime() - profile_info[chunk]) / 1e6
    end
  end
else
  time = function(chunk, start) end
end

local function save_profiles(threshold)
  local sorted_times = {}
  for chunk_name, time_taken in pairs(profile_info) do
    sorted_times[#sorted_times + 1] = {chunk_name, time_taken}
  end
  table.sort(sorted_times, function(a, b) return a[2] > b[2] end)
  local results = {}
  for i, elem in ipairs(sorted_times) do
    if not threshold or threshold and elem[2] > threshold then
      results[i] = elem[1] .. ' took ' .. elem[2] .. 'ms'
    end
  end
  if threshold then
    table.insert(results, '(Only showing plugins that took longer than ' .. threshold .. ' ms ' .. 'to load)')
  end

  _G._packer.profile_output = results
end

time([[Luarocks path setup]], true)
local package_path_str = "/Users/cosven/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?.lua;/Users/cosven/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?/init.lua;/Users/cosven/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?.lua;/Users/cosven/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/Users/cosven/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/lua/5.1/?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

time([[Luarocks path setup]], false)
time([[try_loadstring definition]], true)
local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s), name, _G.packer_plugins[name])
  if not success then
    vim.schedule(function()
      vim.api.nvim_notify('packer.nvim: Error running ' .. component .. ' for ' .. name .. ': ' .. result, vim.log.levels.ERROR, {})
    end)
  end
  return result
end

time([[try_loadstring definition]], false)
time([[Defining packer_plugins]], true)
_G.packer_plugins = {
  ale = {
    loaded = true,
    path = "/Users/cosven/.local/share/nvim/site/pack/packer/start/ale",
    url = "https://github.com/dense-analysis/ale"
  },
  ["fidget.nvim"] = {
    config = { "\27LJ\2\n4\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\vfidget\frequire\0" },
    loaded = true,
    path = "/Users/cosven/.local/share/nvim/site/pack/packer/start/fidget.nvim",
    url = "https://github.com/j-hui/fidget.nvim"
  },
  gruvbox = {
    loaded = true,
    path = "/Users/cosven/.local/share/nvim/site/pack/packer/start/gruvbox",
    url = "https://github.com/morhetz/gruvbox"
  },
  nerdtree = {
    loaded = true,
    path = "/Users/cosven/.local/share/nvim/site/pack/packer/start/nerdtree",
    url = "https://github.com/preservim/nerdtree"
  },
  ["nvim-lspconfig"] = {
    config = { "\27LJ\2\nd\0\0\6\0\6\0\v6\0\0\0006\2\1\0009\2\2\0026\4\1\0009\4\3\0049\4\4\0049\4\5\4B\4\1\0A\2\0\0A\0\0\1K\0\1\0\27list_workspace_folders\bbuf\blsp\finspect\bvim\nprint³\b\1\2\t\0,\0¢\0016\2\0\0009\2\1\0029\2\2\0025\4\3\0B\2\2\0016\2\0\0009\2\4\0029\2\5\2\18\4\1\0'\5\6\0'\6\a\0B\2\4\0015\2\b\0=\1\t\0026\3\0\0009\3\n\0039\3\v\3'\5\f\0'\6\r\0006\a\0\0009\a\14\a9\a\15\a9\a\16\a\18\b\2\0B\3\5\0016\3\0\0009\3\n\0039\3\v\3'\5\f\0'\6\17\0006\a\0\0009\a\14\a9\a\15\a9\a\18\a\18\b\2\0B\3\5\0016\3\0\0009\3\n\0039\3\v\3'\5\f\0'\6\19\0006\a\0\0009\a\14\a9\a\15\a9\a\20\a\18\b\2\0B\3\5\0016\3\0\0009\3\n\0039\3\v\3'\5\f\0'\6\21\0006\a\0\0009\a\14\a9\a\15\a9\a\22\a\18\b\2\0B\3\5\0016\3\0\0009\3\n\0039\3\v\3'\5\f\0'\6\23\0006\a\0\0009\a\14\a9\a\15\a9\a\24\a\18\b\2\0B\3\5\0016\3\0\0009\3\n\0039\3\v\3'\5\f\0'\6\25\0006\a\0\0009\a\14\a9\a\15\a9\a\26\a\18\b\2\0B\3\5\0016\3\0\0009\3\n\0039\3\v\3'\5\f\0'\6\27\0006\a\0\0009\a\14\a9\a\15\a9\a\28\a\18\b\2\0B\3\5\0016\3\0\0009\3\n\0039\3\v\3'\5\f\0'\6\29\0006\a\0\0009\a\14\a9\a\15\a9\a\30\a\18\b\2\0B\3\5\0016\3\0\0009\3\n\0039\3\v\3'\5\f\0'\6\31\0003\a \0\18\b\2\0B\3\5\0016\3\0\0009\3\n\0039\3\v\3'\5\f\0'\6!\0006\a\0\0009\a\14\a9\a\15\a9\a\"\a\18\b\2\0B\3\5\0016\3\0\0009\3\n\0039\3\v\3'\5\f\0'\6#\0006\a\0\0009\a\14\a9\a\15\a9\a$\a\18\b\2\0B\3\5\0016\3\0\0009\3\n\0039\3\v\3'\5\f\0'\6%\0006\a\0\0009\a\14\a9\a\15\a9\a&\a\18\b\2\0B\3\5\0016\3\0\0009\3\n\0039\3\v\3'\5\f\0'\6'\0006\a\0\0009\a\14\a9\a\15\a9\a(\a\18\b\2\0B\3\5\0016\3)\0'\5*\0B\3\2\0029\3+\3\18\5\0\0\18\6\1\0B\3\3\1K\0\1\0\vattach\15nvim-navic\frequire\15formatting\r<space>f\16code_action\14<space>ca\vrename\14<space>rn\20type_definition\r<space>D\0\14<space>wl\28remove_workspace_folder\14<space>wr\25add_workspace_folder\14<space>wa\19signature_help\n<C-k>\nhover\6K\15references\agr\19implementation\agi\15definition\agd\16declaration\bbuf\blsp\agD\6n\bset\vkeymap\vbuffer\1\0\2\fnoremap\2\vsilent\2\27v:lua.vim.lsp.omnifunc\romnifunc\24nvim_buf_set_option\bapi\1\0\1\17virtual_text\1\vconfig\15diagnostic\bvim¸\1\1\0\6\0\f\0\0223\0\0\0006\1\1\0'\3\2\0B\1\2\0029\1\3\0019\1\4\0015\3\5\0=\0\6\3B\1\2\0016\1\1\0'\3\2\0B\1\2\0029\1\a\0019\1\4\0015\3\b\0=\0\6\0035\4\t\0004\5\0\0=\5\n\4=\4\v\3B\1\2\1K\0\1\0\rsettings\18rust-analyzer\1\0\0\1\0\0\18rust_analyzer\14on_attach\1\0\0\nsetup\fpyright\14lspconfig\frequire\0\0" },
    loaded = true,
    path = "/Users/cosven/.local/share/nvim/site/pack/packer/start/nvim-lspconfig",
    url = "https://github.com/neovim/nvim-lspconfig"
  },
  ["nvim-navic"] = {
    loaded = true,
    path = "/Users/cosven/.local/share/nvim/site/pack/packer/start/nvim-navic",
    url = "https://github.com/SmiteshP/nvim-navic"
  },
  ["packer.nvim"] = {
    loaded = true,
    path = "/Users/cosven/.local/share/nvim/site/pack/packer/start/packer.nvim",
    url = "https://github.com/wbthomason/packer.nvim"
  },
  ["plenary.nvim"] = {
    loaded = true,
    path = "/Users/cosven/.local/share/nvim/site/pack/packer/start/plenary.nvim",
    url = "https://github.com/nvim-lua/plenary.nvim"
  },
  ["rust.vim"] = {
    loaded = true,
    path = "/Users/cosven/.local/share/nvim/site/pack/packer/start/rust.vim",
    url = "https://github.com/rust-lang/rust.vim"
  },
  ["telescope-project.nvim"] = {
    loaded = true,
    path = "/Users/cosven/.local/share/nvim/site/pack/packer/start/telescope-project.nvim",
    url = "https://github.com/nvim-telescope/telescope-project.nvim"
  },
  ["telescope.nvim"] = {
    config = { "\27LJ\2\nü\1\0\0\n\0\17\0\0236\0\0\0'\2\1\0B\0\2\0029\1\2\0005\3\r\0005\4\t\0005\5\a\0005\6\5\0006\a\0\0'\t\3\0B\a\2\0029\a\4\a=\a\6\6=\6\b\5=\5\n\0045\5\v\0=\5\f\4=\4\14\3B\1\2\0019\1\15\0'\3\16\0B\1\2\1K\0\1\0\fproject\19load_extension\rdefaults\1\0\0\fpreview\1\0\1\20hide_on_startup\2\rmappings\1\0\0\6i\1\0\0\n<Tab>\1\0\0\19toggle_preview\29telescope.actions.layout\nsetup\14telescope\frequire\0" },
    loaded = true,
    path = "/Users/cosven/.local/share/nvim/site/pack/packer/start/telescope.nvim",
    url = "https://github.com/nvim-telescope/telescope.nvim"
  },
  ["vim-airline"] = {
    loaded = true,
    path = "/Users/cosven/.local/share/nvim/site/pack/packer/start/vim-airline",
    url = "https://github.com/vim-airline/vim-airline"
  },
  ["vim-startify"] = {
    loaded = true,
    path = "/Users/cosven/.local/share/nvim/site/pack/packer/start/vim-startify",
    url = "https://github.com/mhinz/vim-startify"
  },
  ["which-key.nvim"] = {
    loaded = true,
    path = "/Users/cosven/.local/share/nvim/site/pack/packer/start/which-key.nvim",
    url = "https://github.com/folke/which-key.nvim"
  }
}

time([[Defining packer_plugins]], false)
-- Config for: fidget.nvim
time([[Config for fidget.nvim]], true)
try_loadstring("\27LJ\2\n4\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\vfidget\frequire\0", "config", "fidget.nvim")
time([[Config for fidget.nvim]], false)
-- Config for: telescope.nvim
time([[Config for telescope.nvim]], true)
try_loadstring("\27LJ\2\nü\1\0\0\n\0\17\0\0236\0\0\0'\2\1\0B\0\2\0029\1\2\0005\3\r\0005\4\t\0005\5\a\0005\6\5\0006\a\0\0'\t\3\0B\a\2\0029\a\4\a=\a\6\6=\6\b\5=\5\n\0045\5\v\0=\5\f\4=\4\14\3B\1\2\0019\1\15\0'\3\16\0B\1\2\1K\0\1\0\fproject\19load_extension\rdefaults\1\0\0\fpreview\1\0\1\20hide_on_startup\2\rmappings\1\0\0\6i\1\0\0\n<Tab>\1\0\0\19toggle_preview\29telescope.actions.layout\nsetup\14telescope\frequire\0", "config", "telescope.nvim")
time([[Config for telescope.nvim]], false)
-- Config for: nvim-lspconfig
time([[Config for nvim-lspconfig]], true)
try_loadstring("\27LJ\2\nd\0\0\6\0\6\0\v6\0\0\0006\2\1\0009\2\2\0026\4\1\0009\4\3\0049\4\4\0049\4\5\4B\4\1\0A\2\0\0A\0\0\1K\0\1\0\27list_workspace_folders\bbuf\blsp\finspect\bvim\nprint³\b\1\2\t\0,\0¢\0016\2\0\0009\2\1\0029\2\2\0025\4\3\0B\2\2\0016\2\0\0009\2\4\0029\2\5\2\18\4\1\0'\5\6\0'\6\a\0B\2\4\0015\2\b\0=\1\t\0026\3\0\0009\3\n\0039\3\v\3'\5\f\0'\6\r\0006\a\0\0009\a\14\a9\a\15\a9\a\16\a\18\b\2\0B\3\5\0016\3\0\0009\3\n\0039\3\v\3'\5\f\0'\6\17\0006\a\0\0009\a\14\a9\a\15\a9\a\18\a\18\b\2\0B\3\5\0016\3\0\0009\3\n\0039\3\v\3'\5\f\0'\6\19\0006\a\0\0009\a\14\a9\a\15\a9\a\20\a\18\b\2\0B\3\5\0016\3\0\0009\3\n\0039\3\v\3'\5\f\0'\6\21\0006\a\0\0009\a\14\a9\a\15\a9\a\22\a\18\b\2\0B\3\5\0016\3\0\0009\3\n\0039\3\v\3'\5\f\0'\6\23\0006\a\0\0009\a\14\a9\a\15\a9\a\24\a\18\b\2\0B\3\5\0016\3\0\0009\3\n\0039\3\v\3'\5\f\0'\6\25\0006\a\0\0009\a\14\a9\a\15\a9\a\26\a\18\b\2\0B\3\5\0016\3\0\0009\3\n\0039\3\v\3'\5\f\0'\6\27\0006\a\0\0009\a\14\a9\a\15\a9\a\28\a\18\b\2\0B\3\5\0016\3\0\0009\3\n\0039\3\v\3'\5\f\0'\6\29\0006\a\0\0009\a\14\a9\a\15\a9\a\30\a\18\b\2\0B\3\5\0016\3\0\0009\3\n\0039\3\v\3'\5\f\0'\6\31\0003\a \0\18\b\2\0B\3\5\0016\3\0\0009\3\n\0039\3\v\3'\5\f\0'\6!\0006\a\0\0009\a\14\a9\a\15\a9\a\"\a\18\b\2\0B\3\5\0016\3\0\0009\3\n\0039\3\v\3'\5\f\0'\6#\0006\a\0\0009\a\14\a9\a\15\a9\a$\a\18\b\2\0B\3\5\0016\3\0\0009\3\n\0039\3\v\3'\5\f\0'\6%\0006\a\0\0009\a\14\a9\a\15\a9\a&\a\18\b\2\0B\3\5\0016\3\0\0009\3\n\0039\3\v\3'\5\f\0'\6'\0006\a\0\0009\a\14\a9\a\15\a9\a(\a\18\b\2\0B\3\5\0016\3)\0'\5*\0B\3\2\0029\3+\3\18\5\0\0\18\6\1\0B\3\3\1K\0\1\0\vattach\15nvim-navic\frequire\15formatting\r<space>f\16code_action\14<space>ca\vrename\14<space>rn\20type_definition\r<space>D\0\14<space>wl\28remove_workspace_folder\14<space>wr\25add_workspace_folder\14<space>wa\19signature_help\n<C-k>\nhover\6K\15references\agr\19implementation\agi\15definition\agd\16declaration\bbuf\blsp\agD\6n\bset\vkeymap\vbuffer\1\0\2\fnoremap\2\vsilent\2\27v:lua.vim.lsp.omnifunc\romnifunc\24nvim_buf_set_option\bapi\1\0\1\17virtual_text\1\vconfig\15diagnostic\bvim¸\1\1\0\6\0\f\0\0223\0\0\0006\1\1\0'\3\2\0B\1\2\0029\1\3\0019\1\4\0015\3\5\0=\0\6\3B\1\2\0016\1\1\0'\3\2\0B\1\2\0029\1\a\0019\1\4\0015\3\b\0=\0\6\0035\4\t\0004\5\0\0=\5\n\4=\4\v\3B\1\2\1K\0\1\0\rsettings\18rust-analyzer\1\0\0\1\0\0\18rust_analyzer\14on_attach\1\0\0\nsetup\fpyright\14lspconfig\frequire\0\0", "config", "nvim-lspconfig")
time([[Config for nvim-lspconfig]], false)

_G._packer.inside_compile = false
if _G._packer.needs_bufread == true then
  vim.cmd("doautocmd BufRead")
end
_G._packer.needs_bufread = false

if should_profile then save_profiles() end

end)

if not no_errors then
  error_msg = error_msg:gsub('"', '\\"')
  vim.api.nvim_command('echohl ErrorMsg | echom "Error in packer_compiled: '..error_msg..'" | echom "Please check your config for correctness" | echohl None')
end
