"==============================================================================
" Name:        highlight log patterns
" Author:      Petter Wahlman, pwahlman@cisco.com
" Description: Simplify inspection of SIP packet data
" License:     void
"===============================================================================
"
" inside quotes:
" call matchadd('pri_3', '"\([^"]*\)"')
" call matchadd('pri_3', "\'\\([^\']*\\)\'")

nnoremap <leader>sh :call highlight#highlight()<CR>
let g:highlight_enabled = 0

function! highlight#enable()
    call clearmatches()
    let g:highlight_enabled = 0
    call highlight#toggle()
endfunction

function! highlight#disable()
    let g:highlight_enabled = 0
    call clearmatches()
endfunction

function! highlight#toggle()
    set nonumber
    "if (g:highlight_enabled != 0)
    "   return
    "endif
    if g:highlight_enabled == 1
        let g:highlight_enabled = 0
        call clearmatches()
        return
    endif
    let g:highlight_enabled = 1

    let l:fmet = &foldmethod
    setlocal foldmethod=expr foldexpr=(getline(v:lnum)[53:][:10]==getline(v:lnum+1)[53:][:10])?1:'<1'


    hi yellow ctermfg=3 guifg=#eacb8a
    hi green ctermfg=2 guifg=#a3be8b

    hi white_on_black ctermfg=7 ctermbg=236 guifg=#e5e9f0 guibg=#303030
    hi light_grey_on_dark_grey ctermfg=7 ctermbg=0 guifg=#e5e9f0 guibg=#3b4251

    hi scr ctermbg=none ctermfg=darkred guifg=#bf6069
    hi sca ctermbg=none ctermfg=20 guifg=#8888d7

    "hi duo ctermfg=2 ctermbg=235 guifg=#009900 guibg=#444444


    "***************************************************************************
    "*** PRIORITY COLORS:
    "***************************************************************************
    " white on dark gray:
    hi pri_6 ctermfg=white ctermbg=236 guifg=#e5e9f0 guibg=#303030

    " brown:
    hi pri_5 ctermfg=208 guifg=#ff8700

    " red on black:
    "hi pri_4 ctermbg=darkblue ctermfg=black guibg=darkcyan
    hi pri_4 ctermfg=darkred ctermbg=none guifg=#bf6069

    " red on white:
    hi pri_3 cterm=bold ctermfg=darkred ctermbg=white guifg=#bf6069 guibg=#e5e9f0

    " white on red:
    hi pri_1 ctermfg=15 ctermbg=1 guifg=#eceef4 guibg=#bf6069


    "***************************************************************************
    "*** AUDIO
    "***************************************************************************
    "hi aud ctermfg=61 ctermbg=none
    hi aud ctermfg=117 ctermbg=none guifg=#87d7ff guibg=none

    "*** CATAGORIES (should be partially overwritten by keywords ***
    call matchadd('aud',  'main_audio')
    call matchadd('aud',  'main_audio\S\+')
    call matchadd('aud',  '\S\+main_audio\S\+')
    call matchadd('aud',  '\S\+main_audio')

    call matchadd('aud',  'main_audio send: SCA', 10)
    call matchadd('aud',  'main_audio recv: SCA', 10)
    call matchadd('aud',  'main_audio send: SCA-ACK', 10)
    call matchadd('aud',  'main_audio recv: SCA-ACK', 10)
    call matchadd('aud',  'main_audio send: SCR', 10)
    call matchadd('aud',  'main_audio recv: SCR', 10)
    call matchadd('aud', '\w\+AudioChannelChanged', 10)

    "***************************************************************************
    "*** VIDEO
    "***************************************************************************
    "hi vid ctermfg=160 ctermbg=none
    hi vid ctermfg=2 ctermbg=none guifg=#a3be8b
    "*** CATAGORIES (should be partially overwritten by keywords ***
    call matchadd('pri_1',  'main_video .*: SC. ')
    "call matchadd('pri_1',  'main_video ?end: SC?')
    "call matchadd('vid',  'main_video\S\+')
    call matchadd('vid',  '\S\+main_video\S\+')
    call matchadd('vid',  '\S\+main_video')

    " SCA:
    "call matchadd('vid',  'main_video ?end: SCA', 10)
    "call matchadd('vid',  'main_video ?ecv: SCA', 10)
    "" SCA-ACK:
    "call matchadd('vid',  'main_video send: SCA-ACK', 10)
    "call matchadd('vid',  'main_video recv: SCA-ACK', 10)
    "" SCR:
    "call matchadd('vid',  'main_video send: SCR', 10)
    "call matchadd('vid',  'main_video recv: SCR', 10)

    call matchadd('vid', 'Executing SCA-triggered layout update', 10)
    call matchadd('vid', 'sendSimLayoutInfoForAllOutputs', 10)
    call matchadd('vid', 'ENC_FSM-. I: start standard')

    call matchadd('vid', 'incoming stream:')
    call matchadd('vid', 'callState=\S\+', 10)

    "***************************************************************************
    "*** DUO
    "***************************************************************************
    "hi duo ctermfg=252 ctermbg=24
    hi duo ctermfg=3 guifg=#eacb8a

    call matchadd('duo',  'content_video')
    call matchadd('duo',  'content_video\S\+')
    "*** CATAGORIES (should be partially overwritten by keywords ***
    "call matchadd('duo',  'Duo Recv', 10)
    "call matchadd('duo',  'Duo Send', 10)
    call matchadd('duo', 'XCCP receiveData')
    call matchadd('duo', 'a=content:\S\+')
    call matchadd('duo', 'locus.floor_granted')
    call matchadd('duo', 'PresentationStarted')
    call matchadd('duo', 'PresentationToken\w\+')


    "***************************************************************************
    "*** MULTISTREAM
    "***************************************************************************
    hi mst ctermfg=white ctermbg=17 guifg=#e5e9f0 guibg=#00005f

    call matchadd('mst', 'Multistream')
    call matchadd('mst', 'Multistream\S\+')
    call matchadd('mst', '\S\+Multistream\S\+')
    call matchadd('mst', '\S\+Multistream')

    call matchadd('mst', 'Offering multistream (late offer received)', 10)
    call matchadd('mst', 'Resetting multistream request state due to hold', 10)
    "call matchadd('mst', 'Not offering multistream', 10)
    call matchadd('mst', 'Not \S\+ multistream', 10)
    "call matchadd('mst', 'Not enabling multistream', 10)
    call matchadd('mst', 'Starting ..:multistream negotiation', 10)

    call matchadd('mst', 'Stopping multistream', 10)
    call matchadd('mst', 'sendProbeIfAble', 10)


    "***************************************************************************
    "*** MARI
    "***************************************************************************
    hi mari ctermfg=13 ctermbg=none guifg=#b48dac guibg=none

    call matchadd('mari', 'Mari')
    call matchadd('mari', 'Mari\S\+')
    call matchadd('mari', '\S\+Mari\S\+')
    call matchadd('mari', '\S\+Mari')

    call matchadd('mari', 'new maxTotalRate')
    call matchadd('mari', 'rtt = \w*', 10)
    "***************************************************************************
    "*** SIP
    "***************************************************************************
    hi sip ctermfg=black ctermbg=white  guifg=#3b4251 guibg=#e5e9f0
    hi sip_sdp ctermfg=white ctermbg=darkyellow guifg=#ffffff guibg=#cc5500

    call matchadd('sip_sdp', ' m=\S\+ \d\+')

    "call matchadd('mst', '\S\+URI=\Ssip:\S\+@\S\+')
    call matchadd('sip', 'SIP Msg')
    call matchadd('sip', 'SIP Msg: Outgoing \=\> INVITE')
    call matchadd('sip', 'SIP Msg: Outgoing \=\> 200 OK, CSeq: *.* INVITE')
    call matchadd('sip', 'SIP Msg: Incoming \<\= INVITE')
    call matchadd('sip', 'SIP Msg: Incoming \<\= 200 OK, CSeq: *.* INVITE')
     "***************************************************************************
    "*** KEYWORDS:
    "***************************************************************************
    call matchadd('green',  " recv:", 10)
    call matchadd('yellow', " send:", 10)
    call matchadd('yellow', " resend:", 10)

    call matchadd('sca',  " SCA ", 10)
    call matchadd('sca',  " SCA-ACK", 10)
    call matchadd('scr',  " SCR ", 10)


    "***************************************************************************
    "*** MISC
    "***************************************************************************
    "call matchadd('light_grey_on_dark_grey', " Multistream ")


    "***************************************************************************
    "*** PRI 6:
    "***************************************************************************

    "***************************************************************************
    "*** PRI 5:
    "***************************************************************************
    call matchadd('pri_5', 'fs=\d\+')
    call matchadd('pri_5', 'maxfs=\S\+')
    call matchadd('pri_5', 'frameSize=\S\+')
    "call matchadd('pri_5', 'subsessions=\S\+')
    call matchadd('pri_5', 'requests=\S\+')
    call matchadd('pri_5', 'requests=[1-9]+')
    " seqno:
    call matchadd('pri_5', 'refseq=\S\+')
    call matchadd('pri_5', 'subsessions=\S\+')
    call matchadd('pri_5', 'seqno=\S\+')
    call matchadd('pri_5', 'scrSeqNo=\S\+')
    call matchadd('pri_5', 'available=\S\+')
    call matchadd('pri_5', 'available=\S\+')

    " ENC_FSM:
    call matchadd('vid', 'width \d\+, height...\d\+', 10)
    "call matchadd('pri_5', 'height..\d\+', 10)

    " DEC_FSM:
    call matchadd('vid', 'width=\S\+', 10)
    call matchadd('vid', 'height=\S\+', 10)

    call matchadd('pri_5', 'has been confirmed from farend')

    "***************************************************************************
    "*** PRI 4:
    "***************************************************************************
    "call matchadd('pri_3', "execute command")

    call matchadd('pri_3', "execute command \'\\([^\']*\\)\'")
    call matchadd('Normal', "execute command ")

    "***************************************************************************
    "*** PRI 3: (red on white)
    "***************************************************************************
    hi pri_3 cterm=bold ctermfg=darkred ctermbg=white guifg=#bf6069 guibg=#e5e9f0
    call matchadd('pri_3', 'Call is now multistream.*', 10)
    call matchadd('pri_3', 'Call is no longer multistream.*', 10)

    call matchadd('pri_3', 'a=rtpmap:*.*H264\-SVC*.*', 10)
    call matchadd('pri_3', ';policies=.*;', 10)
    call matchadd('pri_3', 'a=sprop-simul:', 10)
    call matchadd('pri_3', 'a=sprop-source:', 10)
    call matchadd('pri_3', 'recv; scr', 10)
    call matchadd('pri_3', 'send; scr', 10)
    call matchadd('pri_3', 'XCCPLayoutFamilySetterImpl', 10)

    call matchadd('pri_3', 'locus.self_changed', 10)
    call matchadd('pri_3', 'correlationId', 10)
    "call matchadd('pri_3', 'requests=.', 10)
    "call matchadd('pri_3', 'requests=[1-9]', 10)
    call matchadd('pri_3', 'CallConnected')


    call matchadd('pri_5', '\[sci *.*\]', 10)
    call matchadd('pri_5', 'CSI=0x[0-9a-fA-F]+', 10)

    call matchadd('pri_5', '[Cc][Ss][Ii]=\S\+', 10)
    "ssrc:
    "call matchadd('pri_5', '[Ss][Cc][Ii]=\S\+', 10)
    "ssrc
    "call matchadd('pri_5', '[Ss][Ss][Rr][Cc]=\S\+', 10)
    "stream
    "call matchadd('pri_5', '[Ss][Tt][Rr][Ee][Aa][Mm]=\S\+', 10)


    "call matchadd('pri_3', 'execute command ')
    " DEC_FSM:
    "call matchadd('pri_3', 'create H.264\S\+', 10)
    " ENC_FSM:
    " too verbose:
    "call matchadd('pri_3', 'start standard H.264', 10)


    "call matchadd('pri_3', 'Framesizes changed')
    call matchadd('duo', 'PresentationStarted')
    call matchadd('pri_3', 'OutgoingCallInvoked')
    call matchadd('pri_3', 'IncomingCallInvite')

    call matchadd('pri_3', '\S\+Disconnect\w\+')
    call matchadd('pri_3', 'CallResumeRequested')
    call matchadd('pri_3', 'outgoingHold')

    call matchadd('pri_3', 'sci:\S\+.rate:\S\+')

    " panorama:
    call matchadd('pri_3', 'transition .* panorama video')
    call matchadd('pri_1', 'not starting panoram\S\+')
    call matchadd('pri_3', 'starting panoram\S\+')
    call matchadd('pri_1', 'not activating panoram\S\+')
    call matchadd('pri_3', 'activating panoram\S\+')
    "***************************************************************************
    "*** PRI 1: WARNING (white on red)
    "***************************************************************************
    hi pri_1 ctermfg=15 ctermbg=1 guifg=#eceef4 guibg=#bf6069

    call matchadd('pri_3',  'Multistream is not allowed', 10)
    call matchadd('pri_3',  'no incoming data', 10)
    call matchadd('pri_3',  'no incoming video', 10)
    call matchadd('pri_1',  'code=0x31', 10)
    call matchadd('pri_1',  'code=0x32', 10)
    call matchadd('pri_1',  'code=0x33', 10)
    call matchadd('pri_1',  'code=0x34', 10)

    call matchadd('pri_1',  'acecloud.webex.com', 10)
    call matchadd('pri_1',  'noupgrade', 10)
    call matchadd('pri_1',  'SipBridge', 10)
    call matchadd('pri_1',  'bridged=true', 10)

    call matchadd('pri_1', 'rate_adjust_simulcasts', 10)

    " call matchadd('pri_1', 'mute with poster', 10)
    " generic error indicators
    hi ms_warn ctermbg=darkred ctermfg=white guifg=#bf6069 guibg=#e5e9f0
    call matchadd('pri_1', 'PWA')
    call matchadd('pri_1', 'XXX')

    call matchadd('pri_1', 'a=sendonly')
    call matchadd('pri_1', 'a=inactive')
    call matchadd('pri_1', 'm=video 0')
    call matchadd('pri_1', 'm=audio 0')
    call matchadd('pri_1', 'm=application 0')
    call matchadd('pri_1', 'c=IN IP4 0.0.0.0')
    call matchadd('pri_1', 'recv; pli')
    call matchadd('pri_1', 'send; pli')
    call matchadd('pri_1', 'intra request')
    call matchadd('pri_1', 'ERROR')
    call matchadd('pri_1', 'protocol=\S\+')
    call matchadd('pri_1', '0x53, 0x54, 0x52, 0x00, 0x', 10) " MSTR 1:SCR, 2:SCA
    call matchadd('pri_1', '4d,53,54,52,00,', 10) " MSTR 1:SCR, 2:SCA
    call matchadd('pri_1', 'M,S,T,R', 10) " MSTR 1:SCR, 2:SCA


    keeppattern silent! %s/4d,53,54,52,00,1/M,S,T,R,0,[1:SCR]-/g
    keeppattern silent! %s/4d,53,54,52,00,2/M,S,T,R,0,[2:SCA]-/g
    keeppattern silent! %s/4d,53,54,52,00,3/M,S,T,R,0,[3:SCAA]-/g
    let &modified = 0

    " Generic info indicators


    "***************************************************************************
    "*** NOTE:
    "***************************************************************************
   "autocmd FileType ms call matchadd('mst', 'a=rtpmap*.*H264', 1)

   let &foldmethod=l:fmet
endfu


call highlight#enable()
