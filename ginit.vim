" Settings: https://neovide.dev/configuration.html
if exists('g:neovide')
    set guifont=Iosevka:h14

    let g:neovide_fullscreen = v:false
    let g:neovide_remember_window_size = v:true
    let g:neovide_floating_shadow=v:false

    let g:neovide_cursor_animation_length=0.05
    let g:neovide_cursor_trail_size = 0.1

    let g:neovide_transparency = 1

    " nnoremap <silent> <C--> :set guifont=+<CR>
    " nnoremap <silent> <C-=> :set guifont=-<CR>
    nnoremap <silent> <A-Cr> :let g:neovide_fullscreen = !g:neovide_fullscreen<cr>

    " Make Neovide tile on Windows with komorebi
    " see: https://github.com/LGUG2Z/komorebi/issues/543
    set title titlestring=neovide
end

if exists('g:fvim_loaded')
    " good old 'set guifont' compatibility with HiDPI hints...
    if g:fvim_os == 'windows' || g:fvim_render_scale > 1.0
        set guifont=Iosevka:h13
    else
        set guifont=Iosevka:h26
    endif
    " Font tweaks
    " FVimFontAntialias v:false
    " FVimFontLigature v:false
    " FVimFontSubpixel v:true

    " FVimFontAutohint v:true
    " FVimFontHintLevel 'full'
    " can be 'default', '14.0', '-1.0' etc.
    " FVimFontLineHeight '-1.0'
    " Disable built-in Nerd font symbols
    FVimFontNoBuiltinSymbols v:false

    " Try to snap the fonts to the pixels, reduces blur
    " in some situations (e.g. 100% DPI).
    " FVimFontAutoSnap v:true

    set laststatus=3
    set nolist
      
    " Ctrl-ScrollWheel for zooming in/out
    nnoremap <silent> <C-ScrollWheelUp> :set guifont=+<CR>
    nnoremap <silent> <C-ScrollWheelDown> :set guifont=-<CR>
    nnoremap <A-Cr> :FVimToggleFullScreen<CR>
endif

if exists('g:nvy')
    set guifont=Iosevka:h10
endif
