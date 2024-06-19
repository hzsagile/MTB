unit Sample;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask, StrUtils;

type
  TfrmSample = class(TForm)
    lstSample: TListBox;
    btnAdd: TButton;
    btnRemove: TButton;
    btnClear: TButton;
    btnSave: TButton;
    btnLoad: TButton;
    edtSample: TEdit;
    dlgSampleOpen: TOpenDialog;
    dlgSampleSave: TSaveDialog;
    lstUp: TListBox;
    lstDown: TListBox;
    edtUp: TEdit;
    edtDown: TEdit;
    btnDownAdd: TButton;
    btnDownLoad: TButton;
    btnDownSave: TButton;
    btnDownClear: TButton;
    btnDownRemove: TButton;
    Label1: TLabel;
    btnUpAdd: TButton;
    btnUpLoad: TButton;
    btnUpSave: TButton;
    btnUpClear: TButton;
    btnUpRemove: TButton;
    Label2: TLabel;
    dlgUpSave: TSaveDialog;
    dlgUpOpen: TOpenDialog;
    dlgDownOpen: TOpenDialog;
    dlgDownSave: TSaveDialog;
    Label3: TLabel;
    procedure btnAddClick(Sender: TObject);
    procedure btnRemoveClick(Sender: TObject);
    procedure lstSampleDblClick(Sender: TObject);
    procedure btnClearClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure btnLoadClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnUpAddClick(Sender: TObject);
    procedure btnUpLoadClick(Sender: TObject);
    procedure btnUpSaveClick(Sender: TObject);
    procedure btnUpClearClick(Sender: TObject);
    procedure btnUpRemoveClick(Sender: TObject);
    procedure lstUpDblClick(Sender: TObject);
    procedure btnDownAddClick(Sender: TObject);
    procedure btnDownLoadClick(Sender: TObject);
    procedure btnDownSaveClick(Sender: TObject);
    procedure btnDownClearClick(Sender: TObject);
    procedure btnDownRemoveClick(Sender: TObject);
    procedure lstDownDblClick(Sender: TObject);
  private
    { Private declarations }
    procedure DoAddItems;
    procedure DoRemoveItems;
    procedure ChkListBox;
    function ValidCheck(s: string):Boolean;

    procedure DoUpAddItems;
    procedure DoUpRemoveItems;
    procedure ChkListBoxUp;
    function ValidCheckUp(s: string):Boolean;

    procedure ChkListBoxDown;
    procedure DoDownAddItems;
    procedure DoDownRemoveItems;
    function ValidCheckDown(s: string):Boolean;

  public
    { Public declarations }

  end;


var
  frmSample: TfrmSample;

implementation

uses MIB;

{$R *.dfm}

procedure TfrmSample.btnAddClick(Sender: TObject);
begin
  if (ValidCheck(edtSample.Text) = TRUE) and
     (edtSample.Text <> '')  then
    begin
      DoAddItems;
      ChkListBox;
    end;
end;

function TfrmSample.ValidCheck(s: string):Boolean;
var
  iCheck,nDot,nNav :Integer;
  fRange,fRangeCK : Double;
begin
  nDot:=0;
  nNav:=0;
  for iCheck:=1 to length(s) do
  begin
    case s[iCheck] of
      '-':
      begin
        nNav:=nNav+1;
        if LeftStr(s,1)='-' then
        begin
          if nNav>1 then
          begin
            ValidCheck := FALSE;
            MessageBox(0,
               '负号个数太多',
               '输入错误',
               MB_OK or MB_ICONSTOP);
            edtSample.SetFocus;
            edtSample.SelectAll;
            nNav:=0;
            exit;
          end;
          ValidCheck := TRUE;
       end
       else
       begin
          ValidCheck := FALSE;
          MessageBox(0,
             '负号位置不对',
             '输入错误',
             MB_OK or MB_ICONSTOP);
          edtSample.SetFocus;
          edtSample.SelectAll;
          exit;
       end;
      end;
      '0'..'9': ValidCheck := TRUE;
      '.' :
      begin
        nDot:=nDot+1;
        if nDot>1 then
        begin
          ValidCheck := FALSE;
          MessageBox(0,
               '小数点个数太多',
               '输入错误',
               MB_OK or MB_ICONSTOP);
          edtSample.SetFocus;
          edtSample.SelectAll;
          nDot:=0;
          exit;
        end
        else
          ValidCheck := TRUE;
      end;
    else
      begin
        ValidCheck := FALSE;
        MessageBox(0,
               '含有非法字符',
               '输入错误',
               MB_OK or MB_ICONSTOP);
        edtSample.SetFocus;
        edtSample.SelectAll;
        exit;
      end;
    end; // end case
  end;  // end for
  if s<>'' then
  begin
    fRange:=StrToFloat(s);
    fRange:=Round(fRange*1000)/1000;
    if (fRange>=-9999.999) and (fRange<=9999.999) then
    begin
      edtSample.Text := FloatToStr(fRange);
      ValidCheck := TRUE
    end
    else
      begin
        ValidCheck := FALSE;
        MessageBox(0,
               '数值超限(-9999.999至9999.999)',
               '输入错误',
               MB_OK or MB_ICONSTOP);
        edtSample.SetFocus;
        edtSample.SelectAll;
        exit;
      end;
  end
  else
    ValidCheck:=FALSE;
end;

procedure TfrmSample.ChkListBox;
begin
  if lstSample.Items.Count>0 then
  begin
    frmSample.Width:=530;
    btnRemove.Visible := TRUE;
    btnSave.Visible := TRUE;
    btnClear.Visible := TRUE;
    frmMIB.cmbSample.ItemIndex:=1;

    frmMIB.label2.Visible := TRUE;
    frmMIB.cmbSample.Visible := TRUE;
    if frmSample.lstSample.Items.Count>0 then
      frmMIB.cmbSample.ItemIndex:=1
    else
      frmMIB.cmbSample.ItemIndex:=0;
    if frmMIB.cmbSample.Items.Count>1 then
    begin
      frmMIB.label3.Visible := TRUE;
      frmMIB.label4.Visible := TRUE;
      frmMIB.cmbUp.Visible := TRUE;
      frmMIB.cmbDown.Visible := TRUE;
    end;
  end
  else
  begin
    frmSample.Width:=330;
    btnRemove.Visible :=FALSE;
    btnSave.Visible := FALSE;
    btnClear.Visible := FALSE;
    frmMIB.cmbSample.ItemIndex:=0;

    frmMIB.label2.Visible := FALSE;
    frmMIB.cmbSample.Visible := FALSE;

    frmMIB.label3.Visible := FALSE;
    frmMIB.label4.Visible := FALSE;
    frmMIB.cmbUp.Visible := FALSE;
    frmMIB.cmbDown.Visible := FALSE;

  end;
end;

procedure TfrmSample.DoAddItems;
var
  sAdd:string;
begin
  sAdd:=edtSample.Text;
  lstSample.Items.Add(sAdd);
  frmMIB.cmbSample.Items.Add(sAdd);
  lstSample.ItemIndex := lstSample.Items.Count-1;
end;

procedure TfrmSample.DoRemoveItems;
var
  n: integer;
begin
  frmMIB.cmbSample.Items.Delete(lstSample.ItemIndex+1);
  lstSample.Items.Delete(lstSample.ItemIndex);
end;

procedure TfrmSample.btnRemoveClick(Sender: TObject);
begin
  DoRemoveItems;
  ChkListBox;
end;

procedure TfrmSample.lstSampleDblClick(Sender: TObject);
begin
  DoRemoveItems;
  ChkListBox;
end;

procedure TfrmSample.btnClearClick(Sender: TObject);
begin
    if Application.MessageBox('确定要清除标称值列表中所有数据么?',
        '清除数据',MB_YESNO or MB_ICONWARNING) = IDYES then
    begin
        lstSample.Items.Clear;
        frmMIB.cmbSample.Items.Clear;
        frmMIB.cmbSample.Items.Add('NONE');
        ChkListBox;
    end;
end;

procedure TfrmSample.btnSaveClick(Sender: TObject);
var
  FileHandle : Integer;
begin
  frmMIB.ResetPath;
  if dlgSampleSave.Execute = TRUE then
  begin
  FileHandle := FileOpen(dlgSampleSave.FileName,fmOpenRead);
  if FileHandle > 0 then
  begin
    FileClose(FileHandle);
    if Application.MessageBox('文件已存在需要覆盖么？',
        '覆盖文件',MB_YESNO or MB_ICONWARNING) = IDYES then
       if dlgSampleSave.FileName<>'' then
       begin
          lstSample.Items.SaveToFile(dlgSampleSave.FileName);
       end;
  end
  else
  if dlgSampleSave.FileName<>'' then
  begin
    lstSample.Items.SaveToFile(dlgSampleSave.FileName);
  end;
  end;
end;

procedure TfrmSample.btnLoadClick(Sender: TObject);
var
  FileHandle : Integer;
  F:TextFile;
  sAdd:String;
  i:Integer;
begin
   frmMIB.ResetPath;
   if dlgSampleOpen.Execute = TRUE then
   begin
   FileHandle := FileOpen(dlgSampleOpen.FileName,fmOpenRead);
   if FileHandle > 0 then
   begin
    FileClose(FileHandle);
    AssignFile(F,dlgSampleOpen.FileName);
    Reset(F);
    if lstSample.Items.Count>0 then
      if Application.MessageBox('需要清除原有数据么',
        '清除数据',MB_YESNO or MB_ICONWARNING) = IDYES then
      begin
        lstSample.Items.Clear;
        frmMIB.cmbSample.Items.Clear;
        frmMIB.cmbSample.Items.Add('NONE');
        ChkListBox;
      end;
    while not eof(F) do
    begin
      readln(F,sAdd);
      if ValidCheck(sAdd)=TRUE then
      begin
        lstSample.Items.Add(sAdd);
        frmMIB.cmbSample.Items.Add(sAdd);
      end;
    end;
    ChkListBox;
    lstSample.ItemIndex := lstSample.Items.Count -1;
    CloseFile(F);
  end;
  end;
end;

procedure TfrmSample.FormShow(Sender: TObject);
begin
  if lstSample.Items.Count>0 then
    frmSample.Width:=530
  else
    frmSample.Width:=330;
end;

//////////////////////////////////////////////////////////////////

procedure TfrmSample.ChkListBoxUp;
begin
  if lstUp.Items.Count>0 then
  begin
    btnUpRemove.Visible := TRUE;
    btnUpSave.Visible := TRUE;
    btnUpClear.Visible := TRUE;
    frmMIB.cmbUp.ItemIndex:=1
  end
  else
  begin
    btnUpRemove.Visible :=FALSE;
    btnUpSave.Visible := FALSE;
    btnUpClear.Visible := FALSE;
    frmMIB.cmbUp.ItemIndex:=0;
 end;
end;

function TfrmSample.ValidCheckUp(s: string):Boolean;
var
  iCheck,nDot,nNav :Integer;
  fRange,fRangeCK : Double;
begin
  nDot:=0;
  nNav:=0;
  for iCheck:=1 to length(s) do
  begin
    case s[iCheck] of
      '-':
      begin
        nNav:=nNav+1;
        if LeftStr(s,1)='-' then
        begin
          if nNav>1 then
          begin
            ValidCheckUp := FALSE;
            MessageBox(0,
               '负号个数太多',
               '输入错误',
               MB_OK or MB_ICONSTOP);
            edtUp.SetFocus;
            edtUp.SelectAll;
            nNav:=0;
            exit;
          end;
          ValidCheckUp := TRUE;
       end
       else
       begin
          ValidCheckUp := FALSE;
          MessageBox(0,
             '负号位置不对',
             '输入错误',
             MB_OK or MB_ICONSTOP);
          edtUp.SetFocus;
          edtUp.SelectAll;
          exit;
       end;
      end;
      '0'..'9': ValidCheckUp := TRUE;
      '.' :
      begin
        nDot:=nDot+1;
        if nDot>1 then
        begin
          ValidCheckUp := FALSE;
          MessageBox(0,
               '小数点个数太多',
               '输入错误',
               MB_OK or MB_ICONSTOP);
          edtUp.SetFocus;
          edtUp.SelectAll;
          nDot:=0;
          exit;
        end
        else
          ValidCheckUp := TRUE;
      end;
    else
      begin
        ValidCheckUp := FALSE;
        MessageBox(0,
               '含有非法字符',
               '输入错误',
               MB_OK or MB_ICONSTOP);
        edtUp.SetFocus;
        edtUp.SelectAll;
        exit;
      end;
    end; // end case
  end;  // end for
  if s<>'' then
  begin
    fRange:=StrToFloat(s);
    fRange:=Round(fRange*1000)/1000;
    if (fRange>-1) and (fRange<1) then
    begin
      edtUp.Text := FloatToStr(fRange);
      ValidCheckUp := TRUE
    end
    else
      begin
        ValidCheckUp := FALSE;
        MessageBox(0,
               '数值超限(-1至1)',
               '输入错误',
               MB_OK or MB_ICONSTOP);
        edtUp.SetFocus;
        edtUp.SelectAll;
        exit;
      end;
  end
  else
    ValidCheckUp:=FALSE;
end;

procedure TfrmSample.DoUpAddItems;
var
  sAdd:string;
begin
  sAdd:=edtUp.Text;
  lstUp.Items.Add(sAdd);
  frmMIB.cmbUp.Items.Add(sAdd);
  lstUp.ItemIndex := lstUp.Items.Count-1;
end;

procedure TfrmSample.DoUpRemoveItems;
begin
  frmMIB.cmbUp.Items.Delete(lstUp.ItemIndex+1);
  lstUp.Items.Delete(lstUp.ItemIndex);
end;

procedure TfrmSample.btnUpAddClick(Sender: TObject);
begin
  if (ValidCheckUp(edtUp.Text) = TRUE) and
     (edtUp.Text <> '')  then
    begin
      DoUpAddItems;
      ChkListBoxUp;
    end;
end;

procedure TfrmSample.btnUpLoadClick(Sender: TObject);
var
  FileHandle : Integer;
  F:TextFile;
  sAdd:String;
  i:Integer;
begin
   frmMIB.ResetPath;
   if dlgUpOpen.Execute = TRUE then
   begin
   FileHandle := FileOpen(dlgUpOpen.FileName,fmOpenRead);
   if FileHandle > 0 then
   begin
    FileClose(FileHandle);
    AssignFile(F,dlgUpOpen.FileName);
    Reset(F);
    if lstUp.Items.Count>0 then
      if Application.MessageBox('需要清除原有数据么',
        '清除数据',MB_YESNO or MB_ICONWARNING) = IDYES then
      begin
        lstUp.Items.Clear;
        frmMIB.cmbUp.Items.Clear;
        frmMIB.cmbUp.Items.Add('0');
        ChkListBoxUp;
      end;
    while not eof(F) do
    begin
      readln(F,sAdd);
      if ValidCheckUp(sAdd)=TRUE then
      begin
        lstUp.Items.Add(sAdd);
        frmMIB.cmbUp.Items.Add(sAdd);
      end;
    end;
    ChkListBoxUp;
    lstUp.ItemIndex := lstUp.Items.Count -1;
    CloseFile(F);
  end;
  end;
end;

procedure TfrmSample.btnUpSaveClick(Sender: TObject);
var
  FileHandle : Integer;
begin
  frmMIB.ResetPath;
  if dlgUpSave.Execute = TRUE then
  begin
  FileHandle := FileOpen(dlgUpSave.FileName,fmOpenRead);
  if FileHandle > 0 then
  begin
    FileClose(FileHandle);
    if Application.MessageBox('文件已存在需要覆盖么？',
        '覆盖文件',MB_YESNO or MB_ICONWARNING) = IDYES then
       if dlgUpSave.FileName<>'' then
       begin
          lstUp.Items.SaveToFile(dlgUpSave.FileName);
       end;
  end
  else
  if dlgUpSave.FileName<>'' then
  begin
    lstUp.Items.SaveToFile(dlgUpSave.FileName);
  end;
  end;
end;

procedure TfrmSample.btnUpClearClick(Sender: TObject);
begin
    if Application.MessageBox('确定要清除上偏差列表中所有数据么?',
        '清除数据',MB_YESNO or MB_ICONWARNING) = IDYES then
    begin
        lstUp.Items.Clear;
        frmMIB.cmbUp.Items.Clear;
        frmMIB.cmbUp.Items.Add('0');
        ChkListBoxUp;
    end;
end;

procedure TfrmSample.btnUpRemoveClick(Sender: TObject);
begin
  DoUpRemoveItems;
  ChkListBoxUp;
end;

procedure TfrmSample.lstUpDblClick(Sender: TObject);
begin
  DoUpRemoveItems;
  ChkListBoxUp;
end;

///////////////////////////////////////////////////////////////

procedure TfrmSample.ChkListBoxDown;
begin
  if lstDown.Items.Count>0 then
  begin
    btnDownRemove.Visible := TRUE;
    btnDownSave.Visible := TRUE;
    btnDownClear.Visible := TRUE;
    frmMIB.cmbDown.ItemIndex:=1
  end
  else
  begin
    btnDownRemove.Visible :=FALSE;
    btnDownSave.Visible := FALSE;
    btnDownClear.Visible := FALSE;
    frmMIB.cmbDown.ItemIndex:=0;
 end;
end;

function TfrmSample.ValidCheckDown(s: string):Boolean;
var
  iCheck,nDot,nNav :Integer;
  fRange,fRangeCK : Double;
begin
  nDot:=0;
  nNav:=0;
  for iCheck:=1 to length(s) do
  begin
    case s[iCheck] of
      '-':
      begin
        nNav:=nNav+1;
        if LeftStr(s,1)='-' then
        begin
          if nNav>1 then
          begin
            ValidCheckDown := FALSE;
            MessageBox(0,
               '负号个数太多',
               '输入错误',
               MB_OK or MB_ICONSTOP);
            edtDown.SetFocus;
            edtDown.SelectAll;
            nNav:=0;
            exit;
          end;
          ValidCheckDown := TRUE;
       end
       else
       begin
          ValidCheckDown := FALSE;
          MessageBox(0,
             '负号位置不对',
             '输入错误',
             MB_OK or MB_ICONSTOP);
          edtDown.SetFocus;
          edtDown.SelectAll;
          exit;
       end;
      end;
      '0'..'9': ValidCheckDown := TRUE;
      '.' :
      begin
        nDot:=nDot+1;
        if nDot>1 then
        begin
          ValidCheckDown := FALSE;
          MessageBox(0,
               '小数点个数太多',
               '输入错误',
               MB_OK or MB_ICONSTOP);
          edtDown.SetFocus;
          edtDown.SelectAll;
          nDot:=0;
          exit;
        end
        else
          ValidCheckDown := TRUE;
      end;
    else
      begin
        ValidCheckDown := FALSE;
        MessageBox(0,
               '含有非法字符',
               '输入错误',
               MB_OK or MB_ICONSTOP);
        edtDown.SetFocus;
        edtDown.SelectAll;
        exit;
      end;
    end; // end case
  end;  // end for
  if s<>'' then
  begin
    fRange:=StrToFloat(s);
    fRange:=Round(fRange*1000)/1000;
    if (fRange>-1) and (fRange<1) then
    begin
      edtDown.Text := FloatToStr(fRange);
      ValidCheckDown := TRUE
    end
    else
      begin
        ValidCheckDown := FALSE;
        MessageBox(0,
               '数值超限(-1至1)',
               '输入错误',
               MB_OK or MB_ICONSTOP);
        edtDown.SetFocus;
        edtDown.SelectAll;
        exit;
      end;
  end
  else
    ValidCheckDown:=FALSE;
end;

procedure TfrmSample.DoDownAddItems;
var
  sAdd:string;
begin
  sAdd:=edtDown.Text;
  lstDown.Items.Add(sAdd);
  frmMIB.cmbDown.Items.Add(sAdd);
  lstDown.ItemIndex := lstDown.Items.Count-1;
end;

procedure TfrmSample.DoDownRemoveItems;
begin
  frmMIB.cmbDown.Items.Delete(lstDown.ItemIndex+1);
  lstDown.Items.Delete(lstDown.ItemIndex);
end;

procedure TfrmSample.btnDownAddClick(Sender: TObject);
begin
  if (ValidCheckDown(edtDown.Text) = TRUE) and
     (edtDown.Text <> '')  then
    begin
      DoDownAddItems;
      ChkListBoxDown;
    end;

end;

procedure TfrmSample.btnDownLoadClick(Sender: TObject);
var
  FileHandle : Integer;
  F:TextFile;
  sAdd:String;
  i:Integer;
begin
   frmMIB.ResetPath;
   if dlgDownOpen.Execute = TRUE then
   begin
   FileHandle := FileOpen(dlgDownOpen.FileName,fmOpenRead);
   if FileHandle > 0 then
   begin
    FileClose(FileHandle);
    AssignFile(F,dlgDownOpen.FileName);
    Reset(F);
    if lstDown.Items.Count>0 then
      if Application.MessageBox('需要清除原有数据么',
        '清除数据',MB_YESNO or MB_ICONWARNING) = IDYES then
      begin
        lstDown.Items.Clear;
        frmMIB.cmbDown.Items.Clear;
        frmMIB.cmbDown.Items.Add('0');
        ChkListBoxDown;
      end;
    while not eof(F) do
    begin
      readln(F,sAdd);
      if ValidCheckDown(sAdd)=TRUE then
      begin
        lstDown.Items.Add(sAdd);
        frmMIB.cmbDown.Items.Add(sAdd);
      end;
    end;
    ChkListBoxDown;
    lstDown.ItemIndex := lstDown.Items.Count -1;
    CloseFile(F);
  end;
  end;
end;

procedure TfrmSample.btnDownSaveClick(Sender: TObject);
var
  FileHandle : Integer;
begin
  frmMIB.ResetPath;
  if dlgDownSave.Execute = TRUE then
  begin
  FileHandle := FileOpen(dlgDownSave.FileName,fmOpenRead);
  if FileHandle > 0 then
  begin
    FileClose(FileHandle);
    if Application.MessageBox('文件已存在需要覆盖么？',
        '覆盖文件',MB_YESNO or MB_ICONWARNING) = IDYES then
       if dlgDownSave.FileName<>'' then
       begin
          lstDown.Items.SaveToFile(dlgDownSave.FileName);
       end;
  end
  else
  if dlgDownSave.FileName<>'' then
  begin
    lstDown.Items.SaveToFile(dlgDownSave.FileName);
  end;
  end;
end;

procedure TfrmSample.btnDownClearClick(Sender: TObject);
begin
    if Application.MessageBox('确定要清除下偏差列表中所有数据么?',
        '清除数据',MB_YESNO or MB_ICONWARNING) = IDYES then
    begin
        lstDown.Items.Clear;
        frmMIB.cmbDown.Items.Clear;
        frmMIB.cmbDown.Items.Add('0');
        ChkListBoxDown;
    end;

end;

procedure TfrmSample.btnDownRemoveClick(Sender: TObject);
begin
  DoDownRemoveItems;
  ChkListBoxDown;
end;

procedure TfrmSample.lstDownDblClick(Sender: TObject);
begin
  DoDownRemoveItems;
  ChkListBoxDown;
end;

end.
