program ImportarExcelParaBanco;

uses
  Vcl.Forms,
  PrincipalForm in 'PrincipalForm.pas' {PrincipalFrm},
  ConfiguracoesForm in 'ConfiguracoesForm.pas' {ConfiguracoesFrm},
  ConexaoData in 'ConexaoData.pas' {ConexaoDtm: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TPrincipalFrm, PrincipalFrm);
  Application.CreateForm(TConfiguracoesFrm, ConfiguracoesFrm);
  Application.CreateForm(TConexaoDtm, ConexaoDtm);
  Application.Run;
end.
