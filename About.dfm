object frmAbout: TfrmAbout
  Left = 408
  Top = 277
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = #20851#20110#25935#25463'GBL'#24494#20301#31227#25968#26174#34920#36890#35759#36719#20214
  ClientHeight = 145
  ClientWidth = 285
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 32
    Top = 8
    Width = 228
    Height = 17
    Alignment = taCenter
    AutoSize = False
    Caption = #25935#25463'GBL'#24494#20301#31227#25968#26174#34920#36890#35759#36719#20214'1.21'#29256
  end
  object Label3: TLabel
    Left = 32
    Top = 26
    Width = 233
    Height = 17
    Alignment = taCenter
    AutoSize = False
    Caption = #29256#26435#25152#26377': '#25104#37117#25935#25463#21046#36896#25216#26415#26377#38480#20844#21496
  end
  object Label2: TLabel
    Left = 89
    Top = 45
    Width = 109
    Height = 13
    Alignment = taCenter
    Caption = 'CopyRight (2003-2004)'
  end
  object Label4: TLabel
    Left = 103
    Top = 64
    Width = 81
    Height = 13
    Alignment = taCenter
    AutoSize = False
    Caption = #20316#32773#65306#40644#25919#26641
  end
  object Label5: TLabel
    Left = 71
    Top = 96
    Width = 145
    Height = 17
    Alignment = taCenter
    AutoSize = False
    Caption = 'http://www.camagile.com'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    OnClick = Label5Click
    OnMouseEnter = Label5MouseEnter
    OnMouseLeave = Label5MouseLeave
  end
  object Label6: TLabel
    Left = 80
    Top = 80
    Width = 145
    Height = 13
    AutoSize = False
    Caption = #24110#21161#25991#20214#21046#20316#65306#38472#24314#25991
  end
  object btnOK: TButton
    Left = 120
    Top = 120
    Width = 44
    Height = 21
    Caption = #30830#23450
    TabOrder = 0
    OnClick = btnOKClick
  end
end
