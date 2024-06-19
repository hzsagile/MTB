unit DISPLAY;

interface

uses
  Classes,Windows,SysUtils,StrUtils,Math;

type
  TDisplay = class(TThread)
  private
    { Private declarations }
    flgThreadExit : Boolean;
    strTemp, StrShow : String;
    procedure Receives;
    Procedure PositiveConvertion(s: String);
    Procedure NegtiveConvertion(s: String);
    procedure SetDisplay(n: Integer);

    function CalcPowerHex(Power: Integer): Integer;
    function CalcPowerBin(Power: Integer): Integer;
    function PowerXYHex(Y : Integer): Integer;
    function PowerXYBin(Y : Integer): Integer;
    function HextoBinStr(Hex : String): String;   
    function RevertBin(s: String): String;
   
  protected
    procedure Execute; override;
    procedure DoVisualDisplay;
  public
    constructor Create(CreateSuspended: Boolean);
  end;

var
   tDisp: TDisplay;

implementation

uses MIB;

{ Important: Methods and properties of objects in visual components can only be
  used in a method called using Synchronize, for example,

      Synchronize(UpdateCaption);

  and UpdateCaption could look like,

    procedure TDisplay.UpdateCaption;
    begin
      Form1.Caption := 'Updated in a thread';
    end; }

{ TDisplay }

constructor TDisplay.Create(CreateSuspended: Boolean);
begin
  flgThreadExit := FALSE;
  FreeOnTerminate:=True;
  inherited Create(CreateSuspended);
end;

procedure TDisplay.Execute;
begin
  { Place thread code here }
  Receives;
end;

procedure TDisplay.Receives;
var
  inBuff : array[0..2047] of Char;
  BytesRead, dwError : LongWORD;
  cs : TCOMSTAT;
  iStrIndexPos, iStart: Integer;
  nStrlen : Cardinal;
  StrCatmp, StrExtractNum, StrExtractSign:String;
  StrCatBuff : PChar;

  iCheck : Integer;
  bStrPass : BOOLEAN;
begin
  StrCatmp := '';
  bStrPass := TRUE;
  while (flgThreadExit = FALSE) do
  begin
    ClearCommError(frmMIB.hSerialPort, dwError, @cs);
    if cs.cbInQue>sizeof(inBuff) then
    begin
      PurgeComm(frmMIB.hSerialPort, PURGE_RXCLEAR);
      exit;
    end;
    ReadFile(frmMIB.hSerialPort, inBuff, cs.cbInQue, BytesRead, nil);
    strTemp:=Copy(inBuff, 1, cs.cbInQue);
    nStrlen := Strlen(PChar(StrCatmp));
    if nStrlen<=16 then
    begin
      GetMem(StrCatBuff,Length(StrCatmp) + Length(strTemp) + 1);
      StrCopy(StrCatBuff, PChar(StrCatmp));
      StrCat(StrCatBuff, PChar(strTemp));
      StrCatmp := StrCatBuff;
      FreeMem(StrCatBuff);
    end
    else if AnsiStrComp(AnsiStrScan(PChar(strTemp),'='),'=') =0 then
    begin
      iStrIndexPos := pos('=',StrCatmp);
      iStart := iStrIndexPos + 1;
      StrExtractSign := MidStr(StrCatmp, iStart, 2);
      iStart := iStrIndexPos + 3;
      StrExtractNum := MidStr(StrCatmp, iStart, 6);
      for iCheck:=1 to length(StrExtractNum) do
      begin
        case StrExtractNum[iCheck] of
          '0'..'9': bStrPass := TRUE;
          'A'..'F': bStrPass := TRUE;
        else
          begin
            bStrPass := FALSE;
            StrExtractNum:='';
            StrCatmp:='';
            break;
          end;
        end; // end case
      end;
      if bStrPass = FALSE then continue;
      if AnsiStrComp(PChar(strExtractSign), PChar('00'))= 0 then
      begin
        PositiveConvertion(StrExtractNum);
      end //end if
      else if AnsiStrComp(PChar(strExtractSign), PChar('FF'))= 0 then
      begin
        NegtiveConvertion(StrExtractNum);
      end;
      frmMIB.StrGetShow := StrShow;
      StrCatmp := '';
    end;
    DoVisualDisplay;
  end;
end;

procedure TDisplay.DoVisualDisplay;
var iStrlen: Integer;
begin
  iStrlen := strlen(PChar(strShow));
  SetDisplay(iStrlen);
  frmMIB.panDisplay.Caption := strShow;
  sleep(0);
end;

procedure TDisplay.SetDisplay(n: Integer);
begin
   case n of
    5:frmMIB.panDisplay.Font.Size:=146;

    6:frmMIB.panDisplay.Font.Size:=123;

    7:frmMIB.panDisplay.Font.Size:=105;

    8:frmMIB.panDisplay.Font.Size:=91;

    9:frmMIB.panDisplay.Font.Size:=81;

    end;
end;


function TDisplay.CalcPowerHex(Power : Integer): Integer;
begin
  case Power of
    0:
    CalcPowerHex := 1;
    1:
    CalcPowerHex := 16;
  else
    CalcPowerHex := PowerXYHex(Power);
  end;
end;

function TDisplay.PowerXYHex(Y : Integer): Integer;
var
  i, nTmp: Integer;
begin
  nTmp :=1;
  if Y>=2 then
    for i:=1 to Y do
      nTmp := nTmp*16;
  PowerXYHex := nTmp;
end;

Procedure TDisplay.PositiveConvertion(s: string);
var
  fShowNum : Single;
  fShowNumInch : Double;
  nDecTmp, nDecNum, iIndex : Integer;
Begin
  nDectmp := 0;
  nDecNum := 0;
  for iIndex := 1 to 6 do
  begin
  case s[iIndex] of
    '0':
      nDectmp := 0;
    '1':
      nDectmp := CalcPowerHex(6-iIndex);
    '2':
      nDectmp := 2*CalcPowerHex(6-iIndex);
    '3':
      nDectmp := 3*CalcPowerHex(6-iIndex);
    '4':
      nDectmp := 4*CalcPowerHex(6-iIndex);
    '5':
      nDectmp := 5*CalcPowerHex(6-iIndex);
    '6':
      nDectmp := 6*CalcPowerHex(6-iIndex);
    '7':
      nDectmp := 7*CalcPowerHex(6-iIndex);
    '8':
      nDectmp := 8*CalcPowerHex(6-iIndex);
    '9':
      nDectmp := 9*CalcPowerHex(6-iIndex);
    'A':
      nDectmp := 10*CalcPowerHex(6-iIndex);
    'B':
      nDectmp := 11*CalcPowerHex(6-iIndex);
    'C':
      nDectmp := 12*CalcPowerHex(6-iIndex);
    'D':
      nDectmp := 13*CalcPowerHex(6-iIndex);
    'E':
      nDectmp := 14*CalcPowerHex(6-iIndex);
    'F':
      nDectmp := 15*CalcPowerHex(6-iIndex);
  end; //end case
  nDecNum := nDecNum + nDectmp;
  nDectmp := 0;
  end;//end for
  if frmMIB.bInch = TRUE then
  begin
    fShowNumInch := (nDecNum/25.4)*10;
    fShowNumInch := Round(fShowNumInch);
    fShowNumInch := fShowNumInch/10000;
    StrShow := FloattoStrF(fShowNumInch,ffFixed,7,4);
  end
  else
  begin
  fShowNum := nDecNum/1000;
  StrShow := FloattoStrF(fShowNum,ffFixed,7,3);
  end;
end;

Procedure TDisplay.NegtiveConvertion(s: string);
var
  strBinTmp : String;
  fShowNum : Single;
  fShowNumInch : Double;
  nDecTmp, nDecNum, iIndex : Integer;
begin
  strBinTmp := HextoBinStr(s);
  strBintmp := RevertBin(strBintmp);
  nDectmp := 0;
  nDecNum := 0;
  for iIndex := 1 to 24 do
  begin
  case strBinTmp[iIndex] of
    '0':
      nDectmp := 0;
    '1':
      nDectmp := CalcPowerBin(24-iIndex);
  end;
  nDecNum := nDecNum + nDectmp;
  nDectmp := 0;
  end;//end for
  if frmMIB.bInch = TRUE then
  begin
    fShowNumInch := ((nDecNum+1)/25.4)*10;
    fShowNumInch := Round(fShowNumInch);
    fShowNumInch := fShowNumInch/10000;
    StrShow := '-'+FloattoStrF(fShowNumInch,ffFixed,7,4);
  end
  else
  begin
    fShowNum := (nDecNum+1)/1000;
    StrShow := '-'+FloattoStrF(fShowNum,ffFixed,7,3);
  end;
  strBinTmp :=''
end;

function TDisplay.HextoBinStr(Hex:string):string;
const
    BOX: array [0..15] of string =
         ('0000','0001','0010','0011',
          '0100','0101','0110','0111',
          '1000','1001','1010','1011',
          '1100','1101','1110','1111');
var
  i:integer;
begin
  for i:=Length(Hex) downto 1 do
    Result:=BOX[StrToInt('$'+Hex[i])]+Result;
end;

function TDisplay.RevertBin(s: String): string;
var
  i:integer;
begin
  for i:=Length(s) downto 1 do
  case s[i] of
    '0':
      s[i] := '1';
    '1':
      s[i] := '0';
  end;
  RevertBin := s;
end;

function TDisplay.CalcPowerBin(Power : Integer): Integer;
begin
  case Power of
    0:
    CalcPowerBin := 1;
    1:
    CalcPowerBin := 2;
  else
    CalcPowerBin := PowerXYBin(Power);
  end;
end;

function TDisplay.PowerXYBin(Y : Integer): Integer;
var
  i, nTmp: Integer;
begin
  nTmp :=1;
  if Y>=2 then
    for i:=1 to Y do
      nTmp := nTmp*2;
  PowerXYBin := nTmp;
end;

end.
