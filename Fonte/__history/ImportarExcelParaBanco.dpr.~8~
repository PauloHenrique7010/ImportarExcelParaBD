program ImportarExcelParaBanco;

uses
  Vcl.Forms,
  PrincipalForm in 'PrincipalForm.pas' {PrincipalFrm},
  ConfiguracoesForm in 'ConfiguracoesForm.pas' {ConfiguracoesFrm},
  ConexaoData in 'ConexaoData.pas' {ConexaoDtm: TDataModule},
  ConexaoForm in 'ConexaoForm.pas' {ConexaoFrm},
  ConfigurarTabelaForm in 'ConfigurarTabelaForm.pas' {ConfigurarTabelaFrm},
  NovaColunaForm in 'NovaColunaForm.pas' {NovaColunaFrm};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TConexaoDtm, ConexaoDtm);
  Application.CreateForm(TPrincipalFrm, PrincipalFrm);
  Application.CreateForm(TConfigurarTabelaFrm, ConfigurarTabelaFrm);
  Application.CreateForm(TNovaColunaFrm, NovaColunaFrm);
  Application.Run;
end.
