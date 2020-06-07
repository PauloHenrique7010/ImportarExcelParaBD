unit ConfigurarTabelaForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, System.Actions, Vcl.ActnList,
  Vcl.StdCtrls, Vcl.Buttons, Vcl.Grids, Data.DB, Vcl.DBGrids;

type
  TConfigurarTabelaFrm = class(TForm)
    btnFechar: TBitBtn;
    ActionList1: TActionList;
    actFechar: TAction;
    btnAdicionar: TBitBtn;
    actAdicionarColuna: TAction;
    lstColunas: TListBox;
    procedure actFecharExecute(Sender: TObject);
    procedure actAdicionarColunaExecute(Sender: TObject);
  private
    { Private declarations }
  public
    procedure iniciar;
  end;

var
  ConfigurarTabelaFrm: TConfigurarTabelaFrm;

implementation

uses
  FireDAC.Comp.Client, ConexaoData, NovaColunaForm;

{$R *.dfm}

procedure TConfigurarTabelaFrm.actAdicionarColunaExecute(Sender: TObject);
var
  cmd : TFDCommand;
begin
  Application.CreateForm(TNovaColunaFrm, NovaColunaFrm);
  try
    if (NovaColunaFrm.ShowModal = mrOk) then
    begin
      try
        cmd := TFDCommand.Create(nil);

        cmd.Connection := ConexaoDtm.Conexao;
        cmd.CommandText.Text := 'ALTER TABLE raspagem_excel add column '+NovaColunaFrm.edtNomeColuna.Text+';';
        cmd.Execute();
        cmd.Free;

        iniciar;
      except
        on e:exception do
          Application.MessageBox(Pchar('OCORREU O SEGUINTE ERRO: '+#13+e.Message),'ADICIONAR',MB_ICONERROR);
      end;
    end;
  finally
    FreeAndNil(NovaColunaFrm);
  end;
end;

procedure TConfigurarTabelaFrm.actFecharExecute(Sender: TObject);
begin
  Close;
end;

procedure TConfigurarTabelaFrm.iniciar;
var
  qryColunas : TFDQuery;
begin
  lstColunas.Clear;
  qryColunas := TFDQuery.Create(nil);
  try
    qryColunas.Connection := ConexaoDtm.Conexao;

    qryColunas.Close;
    qryColunas.SQL.Clear;
    qryColunas.SQL.Add('SHOW COLUMNS FROM raspagem_excel');
    qryColunas.Open();
    if (qryColunas.RecordCount > 0) then
    begin
      qryColunas.First;
      while not (qryColunas.Eof) do
      begin
        lstColunas.Items.Add(qryColunas.Fields[0].AsString);
        qryColunas.Next;
      end;
    end;
  finally
    qryColunas.Free;
  end;
end;

end.
