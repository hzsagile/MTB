unit SysSet;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Mask, ComCtrls, StdCtrls, Buttons, Registry;

type
  TfrmSysSet = class(TForm)
    edtInterval: TEdit;
    edtTimes: TEdit;
    btnSave: TButton;
    btnTemp: TButton;
    btnCancel: TButton;
    cbInterval: TCheckBox;
    cbTimes: TCheckBox;
    procedure btnCancelClick(Sender: TObject);
    procedure cbIntervalClick(Sender: TObject);
    procedure cbTimesClick(Sender: TObject);
    procedure btnTempClick(Sender: TObject);
    procedure edtIntervalExit(Sender: TObject);
    procedure edtTimesExit(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    strRegEdtInterval, strRegEdtTimes,
    strRegCbInterval, strRegCbTimes : string;

    function ValidCheck(s: string): Boolean;

    procedure SaveToRegistry(strKeyName, strValue :string);
    procedure  RegInit;
  public
    { Public declarations }
    iInterval, iTimes : Integer;
    bInterval, bTimes : Boolean;

    function GetRegistryValue(strValue : string): string;
  end;

var
  frmSysSet: TfrmSysSet;

implementation

uses MIB;

{$R *.dfm}

procedure TfrmSysSet.btnCancelClick(Sender: TObject);
begin
  close;
end;

procedure TfrmSysSet.cbIntervalClick(Sender: TObject);
begin
  if cbInterval.Checked = TRUE then
  begin
    btnSave.Enabled := TRUE;
    //btnDefault.Enabled := TRUE;
    edtInterval.Visible := TRUE;
  end;
  if cbInterval.Checked = FALSE  then
    edtInterval.Visible := FALSE;
  if (cbInterval.Checked =FALSE) and
  (cbTimes.Checked = FALSE) then
  begin
    //btnSave.Enabled := FALSE;
    //btnTemp.Enabled := FALSE;
  end;
  sleep(0);
end;

procedure TfrmSysSet.cbTimesClick(Sender: TObject);
begin
  if cbTimes.Checked = TRUE then
  begin
    btnSave.Enabled := TRUE;
    //btnDefault.Enabled := TRUE;
    edtTimes.Visible := TRUE;
  end;
  if cbTimes.Checked = FALSE then
    edtTimes.Visible := FALSE;
  if (cbInterval.Checked =FALSE) and
  (cbTimes.Checked = FALSE) then
  begin
    //btnSave.Enabled := FALSE;
    //btnTemp.Enabled := FALSE;
  end;
  sleep(0);
end;

function TfrmSysSet.ValidCheck(s: string):Boolean;
var
  iCheck :Integer;
begin
  for iCheck:=1 to length(s) do
  begin
    case s[iCheck] of
      '0'..'9': Result := TRUE;
    else
      begin
        //ValidCheck := FALSE;
        MessageBox(0,
               'º¬ÓÐ·Ç·¨×Ö·û',
               '',
               MB_OK or MB_ICONSTOP );
          Result := FALSE;
          break;
      end;
    end; // end case
  end; // end for
end;

procedure TfrmSysSet.btnTempClick(Sender: TObject);
begin
  if (edtInterval.Text = '') and
    (edtTimes.Text = '')  then
  begin
    bInterval := FALSE;
    bTimes := FALSE;
    exit;
  end
  else
  begin
    if (cbInterval.Checked = TRUE)
      and (edtInterval.Text <>'')then
    begin
      strRegEdtInterval := edtInterval.Text;
      iInterval := StrtoInt(strRegEdtInterval);
      bInterval := TRUE;
    end
    else
      bInterval := FALSE;
    if (cbTimes.Checked = TRUE)
      and (edtTimes.Text <> '') then
    begin
      strRegEdtTimes := edtTimes.Text;
      iTimes := StrtoInt(strRegEdtTimes);
      bTimes := TRUE;
    end
    else
      bTimes := FALSE;
  end;
  frmSysSet.Close;
end;

procedure TfrmSysSet.edtIntervalExit(Sender: TObject);
begin
  if (ValidCheck(edtInterval.Text) = FALSE)
    and (edtInterval.Text <> '') then
    edtInterval.SetFocus
end;

procedure TfrmSysSet.edtTimesExit(Sender: TObject);
begin
  if (ValidCheck(edtTimes.Text) = FALSE)
    and (edtTimes.Text <> '') then
    edtTimes.SetFocus;
end;

procedure TfrmSysSet.SaveToRegistry(strKeyName, strValue :string);
var
  Reg: TRegIniFile;
begin
    Reg:=TRegIniFile.Create('CamAgileApp');
    try
      Reg.RootKey:=HKey_Local_Machine;
      reg.OpenKey('SoftWare',false);
      if not Reg.OpenKey('CamAgile',False) then
      begin
          Reg.CreateKey('CamAgile');
          if not Reg.OpenKey('CamAgile',False) then
            ShowMessage('Error in Opening Created Key')
          else
            Reg.WriteString('MBT',strKeyName,strValue);
      end
      else
        Reg.WriteString('MBT',strKeyName,strValue);
      finally

      Reg.Free;
    end;
end;

function TfrmSysSet.GetRegistryValue(strValue : string): string;
var
  Registry: TRegistry;
begin
  Registry := TRegistry.Create(KEY_READ);
  try
    Registry.RootKey := HKEY_LOCAL_MACHINE;
    // False because we do not want to create it if it doesn't exist
    Registry.OpenKey('SoftWare\CamAgile\MBT', False);
    Result := Registry.ReadString(strValue);
  finally
    Registry.Free;
  end;
end;

procedure TfrmSysSet.btnSaveClick(Sender: TObject);
begin
  if (edtInterval.Text = '') and
    (edtTimes.Text = '')  then
  begin
    bInterval := FALSE;
    bTimes := FALSE;
    exit;
  end
  else
  begin
    if (cbInterval.Checked = TRUE)
      and (edtInterval.Text <>'')then
    begin
      strRegEdtInterval := edtInterval.Text;
      SaveToRegistry('Interval', edtInterval.Text);
      SaveToRegistry('cfInterval', '1');
      iInterval := StrtoInt(strRegEdtInterval);
      bInterval := TRUE;
    end
    else
    begin
      SaveToRegistry('cfInterval', '0');
      bInterval := FALSE;
    end;
    if (cbTimes.Checked = TRUE)
      and (edtTimes.Text <> '') then
    begin
      strRegEdtTimes := edtTimes.Text;
      SaveToRegistry('Times', edtTimes.Text);
      SaveToRegistry('cfTimes', '1');
      iTimes := StrtoInt(strRegEdtTimes);
      bTimes := TRUE;
    end
    else
    begin
      SaveToRegistry('cfTimes', '0');
      bTimes := FALSE;
    end;
  end;
  frmSysSet.Close;
end;

procedure TfrmSysSet.FormShow(Sender: TObject);
begin
  frmMIB.iCTimer := 0;
  RegInit;
end;

procedure TfrmSysSet.RegInit;
begin
  strRegCbInterval := GetRegistryValue('cfInterval');
  strRegCbTimes := GetRegistryValue('cfTimes');
  strRegEdtInterval := GetRegistryValue('Interval');
  strRegEdtTimes := GetRegistryValue('Times');
  if strRegCbInterval = '1' then
  begin
    cbInterval.Checked := TRUE;
    cbIntervalClick(cbInterval);
    edtInterval.Text := strRegEdtInterval;
    bInterval := TRUE;
  end
  else
  begin
    cbInterval.Checked := FALSE;
    bInterval := FALSE;
  end;
  if strRegCbTimes = '1' then
  begin
    cbTimes.Checked := TRUE;
    cbTimesClick(cbTimes);
    edtTimes.Text := strRegEdtTimes;
    bTimes := TRUE;
  end
  else
  begin
    cbTimes.Checked := FALSE;
    bTimes := FALSE;
  end;
end;

end.



