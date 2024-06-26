unit MIB;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Menus, StrUtils, Registry, Math, XPMan,
  ToolWin, ComCtrls;

type
  TfrmMIB = class(TForm)
    btnENT: TButton;
    edtNUM: TEdit;
    btnCALL: TButton;
    btnCLR: TButton;
    btnMMIN: TButton;
    panDisplay: TPanel;
    mnuMIB: TMainMenu;
    N3: TMenuItem;
    nExit: TMenuItem;
    N1: TMenuItem;
    nUsehelp: TMenuItem;
    bAbout: TMenuItem;
    cmbCOM: TComboBox;
    Label1: TLabel;
    dlgSaveLST: TSaveDialog;
    btnSaveLst: TButton;
    btnAddData: TButton;
    btnMauMode: TButton;
    btnSign: TButton;
    btnGetDisplay: TButton;
    btnCLRLst: TButton;
    btnCCtl: TButton;
    btnAutoMode: TButton;
    tmrGetData: TTimer;
    nSysSet: TMenuItem;
    lstData: TListBox;
    Bevel4: TBevel;
    Label5: TLabel;
    btnRemove: TButton;
    lblShow: TLabel;
    cmbSample: TComboBox;
    Label2: TLabel;
    nSample: TMenuItem;
    btnLoadLst: TButton;
    dlgOpenLST: TOpenDialog;
    cmbUp: TComboBox;
    cmbDown: TComboBox;
    Label3: TLabel;
    Label4: TLabel;
    Bevel1: TBevel;
    Label6: TLabel;
    procedure nExitClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cmbCOMChange(Sender: TObject);
    procedure btnCLRClick(Sender: TObject);
    procedure btnMMINClick(Sender: TObject);
    procedure btnCALLClick(Sender: TObject);
    procedure btnENTClick(Sender: TObject);
    procedure bAboutClick(Sender: TObject);
    procedure edtNUMChange(Sender: TObject);
    procedure edtNUMKeyPress(Sender: TObject; var Key: Char);
    procedure btnSignClick(Sender: TObject);
    procedure btnGetDisplayClick(Sender: TObject);
    procedure btnMauModeClick(Sender: TObject);
    procedure btnAutoModeClick(Sender: TObject);
    procedure btnAddDataClick(Sender: TObject);
    procedure btnCLRLstClick(Sender: TObject);
    procedure btnSaveLstClick(Sender: TObject);
    procedure tmrGetDataTimer(Sender: TObject);
    procedure btnCCtlClick(Sender: TObject);
    procedure lstDataDblClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure nSysSetClick(Sender: TObject);
    procedure edtNUMExit(Sender: TObject);
    procedure nUsehelpClick(Sender: TObject);
    procedure btnRemoveClick(Sender: TObject);
    procedure nSampleClick(Sender: TObject);
    procedure btnLoadLstClick(Sender: TObject);
    procedure lstDataDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure lstDataDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure cmbSampleChange(Sender: TObject);
  private
    { Private declarations }
    ThreadsRunning : integer;
    KeyValue : Char;
    bSign, bSignDot, bGetDisplay: Boolean;
    bTimer : Boolean;
    nDefPos, nDefZero, nDefNav, nPartF: integer;

    sDefAllow:string;
    
    Procedure ThreadDone(Sender: TObject);
    procedure OpenComm(strPort: String);
    procedure SendData(s:string);
    procedure ExitSystem;
    procedure RegInit;
    procedure ChkListBox;
    procedure Compute;
    procedure DnyCompute;
    procedure MySave;
    procedure StopGet;

    function ValidCheckEdt(s: string):Boolean;
    function ValidCheckLst(s: string):Boolean;

  public
    iCTimer : Cardinal;
    bInch : BOOLEAN; //delfalt is FALSE
    StrGetShow : string;
    hSerialPort: THandle;
    ovl : OVERLAPPED;
    lpovl : POINTER;
    { Public declarations }


    
    procedure ResetPath;
  end;

var
  frmMIB: TfrmMIB;


implementation

uses DISPLAY, SysSet, About, Sample;//uses About, SysSet;
{$R *.dfm}
function ShellExecute(HWnd: Integer; lpOperation, lpFile, lpParameters, lpDirectory :PChar; nShowCmd: Integer): Integer; stdcall; external 'shell32.dll' name 'ShellExecuteA';





procedure TfrmMIB.ThreadDone(Sender: TObject);
begin
  Dec(ThreadsRunning);
  if ThreadsRunning = 0 then
  begin
    closehandle(hSerialPort);
  end;
end;

procedure TfrmMIB.nExitClick(Sender: TObject);
begin
frmMIB.Close;
end;

procedure TfrmMIB.OpenComm(strPort: String);
var
cc:TCOMMCONFIG;
Temp:String;

begin
  Temp:=cmbCOM.Text;
  hSerialPort:=CreateFile(PChar(Temp),
                          GENERIC_READ or GENERIC_WRITE,
                          0,
                          nil,
                          OPEN_EXISTING,
                          0,
                          0);
  if (hSerialPort=INVALID_HANDLE_VALUE) then
  begin
    MessageBox(0,
               '打开串口时发生错误',
               '错误',
                MB_OK or MB_ICONERROR);
    panDisplay.Caption := '';
    exit;
  end;
  GetCommState(hSerialPort,cc.dcb);
  cc.dcb.BaudRate:=CBR_4800;
  cc.dcb.ByteSize:=8;
  cc.dcb.Parity:=NOPARITY;
  cc.dcb.StopBits:=ONESTOPBIT;
  if not SetCommState(hSerialPort, cc.dcb) then
  begin
    MessageBox(0,
               '不能设置串口',
               '错误',
               MB_OK or MB_ICONERROR);
    panDisplay.Caption := '';
    CloseHandle(hSerialPort);
    exit;
  end;
end;

procedure TfrmMIB.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  //Dec(ThreadsRunning);
  ExitSystem;
end;

procedure TfrmMIB.ExitSystem;
begin
  Dec(ThreadsRunning);
  if ThreadsRunning = 0 then
  begin
    tdisp.Free;
  end;
  CloseHandle(hSerialPort);
end;

procedure TfrmMIB.cmbCOMChange(Sender: TObject);
begin
  if (hSerialPort <> 0) then closehandle(hSerialPort);
  OpenComm(cmbCOM.Text);
end;

procedure TfrmMIB.btnCLRClick(Sender: TObject);
var
  StrSndTmp : String;
  i:Integer;
begin
  StrSndTmp := '.';
  for i:=1 to length(StrSndTmp) do
  SendData(StrSndTmp[i]);
  StrSndTmp := 'E0.0E';
  for i:=1 to length(StrSndTmp) do
  SendData(StrSndTmp[i]);
end;

procedure TfrmMIB.SendData(s:string);
var
  lrc : LongWord;
  i:integer;
 s1:string;
begin
  if (hSerialPort=0) then exit;
  
 for i:=1 to length(s) do
 begin
  s1:=s[i];
  WriteFile(hSerialPort, Pointer(s1)^,length(s1),lrc,lpovl);
  Sleep(150);
 end;
end;

procedure TfrmMIB.btnMMINClick(Sender: TObject);
begin
  if bInch = FALSE then
  begin
    bInch := TRUE;
    label5.Caption :='英制';
  end
  else
  begin
    bInch := FALSE;
    label5.Caption :='公制';
  end;
  SendData('M');
end;

procedure TfrmMIB.btnCALLClick(Sender: TObject);
begin
  SendData('C');
end;

procedure TfrmMIB.btnENTClick(Sender: TObject);
var
  s:string;
begin
  btnCLR.Click;
  s:=edtNUM.Text;
  if ValidCheckEdt(s)=TRUE then
    if s<>'' then
      if bSign=FALSE then
      begin
        SendData(s);
        SendData('E');
      end
      else
      begin
        SendData(s);
        if bGetDisplay=FALSE then sendData('+');
        SendData('E');
      end

end;

procedure TfrmMIB.bAboutClick(Sender: TObject);
begin
  frmAbout.ShowModal;
end;

procedure TfrmMIB.edtNUMChange(Sender: TObject);
var
  strTmp : string;
  i : Integer;
begin
    StrTmp := edtNUM.Text;
    if bSign = TRUE then SendData('+');
    case KeyValue of
    '0'..'9':
    begin
      if ValidCheckEdt(strTmp)=TRUE then
      begin
        {btnCLR.Click;
        for i:=1 to length(StrTmp) do
          SendData(StrTmp[i]);}
      end;
    end;
    '.':
    begin
      bSignDot:=TRUE;
      if ValidCheckEdt(strTmp)=TRUE then
      begin
        {btnCLR.Click;
        for i:=1 to length(StrTmp) do
          SendData(StrTmp[i]); }
      end;
      bSignDot:=FALSE;
     end;
    #8:
    Begin
      if ValidCheckEdt(strTmp)=TRUE then
      begin
        {btnCLR.Click;
        for i:=1 to length(StrTmp) do
          SendData(StrTmp[i]);}
      end;
    end;
    else
      exit;
  end;

end;

procedure TfrmMIB.edtNUMKeyPress(Sender: TObject; var Key: Char);
var s:string;
begin
  KeyValue := Key;
  case key of
    #13:
    Begin
  btnCLR.Click;
  s:=edtNUM.Text;
  if ValidCheckEdt(s)=TRUE then
    if s<>'' then
      if bSign=FALSE then
      begin
        SendData(s);
        SendData('E');
      end
      else
      begin
        SendData(s);
        if bGetDisplay=FALSE then sendData('+');
        SendData('E');
      end
      else
        edtNum.SetFocus;
    end;
  end;
end;

procedure TfrmMIB.btnSignClick(Sender: TObject);
begin
  if bSign = FALSE then
  begin
    btnSign.Caption := '-';
    bSign := TRUE;
  end
  else
  Begin
    btnSign.Caption := '+';
    bSign := FALSE;
  end;
  //SendData('+');
end;

procedure TfrmMIB.btnGetDisplayClick(Sender: TObject);
var
  StrTmp : String;
begin
  bGetDisplay:=TRUE;
  StrTmp := StrGetShow;
  if StrTmp[1] = '-' then
  begin
    StrTmp := RightStr(StrTmp,Length(StrTmp)-1);
    btnSign.Caption := '-';
    bSign := TRUE;
    edtNUM.Text := StrTmp;
  end
  else
  begin
    bSign := FALSE;
    edtNUM.Text := StrGetShow;
  end;
  btnEnt.Click;
  bGetDisplay:=FALSE
end;

procedure TfrmMIB.btnMauModeClick(Sender: TObject);
begin
  label6.Caption := '自动模式';
  btnMauMode.Visible := FALSE;
  btnAddData.Visible :=FALSE;
  btnAutoMode.Visible := TRUE;
  btnCCtl.Visible := TRUE;
end;

procedure TfrmMIB.btnAutoModeClick(Sender: TObject);
begin
  label6.Caption := '手动模式';
  btnMauMode.Visible := TRUE;
  btnAddData.Visible :=TRUE;
  btnAutoMode.Visible := FALSE;
  btnCCtl.Visible := FALSE;

  StopGet;
end;

procedure TfrmMIB.btnAddDataClick(Sender: TObject);
var
  strAddTmp :String;
begin
  strAddTmp := strGetShow;
  if strAddTmp <> '' then
  begin
    lstData.Items.Add(strAddTmp);
    ChkListBox;
    lstData.ItemIndex:=lstData.Items.Count-1;
    DnyCompute;
  end;
end;

procedure TfrmMIB.btnCLRLstClick(Sender: TObject);
begin
    StopGet;
    if Application.MessageBox('确定要清除列表中所有数据么?',
        '清除数据',MB_YESNO or MB_ICONWARNING) = IDYES then
    begin
        lstData.Items.Clear;
        ChkListBox;
        lblShow.Caption:='';
    end;
end;

procedure TfrmMIB.btnSaveLstClick(Sender: TObject);
var
  FileHandle, iPos, nPos : Integer;
  sNewFileName,sNewFilePath: String;
begin
  ResetPath;
  if dlgSaveLst.Execute = TRUE then
  begin
  FileHandle := FileOpen(dlgSaveLst.FileName,fmOpenRead);
  sNewFileName:=ExtractFileName(dlgSaveLst.FileName);
  sNewFilePath:=ExtractFilePath(dlgSaveLst.FileName);
  nPos:=Pos('.txt',sNewFileName);
  //iPos:=Length(sNewFileName)-nPos-1;
  sNewFileName:=sNewFilePath+LeftStr(sNewFileName,nPos-1)+'.ls';
  //showmessage(sNewFileName);
  if FileHandle > 0 then
  begin
    FileClose(FileHandle);
    if Application.MessageBox('文件已存在需要覆盖么？',
        '覆盖文件',MB_YESNO or MB_ICONWARNING) = IDYES then
       if dlgSaveLst.FileName<>'' then
       begin
          lstData.Items.SaveToFile(sNewFileName);
          MySave;
          Compute;
       end;
  end
  else
  if dlgSaveLst.FileName<>'' then
  begin
    lstData.Items.SaveToFile(sNewFileName);
    MySave;
    Compute;
  end;
  end;
end;

procedure TfrmMIB.Compute;
var
  F:TextFile;
  s1,s2,sMax,sMin,sAve,sMsg,sDef,sMsg1:string;
  i,n, nPartP:integer;
  fMax,fMin,f1,f2,fSum,fAve,fDef:double;
begin
  s1:=lstData.Items[lstData.Items.Count-1];
  f1:=StrToFloat(s1);
  fMax:=f1;
  fMin:=f1;
  fSum:=f1;
  n:=lstData.Items.Count;
  for i:=n-1 downto 1 do
  begin
    s2:=lstData.Items[i-1];
    f2:=StrToFloat(s2);
    fMax:=max(fMax,f2);
    fMin:=min(fMin,f2);
    fSum:=fSum+f2;
  end;
  fAve:=fSum/n;
  fAve:=Round(fAve*10000)/10000;
  fDef:=fMax-fMin;
  fDef:=Round(fDef*1000)/1000;
  AssignFile(F,dlgSaveLst.FileName);
  Append(F);
  try
    begin
      sMax:=FloatToStr(fMax);
      writeln(F,'');
      write(F,'最大值为：',sMax, '  ');
      sMin:=FloatToStr(fMin);
      writeln(F,'最小值为：',sMin);
      writeln(F,'');
      sAve:=FloatToStr(fAve);
      writeln(F,'平均值为：',sAve);
      writeln(F,'');
      sDef:=FloatToStr(fDef);
      write(F,'波动范围：',sDef,'   ');
      if (cmbSample.Text<>'') and (cmbSample.Text<>'NONE') then
      begin
        writeln(F,'允许波动范围：',sDefAllow);
        writeln(F,'');
        write(F,'正偏差：',IntToStr(nDefPos),'个  ');
        write(F,'负偏差：',IntToStr(nDefNav),'个  ');
        writeln(F,'零偏差：',IntToStr(nDefZero),'个');
        writeln(F,'');
        write(F,'合格零件：',IntToStr(n-nPartF),'个  ');
        writeln(F,'合格率：',FloatToStr(Round(((n-nPartF)/n)*10000)/100),'％');
        writeln(F,'');
        write(F,'不合格零件：',IntToStr(nPartF),'个  ');
        writeln(F,'不合格率：',FloatToStr(Round((nPartF/n)*10000)/100),'％');
      end;
    end;
  finally
    CloseFile(F);
    sMsg:='最大值为：'+sMax+' '
    +'最小值为：'+sMin+#13+#13
    +'平均值为：'+sAve+#13+#13
    +'波动范围：'+sDef+' 允许波动范围：'+sDefAllow;
    if (cmbSample.Text<>'') and (cmbSample.Text<>'NONE') then
    begin
      sMsg1:=sMsg+#13+#13
      +'正偏差：'+IntToStr(nDefPos)+'个 '
      +'负偏差：'+IntToStr(nDefNav)+'个 '
      +'零偏差：'+IntToStr(nDefZero)+'个 '+#13+#13
      +'合格零件：'+IntToStr(n-nPartF)+'个  '
      +'合格率：'+FloatToStr(Round(((n-nPartF)/n)*10000)/100)+'％'+#13+#13
      +'不合格零件：'+IntToStr(nPartF)+'个  '
      +'不合格率：'+FloatToStr(Round((nPartF/n)*10000)/100)+'％';
      showmessage(sMsg1);
    end
    else
      showmessage(sMsg);
  end;
end;

procedure TfrmMIB.DnyCompute;
var
  s1,s2,sMax,sMin,sAve,sMsg,sDef:string;
  i,n:integer;
  fMax,fMin,f1,f2,fSum,fAve,fDef:double;
begin
  s1:=lstData.Items[lstData.Items.Count-1];
  f1:=StrToFloat(s1);
  fMax:=f1;
  fMin:=f1;
  fSum:=f1;
  n:=lstData.Items.Count;
  for i:=n-1 downto 1 do
  begin
    s2:=lstData.Items[i-1];
    f2:=StrToFloat(s2);
    fMax:=max(fMax,f2);
    fMin:=min(fMin,f2);
    fSum:=fSum+f2;
  end;
  fAve:=fSum/n;
  fAve:=Round(fAve*10000)/10000;
  fDef:=fMax-fMin;
  fDef:=Round(fDef*1000)/1000;
  sMax:=FloatToStr(fMax);
  sMin:=FloatToStr(fMin);
  sAve:=FloatToStr(fAve);
  sDef:=FloatToStr(fDef);
  sMsg:='最大值为：'+sMax+' '
    +'最小值为：'+sMin+' '
    +'平均值为：'+sAve+' '
    +'波动范围：'+sDef;
  lblShow.Caption:=sMsg;
end;

procedure TfrmMIB.MySave;
var
  F:TextFile;
  s1,s2, sDef, SDefOK, sPartF, sMinDef:string;
  f1,f2, fDef, fDefUD, fDefUp, fDefDown, fDefAllow, fUp, fDown:double;
  i,n:integer;
begin
  nDefPos:=0;
  nDefZero:=0;
  nDefNav:=0;
  nPartF:=0;
  AssignFile(F,dlgSaveLst.FileName);
  Rewrite(F);
  try
     n:=lstData.Items.Count;
     if (cmbSample.Text<>'') and (cmbSample.Text<>'NONE') then
     begin
        fUp:=StrToFloat(cmbUp.Text);          //上偏差
        fDown:=StrToFloat(cmbDown.Text);      //下偏差
        fDefAllow:=Round(abs(fUp-fDown)*1000)/1000;   //允差范围
        sDefAllow:=FloatToStr(fDefAllow);

        f2:=StrToFloat(cmbSample.Text);       //标称值
        fDefUp:=f2+fUp;
        fDefDown:=f2+fDown;
        write(F,'标称值：',cmbSample.Text,' ');
        write(F,'上偏差：',cmbUp.Text,' ');
        write(F,'下偏差：',cmbDown.Text,' ');
        write(F,'合格范围：',FloatToStr(Round(Min(fDefUp,fDefDown)*1000)/1000),
        '至',FloatToStr(Round(Max(fDefUp,fDefDown)*1000)/1000));
        writeln(F,'');
        writeln(F,'');
     end;
     for i:=1 to n do
     begin
        s1:='第';
        s2:='次取值：';
        write(F,s1,i,s2,lstData.Items[i-1]);
        if (cmbSample.Text<>'') and (cmbSample.Text<>'NONE') then
        begin
          f1:=StrToFloat(lstData.Items[i-1]);   //原始数据
          fDef:=f1-f2;
          fDef:=Round(fDef*1000)/1000;          //误差值
          sDefOK:=FloatToStr(fDef);


          if (f1>Max(fDefUp,fDefDown)) or (f1<Min(fDefUp,fDefDown)) then
          begin
           if fDef<>0 then
           begin
              sPartF:='  零件超差';
              sMinDef:=FloatToStr(Round(Min(abs(f1-fDefUp),abs(f1-fDefDown))*1000)/1000);
              sMinDef:='  最少超差：'+sMinDef;
              nPartF:= nPartF+1;
           end
           else
           begin
              sPartF:='';
              sMinDef:='';
           end;
          end
          else
          begin
           sPartF:='';
           sMinDef:='';
          end;
        if fDef>0 then
          begin
            nDefPos:=nDefPos+1;
            sDef:='   取样值  >  标称值';
          end;
          if fDef=0 then
          begin
            nDefZero:=nDefZero+1;
            sDef:='   取样值  =  标称值';
          end;
          if fDef<0 then
          begin
            nDefNav:=nDefNav+1;
            sDef:='   取样值  <  标称值';
          end;
          writeln(F,'  误差为：',sDefOK,sDef,sPartF,sMinDef);
          end
          else
          writeln(F,'');//end if
     end;  // end for
   finally
    CloseFile(F);
  end;
end;

procedure TfrmMIB.tmrGetDataTimer(Sender: TObject);
var
  strAddTmp :String;
begin
  strAddTmp := strGetShow;
  if frmSysSet.bTimes = TRUE then
  begin
    if strAddTmp <> '' then
    begin
      lstData.Items.Add(strAddTmp);
      ChkListBox;
      lstData.ItemIndex:=lstData.Items.Count-1;
      DnyCompute;
      iCTimer := iCTimer + 1;
      if iCTimer >= frmSysSet.iTimes then
      begin
        iCTimer := 0;
        btnCCtl.Click;
      end;
    end;
  end
  else
  begin
    if strAddTmp <> '' then
    begin
      lstData.Items.Add(strAddTmp);
      ChkListBox;
      lstData.ItemIndex:=lstData.Items.Count-1;
      DnyCompute;
    end;
  end;
end;

procedure TfrmMIB.btnCCtlClick(Sender: TObject);
begin
  if bTimer = FALSE then
  begin
    btnCCtl.Caption := '停止取数';
    btnCCtl.Hint := '停止取数';
    tmrGetData.Enabled := TRUE;
    bTimer := TRUE;
    if frmSysSet.bInterval = TRUE then
      tmrGetData.Interval := frmSysSet.iInterval;
  end
  else
  begin
    btnCCtl.Caption := '自动取数';
    btnCCtl.Hint := '自动取数';
    tmrGetData.Enabled := FALSE;
    bTimer := FALSE;
    iCTimer := 0;
  end;
end;

procedure TfrmMIB.lstDataDblClick(Sender: TObject);
begin
  lstData.Items.Delete(lstdata.ItemIndex);
  ChkListBox;
  if lstData.Items.Count>=1 then DnyCompute
  else lblShow.Caption:='';
end;

procedure TfrmMIB.FormShow(Sender: TObject);
begin
  bInch := FALSE;
  bSign := FALSE;
  bTimer := FALSE;
  bSignDot := FALSE;
  bGetDisplay := FALSE;

  ovl.Offset :=0;
  lpovl := @ovl;

  iCTimer := 0;
  if not DirectoryExists('.\\SAMPLE') then
    if not CreateDir('.\\SAMPLE') then
    raise Exception.Create('Cannot create .\\SAMPLE');
  if not DirectoryExists('.\\RESULT') then
    if not CreateDir('.\\RESULT') then
    raise Exception.Create('Cannot create .\\RESULT');
  RegInit;
  OpenComm(cmbCOM.Text);
  ThreadsRunning := 1;
  with TDISPLAY.Create(False) do
  OnTerminate := ThreadDone;


end;

procedure TfrmMIB.nSysSetClick(Sender: TObject);
begin
  frmSysSet.ShowModal;
end;

function TfrmMIB.ValidCheckEdt(s: string):Boolean;
var
  iCheck,nDot :Integer;
  fRange : Double;
begin
  nDot:=0;
  for iCheck:=1 to length(s) do
  begin
    case s[iCheck] of
      '0'..'9': ValidCheckEdt := TRUE;
      '.' :
      begin
        nDot:=nDot+1;
        if nDot>1 then
        begin
          ValidCheckEdt := FALSE;
          MessageBox(0,
               '小数点个数太多',
               '输入错误',
               MB_OK or MB_ICONSTOP);
          edtNum.SelectAll;
          nDot:=0;
          exit;
        end
        else
          ValidCheckEdt := TRUE;
      end;
    else
      begin
        ValidCheckEdt := FALSE;
        MessageBox(0,
               '含有非法字符',
               '输入错误',
               MB_OK or MB_ICONSTOP);
        edtNum.SelectAll;
        exit;
      end;
    end; // end case
  end;  // end for
  if s<>'' then
  begin
    fRange:=StrToFloat(s);
    fRange:=Round(fRange*1000)/1000;
    if (fRange>=0) and (fRange<=9999.999) then
    begin
      if bSignDot<>TRUE then
      edtNum.Text:= FloatToStr(fRange);
      ValidCheckEdt := TRUE;
    end
    else
      begin
        ValidCheckEdt := FALSE;
        MessageBox(0,
               '数值超限(0-9999.999)',
               '输入错误',
               MB_OK or MB_ICONSTOP);
        edtNum.SelectAll;
        exit;
      end;
  end
  else
    ValidCheckEdt:=FALSE;
end;

procedure TfrmMIB.edtNUMExit(Sender: TObject);
begin
  if (ValidCheckEdt(edtNUM.Text) = FALSE) and
     (edtNUM.Text <> '')  then
    edtNUM.SetFocus;
end;

procedure TfrmMIB.RegInit;
var
  strRegCbI, strRegCbT : string;
  strRegEdtI, strRegEdtT : string;
begin
  strRegCbI := frmSysSet.GetRegistryValue('cfInterval');
  strRegCbT := frmSysSet.GetRegistryValue('cfTimes');
  strRegEdtI := frmSysSet.GetRegistryValue('Interval');
  strRegEdtT := frmSysSet.GetRegistryValue('Times');
  if strRegCbI = '1' then
    tmrGetData.Interval := StrtoInt(strRegEdtI);
  if strRegCbT = '1' then
  begin
    frmSysSet.bTimes := TRUE;
    frmSysSet.iTimes := StrtoInt(strRegEdtT);
  end;
end;

procedure TfrmMIB.nUsehelpClick(Sender: TObject);
begin
ShellExecute(self.Handle,
            'open',
            pchar('.\\MBThelp.chm'),
             nil, nil, SW_SHOWNORMAL);
end;

procedure TfrmMIB.btnRemoveClick(Sender: TObject);
begin
  StopGet;
  lstData.Items.Delete(lstdata.ItemIndex);
  ChkListBox;
  if lstData.Items.Count>=1 then DnyCompute
  else lblShow.Caption:='';
end;

procedure TfrmMIB.ChkListBox;
begin
  if lstData.Items.Count>0 then
  begin
    btnRemove.Visible := TRUE;
    btnSaveLst.Visible := TRUE;
    btnCLRLst.Visible := TRUE;
    label2.Visible := TRUE;
    cmbSample.Visible := TRUE;
    if frmSample.lstSample.Items.Count>0 then
      cmbSample.ItemIndex:=1
    else
      cmbSample.ItemIndex:=0;
    if cmbSample.Items.Count>1 then
    begin
      label3.Visible := TRUE;
      label4.Visible := TRUE;
      cmbUp.Visible := TRUE;
      cmbDown.Visible := TRUE;
    end;
  end
  else
  begin
    btnRemove.Visible :=FALSE;
    btnSaveLst.Visible := FALSE;
    btnCLRLst.Visible := FALSE;
    label2.Visible := FALSE;
    cmbSample.Visible := FALSE;
    cmbSample.ItemIndex:=0;
    label3.Visible := FALSE;
    label4.Visible := FALSE;
    cmbUp.Visible := FALSE;
    cmbDown.Visible := FALSE;
  end;
end;

procedure TfrmMIB.nSampleClick(Sender: TObject);
begin
 frmSample.ShowModal;
end;

procedure TfrmMIB.btnLoadLstClick(Sender: TObject);
var
  FileHandle : Integer;
  F:TextFile;
  sAdd:String;
  i:Integer;
begin
  ResetPath;
  if dlgOpenLST.Execute = TRUE then
  begin
  FileHandle := FileOpen(dlgOpenLST.FileName,fmOpenRead);
  if FileHandle > 0 then
  begin
    FileClose(FileHandle);
    AssignFile(F,dlgOpenLST.FileName);
    Reset(F);
    if lstData.Items.Count>0 then
      if Application.MessageBox('需要清除原有数据么',
        '清除数据',MB_YESNO or MB_ICONWARNING) = IDYES then
      lstData.Items.Clear;
    while not eof(F) do
    begin
      readln(F,sAdd);
      if ValidCheckLst(sAdd)=TRUE then
      begin
        lstData.Items.Add(sAdd);
        DnyCompute;
      end;
    end;
    ChkListBox;
    lstData.ItemIndex:=lstData.Items.Count-1;
    CloseFile(F);
  end;
  end;
end;

function TfrmMIB.ValidCheckLst(s: string):Boolean;
var
  iCheck,nDot,nNav :Integer;
  fRange : Double;
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
            ValidCheckLst := FALSE;
            MessageBox(0,
               '负号个数太多',
               '输入错误',
               MB_OK or MB_ICONSTOP);
            nNav:=0;
            exit;
          end;
          ValidCheckLst := TRUE;
       end
       else
       begin
          ValidCheckLst := FALSE;
          MessageBox(0,
             '负号位置不对',
             '输入错误',
             MB_OK or MB_ICONSTOP);
          exit;
       end;
      end;
      '0'..'9': ValidCheckLst := TRUE;
      '.' :
      begin
        nDot:=nDot+1;
        if nDot>1 then
        begin
          ValidCheckLst := FALSE;
          MessageBox(0,
               '小数点个数太多',
               '输入错误',
               MB_OK or MB_ICONSTOP);
          nDot:=0;
          exit;
        end
        else
          ValidCheckLst := TRUE;
      end;
    else
      begin
        ValidCheckLst := FALSE;
        MessageBox(0,
               '含有非法字符',
               '输入错误',
               MB_OK or MB_ICONSTOP);
        exit;
      end;
    end; // end case
  end;  // end for
  if s<>'' then
  begin
    fRange:=StrToFloat(s);
    fRange:=Round(fRange*1000)/1000;
    if (fRange>=-9999.999) and (fRange<=9999.999) then
      ValidCheckLst := TRUE
    else
      begin
        ValidCheckLst := FALSE;
        MessageBox(0,
               '数值超限(-9999.999至9999.999)',
               '输入错误',
               MB_OK or MB_ICONSTOP);
        exit;

      end;
  end
  else
    ValidCheckLst:=FALSE;
end;

procedure TfrmMIB.lstDataDragDrop(Sender, Source: TObject; X, Y: Integer);
begin
{  Y := Y div lstData.ItemHeight;
  if Y >= lstData.Count then    Y := lstData.Count-1;  lstData.Items.Move(lstData.ItemIndex, Y);}end;

procedure TfrmMIB.lstDataDragOver(Sender, Source: TObject; X, Y: Integer;
  State: TDragState; var Accept: Boolean);
begin
{  Accept:=TRUE; }
end;

procedure TfrmMIB.cmbSampleChange(Sender: TObject);
begin
  if cmbSample.ItemIndex=0 then
  begin
    label3.Visible := FALSE;
    label4.Visible := FALSE;
    cmbUp.Visible := FALSE;
    cmbDown.Visible := FALSE;
  end
  else
  begin
    label3.Visible := TRUE;
    label4.Visible := TRUE;
    cmbUp.Visible := TRUE;
    cmbDown.Visible := TRUE;
  end;
end;

procedure TfrmMIB.ResetPath;
var sApp:string;
begin
  sApp:=Application.ExeName;
  sApp:=ExtractFilePath(sApp);
  ChDir(sApp);
end;

procedure TfrmMIB.StopGet;
begin
  btnCCtl.Caption := '自动取数';
  btnCCtl.Hint := '自动取数';
  tmrGetData.Enabled := FALSE;
  bTimer := FALSE;
  iCTimer := 0;
end;

end.





