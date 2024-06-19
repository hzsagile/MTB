object frmSysSet: TfrmSysSet
  Left = 409
  Top = 174
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = #31995#32479#35774#32622
  ClientHeight = 137
  ClientWidth = 285
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Position = poDesktopCenter
  OnShow = FormShow
  TextHeight = 13
  object edtInterval: TEdit
    Left = 8
    Top = 19
    Width = 57
    Height = 21
    ImeName = #20013#25991' ('#31616#20307') - '#24494#36719#25340#38899
    MaxLength = 5
    TabOrder = 0
    Visible = False
    OnExit = edtIntervalExit
  end
  object edtTimes: TEdit
    Left = 8
    Top = 50
    Width = 57
    Height = 21
    ImeName = #20013#25991' ('#31616#20307') - '#24494#36719#25340#38899
    MaxLength = 5
    TabOrder = 1
    Visible = False
    OnExit = edtTimesExit
  end
  object btnSave: TButton
    Left = 17
    Top = 81
    Width = 75
    Height = 25
    Caption = #20445#23384#35774#32622
    Enabled = False
    TabOrder = 2
    OnClick = btnSaveClick
  end
  object btnTemp: TButton
    Left = 97
    Top = 81
    Width = 75
    Height = 25
    Caption = #20020#26102#20540
    TabOrder = 3
    OnClick = btnTempClick
  end
  object btnCancel: TButton
    Left = 177
    Top = 81
    Width = 80
    Height = 25
    Caption = #21462#28040
    TabOrder = 4
    OnClick = btnCancelClick
  end
  object cbInterval: TCheckBox
    Left = 72
    Top = 21
    Width = 193
    Height = 17
    Caption = #35774#32622#33258#21160#37319#38598#26102#38388#38388#38548#65288#27627#31186#65289
    TabOrder = 5
    OnClick = cbIntervalClick
  end
  object cbTimes: TCheckBox
    Left = 72
    Top = 52
    Width = 137
    Height = 17
    Caption = #35774#32622#33258#21160#37319#38598#27425#25968
    TabOrder = 6
    OnClick = cbTimesClick
  end
end
