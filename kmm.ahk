; Requires AutoHotkey v2.0+
; App to do auto mouse movement and auto mouse click to avoid computer's lock


; Global variable
BreakLoop := False

; GUI Configuration
MyGui := Gui("+AlwaysOnTop +Resize +MinSize180 -MinimizeBox -MaximizeBox", "Keep Mouse Moving")
MyGui.OnEvent("Close", MyGuiClose)

StartButton := MyGui.Add("Button", "Default X15 W150", "Start")
StartButton.OnEvent("Click", StartButtonClick)

StopButton := MyGui.Add("Button", "Default X15 W150", "Stop")
StopButton.OnEvent("Click", StopButtonClick)

QuitButton := MyGui.Add("Button", "Default X15 W150", "Quit")
QuitButton.OnEvent("Click", QuitButtonClick)

MyGui.Add("GroupBox", "X15 W150 H85", "Configuration")

MyGui.Add("CheckBox", "X20 YP+20 vMouseClickCheckBox", "Enable mouse right click")
MyGui["MouseClickCheckBox"].Value := 1

MyGui.Add("CheckBox", "X20 YP+20 vMouseMovementCheckBox", "Enable mouse movement")
MyGui["MouseMovementCheckBox"].Value := 1

MyGui.Add("CheckBox", "X20 YP+20 vStopInCheckBox", "Stop in (min):")
MyGui["StopInCheckBox"].Value := 1

MyGui.Add("Edit", "X100 YP-3 H20 W45")
MyGui.Add("UpDown", "vStopUpDown Range1-600", 15)

MyGui.Show()


; Change checkboxes' state and start loop
StartButtonClick(*) {
    StartButton.Enabled := False
    StopButton.Enabled := True
    Global BreakLoop := False

    If (MyGui["StopInCheckBox"].value = 1) {
        ;MsgBox " = "  MyGui["StopUpDown"].value * 1000
        SetTimer StopButtonClick, (MyGui["StopUpDown"].value * 60000)
    }

    Loop {
        LoopAction(5, 0)
        LoopAction(-5, 0)

	if (BreakLoop = True) {
            Break
        }
    }
}

; Loop
LoopAction(X, Y) {
    If (MyGui["MouseClickCheckBox"].value = 1) {
        MouseClick "Right"
    }

    If (MyGui["MouseMovementCheckBox"].value = 1) {
        MouseMove X, Y, 0, "R"
    }

    Sleep 500
}

; Change checkboxes' state and stop loop
StopButtonClick(*) {
    StartButton.Enabled := True
    StopButton.Enabled := False
    Global BreakLoop := True

    SetTimer StopButtonClick, 0
}

; Quit app using Quit button
QuitButtonClick(*) {
    ExitApp
}

; Quit app closing its window
MyGuiClose(*) {
    ExitApp
}
