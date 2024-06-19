unit About;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, OleCtrls, SHDocVw, StdCtrls;

type
  TfrmAbout = class(TForm)
    btnOK: TButton;
    Label1: TLabel;
    Label3: TLabel;
    Label2: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    procedure Label5Click(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure Label5MouseEnter(Sender: TObject);
    procedure Label5MouseLeave(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmAbout: TfrmAbout;

implementation

{$R *.dfm}

function ShellExecute(HWnd: Integer; lpOperation, lpFile, lpParameters, lpDirectory :PChar; nShowCmd: Integer): Integer; stdcall; external 'shell32.dll' name 'ShellExecuteA';

procedure TfrmAbout.Label5Click(Sender: TObject);
var
  URL: string;
begin
  URL:='http://www.camagile.com/index.html';
  ShellExecute(0,
                nil,
                PChar(URL),
                nil,
                nil, SW_SHOWMAXIMIZED);
  //WebBrowser.Navigate(URL);
end;

procedure TfrmAbout.btnOKClick(Sender: TObject);
begin
  frmAbout.Close;
end;

procedure TfrmAbout.Label5MouseEnter(Sender: TObject);
var
 fs: TFontStyle;
begin
  //label5.Color := clYellow;
  label5.Cursor := crHandPoint;
  label5.Font.Style := [fsUnderline];
end;

procedure TfrmAbout.Label5MouseLeave(Sender: TObject);
begin
  label5.Cursor := crDefault;
  label5.Font.Style := [];
end;

end.
