~esc::
;<ESC>映射为切换输入法为英文

Send, {ESC}

; 下方代码可只保留一个
SwitchIME(0x04090409) ; 英语(美国) 美式键盘
;SwitchIME(0x08040804) ; 中文(中国) 简体中文-美式键盘
return

SwitchIME(dwLayout){
    HKL:=DllCall("LoadKeyboardLayout", Str, dwLayout, UInt, 1)
    ControlGetFocus,ctl,A
    SendMessage,0x50,0,HKL,%ctl%,A
}

