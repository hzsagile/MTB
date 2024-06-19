object frmMIB: TfrmMIB
  Left = 173
  Top = 130
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = #25935#25463'GBL'#24494#20301#31227#25968#26174#34920#36890#35759#36719#20214
  ClientHeight = 498
  ClientWidth = 792
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clBlack
  Font.Height = -37
  Font.Name = #23435#20307
  Font.Style = [fsBold]
  Menu = mnuMIB
  OldCreateOrder = False
  Position = poDesktopCenter
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 37
  object Label1: TLabel
    Left = 592
    Top = 439
    Width = 81
    Height = 25
    AutoSize = False
    Caption = #35774#32622#20018#21475
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Bevel4: TBevel
    Left = 8
    Top = 364
    Width = 89
    Height = 48
    Shape = bsFrame
    Style = bsRaised
  end
  object Label5: TLabel
    Left = 15
    Top = 370
    Width = 74
    Height = 37
    AutoSize = False
    Caption = #20844#21046
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -35
    Font.Name = #23435#20307
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lblShow: TLabel
    Left = 16
    Top = 42
    Width = 489
    Height = 33
    AutoSize = False
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -14
    Font.Name = #23435#20307
    Font.Style = []
    ParentFont = False
  end
  object Label2: TLabel
    Left = 592
    Top = 47
    Width = 75
    Height = 14
    Caption = #35774#32622#26631#31216#20540
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -14
    Font.Name = #23435#20307
    Font.Style = [fsBold]
    ParentFont = False
    Visible = False
  end
  object Label3: TLabel
    Left = 665
    Top = 12
    Width = 45
    Height = 14
    Caption = #19979#20559#24046
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -14
    Font.Name = #23435#20307
    Font.Style = [fsBold]
    ParentFont = False
    Visible = False
  end
  object Label4: TLabel
    Left = 544
    Top = 13
    Width = 45
    Height = 14
    Caption = #19978#20559#24046
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -14
    Font.Name = #23435#20307
    Font.Style = [fsBold]
    ParentFont = False
    Visible = False
  end
  object Bevel1: TBevel
    Left = 509
    Top = 55
    Width = 73
    Height = 25
    Shape = bsFrame
    Style = bsRaised
  end
  object Label6: TLabel
    Left = 516
    Top = 61
    Width = 60
    Height = 14
    AutoSize = False
    Caption = #25163#21160#27169#24335
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -14
    Font.Name = #23435#20307
    Font.Style = [fsBold]
    ParentFont = False
  end
  object panDisplay: TPanel
    Left = 8
    Top = 74
    Width = 489
    Height = 265
    BevelOuter = bvLowered
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -157
    Font.Name = #23435#20307
    Font.Style = []
    ParentFont = False
    TabOrder = 5
  end
  object btnENT: TButton
    Left = 392
    Top = 425
    Width = 121
    Height = 51
    Hint = #32622#25968
    Caption = 'ENT'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -24
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 0
    OnClick = btnENTClick
  end
  object edtNUM: TEdit
    Left = 284
    Top = 362
    Width = 229
    Height = 45
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -37
    Font.Name = #23435#20307
    Font.Style = [fsBold]
    ImeName = #20013#25991' ('#31616#20307') - '#24494#36719#25340#38899
    MaxLength = 8
    ParentFont = False
    TabOrder = 1
    OnChange = edtNUMChange
    OnExit = edtNUMExit
    OnKeyPress = edtNUMKeyPress
  end
  object btnCALL: TButton
    Left = 136
    Top = 425
    Width = 121
    Height = 51
    Hint = #35760#24518
    Caption = 'CALL'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -24
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 2
    OnClick = btnCALLClick
  end
  object btnCLR: TButton
    Left = 264
    Top = 425
    Width = 121
    Height = 51
    Hint = #28165#38500
    Caption = 'CLR'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -24
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 3
    OnClick = btnCLRClick
  end
  object btnMMIN: TButton
    Left = 8
    Top = 425
    Width = 121
    Height = 51
    Hint = #20844#33521#21046#36716#25442
    Caption = 'MM/IN'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -24
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 4
    OnClick = btnMMINClick
  end
  object cmbCOM: TComboBox
    Left = 691
    Top = 428
    Width = 97
    Height = 37
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -24
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ImeName = #20013#25991' ('#31616#20307') - '#24494#36719#25340#38899
    ItemHeight = 29
    ItemIndex = 0
    ParentFont = False
    Sorted = True
    TabOrder = 6
    Text = 'COM1'
    OnChange = cmbCOMChange
    Items.Strings = (
      'COM1'
      'COM2')
  end
  object btnAddData: TButton
    Left = 505
    Top = 157
    Width = 80
    Height = 30
    Hint = #21462#25968
    Caption = #25163#21160#21462#25968
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -16
    Font.Name = #23435#20307
    Font.Style = [fsBold]
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 7
    OnClick = btnAddDataClick
  end
  object btnSaveLst: TButton
    Left = 592
    Top = 352
    Width = 89
    Height = 51
    Caption = #20445#23384
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -35
    Font.Name = #23435#20307
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 8
    Visible = False
    OnClick = btnSaveLstClick
  end
  object btnMauMode: TButton
    Left = 505
    Top = 90
    Width = 80
    Height = 30
    Hint = #33258#21160
    Caption = #33258#21160
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -16
    Font.Name = #23435#20307
    Font.Style = [fsBold]
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 9
    OnClick = btnMauModeClick
  end
  object btnSign: TButton
    Left = 224
    Top = 362
    Width = 52
    Height = 50
    Hint = #32622#27491#36127
    Caption = '+'
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -37
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 10
    OnClick = btnSignClick
  end
  object btnGetDisplay: TButton
    Left = 104
    Top = 362
    Width = 113
    Height = 50
    Hint = #21462#25968
    Caption = #21462#25968
    Font.Charset = GB2312_CHARSET
    Font.Color = clBlack
    Font.Height = -37
    Font.Name = #23435#20307
    Font.Style = [fsBold]
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 11
    OnClick = btnGetDisplayClick
  end
  object btnCLRLst: TButton
    Left = 505
    Top = 296
    Width = 80
    Height = 30
    Caption = #28165#38500#25968#25454
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -16
    Font.Name = #23435#20307
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 12
    Visible = False
    OnClick = btnCLRLstClick
  end
  object btnCCtl: TButton
    Left = 505
    Top = 157
    Width = 80
    Height = 30
    Hint = #33258#21160#21462#25968
    Caption = #33258#21160#21462#25968
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -16
    Font.Name = #23435#20307
    Font.Style = [fsBold]
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 13
    Visible = False
    OnClick = btnCCtlClick
  end
  object btnAutoMode: TButton
    Left = 505
    Top = 90
    Width = 80
    Height = 30
    Hint = #25163#21160
    Caption = #25163#21160
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -16
    Font.Name = #23435#20307
    Font.Style = [fsBold]
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 14
    Visible = False
    OnClick = btnAutoModeClick
  end
  object lstData: TListBox
    Left = 592
    Top = 74
    Width = 193
    Height = 265
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -37
    Font.Name = #23435#20307
    Font.Style = [fsBold]
    ImeName = #20013#25991' ('#31616#20307') - '#24494#36719#25340#38899
    ItemHeight = 37
    ParentFont = False
    TabOrder = 15
    OnDblClick = lstDataDblClick
    OnDragDrop = lstDataDragDrop
    OnDragOver = lstDataDragOver
  end
  object btnRemove: TButton
    Left = 505
    Top = 227
    Width = 80
    Height = 30
    Hint = #31227#38500#25968#25454
    Caption = #31227#38500#25968#25454
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -16
    Font.Name = #23435#20307
    Font.Style = [fsBold]
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 16
    Visible = False
    OnClick = btnRemoveClick
  end
  object cmbSample: TComboBox
    Left = 672
    Top = 42
    Width = 113
    Height = 22
    Style = csDropDownList
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -14
    Font.Name = #23435#20307
    Font.Style = [fsBold]
    ItemHeight = 14
    ParentFont = False
    TabOrder = 17
    Visible = False
    OnChange = cmbSampleChange
    Items.Strings = (
      'NONE')
  end
  object btnLoadLst: TButton
    Left = 696
    Top = 354
    Width = 89
    Height = 49
    Caption = #36733#20837
    TabOrder = 18
    OnClick = btnLoadLstClick
  end
  object cmbUp: TComboBox
    Left = 592
    Top = 8
    Width = 73
    Height = 22
    Style = csDropDownList
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -14
    Font.Name = #23435#20307
    Font.Style = [fsBold]
    ItemHeight = 14
    ItemIndex = 0
    ParentFont = False
    TabOrder = 19
    Text = '0'
    Visible = False
    Items.Strings = (
      '0')
  end
  object cmbDown: TComboBox
    Left = 712
    Top = 8
    Width = 73
    Height = 22
    Style = csDropDownList
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -14
    Font.Name = #23435#20307
    Font.Style = [fsBold]
    ItemHeight = 14
    ItemIndex = 0
    ParentFont = False
    TabOrder = 20
    Text = '0'
    Visible = False
    Items.Strings = (
      '0')
  end
  object mnuMIB: TMainMenu
    Left = 16
    Top = 88
    object N3: TMenuItem
      Caption = #31995#32479'(&S)'
      object nSysSet: TMenuItem
        Caption = #35774#32622'...(&S)'
        OnClick = nSysSetClick
      end
      object nSample: TMenuItem
        Caption = #26631#31216#20540'...(&M)'
        OnClick = nSampleClick
      end
      object nExit: TMenuItem
        Caption = #36864#20986'    (&X)'
        OnClick = nExitClick
      end
    end
    object N1: TMenuItem
      Caption = #24110#21161'(&A)'
      object nUsehelp: TMenuItem
        Caption = #20351#29992#35828#26126'(&U)'
        OnClick = nUsehelpClick
      end
      object bAbout: TMenuItem
        Caption = #20851#20110#26412#36719#20214'(&A)'
        OnClick = bAboutClick
      end
    end
  end
  object dlgSaveLST: TSaveDialog
    DefaultExt = 'txt'
    Filter = #26368#32456#32467#26524#25991#20214'|*.txt'
    InitialDir = '.\RESULT'
    Left = 608
    Top = 304
  end
  object tmrGetData: TTimer
    Enabled = False
    OnTimer = tmrGetDataTimer
    Left = 208
    Top = 90
  end
  object dlgOpenLST: TOpenDialog
    DefaultExt = 'ls'
    Filter = #27979#37327#25968#25454#25991#20214'|*.ls'
    InitialDir = '.\RESULT'
    Left = 728
    Top = 306
  end
end
