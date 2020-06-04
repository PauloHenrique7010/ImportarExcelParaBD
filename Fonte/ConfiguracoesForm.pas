unit ConfiguracoesForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons,
  System.Actions, Vcl.ActnList, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.Comp.Client, FireDAC.DApt,
  Data.DB, FireDAC.Comp.DataSet;

type
  TConfiguracoesFrm = class(TForm)
    ActionList1: TActionList;
    btnFechar: TBitBtn;
    actFechar: TAction;
    btnVerificarDatabase: TBitBtn;
    edtNomeDatabase: TEdit;
    actCriarDatabase: TAction;
    actVerificarDatabase: TAction;
    BitBtn1: TBitBtn;
    btnConfigurarConexao: TBitBtn;
    actConfigurarBD: TAction;
    procedure actFecharExecute(Sender: TObject);
    procedure actVerificarDatabaseExecute(Sender: TObject);
    procedure actCriarDatabaseExecute(Sender: TObject);
    procedure actConfigurarBDExecute(Sender: TObject);
  private
    function existeBancoDeDados:boolean;
    function verificarPendencia:boolean;
  public
    { Public declarations }
  end;

var
  ConfiguracoesFrm: TConfiguracoesFrm;

implementation

{$R *.dfm}

uses ConexaoData, ConexaoForm;

procedure TConfiguracoesFrm.actConfigurarBDExecute(Sender: TObject);
begin
  Application.CreateForm(TConexaoFrm, ConexaoFrm);
  try
    ConexaoFrm.Iniciar;
    ConexaoFrm.ShowModal;
  finally
    FreeAndNil(ConexaoFrm);
  end;
end;

procedure TConfiguracoesFrm.actCriarDatabaseExecute(Sender: TObject);
var
  cmd : TFDCommand;
begin
  if (verificarPendencia) then
  begin
    if (existeBancoDeDados) then
      Application.MessageBox('J� existe um banco de dados com este nome!','Verificar',MB_ICONWARNING)
    else
    begin
      cmd := TFDCommand.Create(nil);
      try
        cmd.Connection := ConexaoDtm.Conexao;

        cmd.CommandText.Text := 'CREATE DATABASE IF NOT EXISTS '+edtNomeDatabase.Text;
        cmd.Execute();
      finally
        cmd.Free;
      end;
    end;
  end;
end;

procedure TConfiguracoesFrm.actFecharExecute(Sender: TObject);
begin
  Close;
end;

procedure TConfiguracoesFrm.actVerificarDatabaseExecute(Sender: TObject);
begin
  if (verificarPendencia) then
  begin
    if (existeBancoDeDados) then
      Application.MessageBox('Banco de dados encontrado','Verificar',MB_ICONWARNING)
    else
      Application.MessageBox('N�o existe o banco de dados informado','Verificar',MB_ICONWARNING);
  end;
end;

function TConfiguracoesFrm.existeBancoDeDados: boolean;
var
  qry : TFDQuery;
begin
  result := False;
  qry := TFDQuery.Create(nil);
  try
    qry.Connection := ConexaoDtm.Conexao;

    qry.Close;
    qry.SQL.Clear;
    qry.SQL.Add('SELECT SCHEMA_NAME FROM INFORMATION_SCHEMA.SCHEMATA '+
                'WHERE SCHEMA_NAME = "'+edtNomeDatabase.Text+'"');
    qry.Open();
    if (qry.RecordCount > 0) then
      result := True;
  finally
    qry.Free;
  end;
end;

function TConfiguracoesFrm.verificarPendencia: boolean;
var
  opOK  : boolean;
  msgAviso  : string;
begin
  msgAviso      := '';
  opOK  := True;

  if (edtNomeDatabase.Text = '') then
  begin
    msgAviso      := msgAviso + 'Informe o nome do banco de dados';
    opOK  := False;
  end;

  if (opOK = false) then
    Application.MessageBox(Pchar(msgAviso), 'IMPORTAR', MB_ICONWARNING);

  result := opOK;
end;

end.
