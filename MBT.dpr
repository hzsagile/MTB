program MBT;

uses
  Forms,
  MIB in 'MIB.pas' {frmMIB},
  DISPLAY in 'DISPLAY.pas',
  SysSet in 'SysSet.pas' {frmSysSet},
  About in 'About.pas' {frmAbout},
  Sample in 'Sample.pas' {frmSample};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmMIB, frmMIB);
  Application.CreateForm(TfrmSysSet, frmSysSet);
  Application.CreateForm(TfrmAbout, frmAbout);
  Application.CreateForm(TfrmSample, frmSample);
  Application.Run;

end.
