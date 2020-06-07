unit PrincipalForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, System.Actions, Vcl.ActnList,
  Vcl.StdCtrls, Vcl.Buttons, Vcl.ActnMan, comobj, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TPrincipalFrm = class(TForm)
    btnFechar: TBitBtn;
    btnConfiguracao: TBitBtn;
    edtCaminhoExcel: TEdit;
    btnPegarExcel: TBitBtn;
    OpenDialog1: TOpenDialog;
    ActionList1: TActionList;
    actFechar: TAction;
    actPegarExcel: TAction;
    actConfiguracoes: TAction;
    grbOpcoes: TGroupBox;
    rdbZerar: TRadioButton;
    rdbAdicionar: TRadioButton;
    actLimparCaminho: TAction;
    btnLimparCaminho: TBitBtn;
    actImportar: TAction;
    btnImportar: TBitBtn;
    ListBox1: TListBox;
    qryImportar: TFDQuery;
    cmdImportar: TFDCommand;
    procedure actFecharExecute(Sender: TObject);
    procedure actPegarExcelExecute(Sender: TObject);
    procedure actConfiguracoesExecute(Sender: TObject);
    procedure rdbZerarClick(Sender: TObject);
    procedure rdbAdicionarClick(Sender: TObject);
    procedure actLimparCaminhoExecute(Sender: TObject);
    procedure actImportarExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    lColunaNome, lColunaTipo : TStringList;
    function importarExcel:boolean;
    procedure carregarColunasBanco;
  public
    GcaminhoConexaoIni : string;
    caminhoEXE:string;
  end;

var
  PrincipalFrm: TPrincipalFrm;

implementation

{$R *.dfm}

uses ConfiguracoesForm, ConexaoData, ConexaoForm;

procedure TPrincipalFrm.actConfiguracoesExecute(Sender: TObject);
begin
  Application.CreateForm(TConfiguracoesFrm, ConfiguracoesFrm);
  try
    ConfiguracoesFrm.Iniciar;
    ConfiguracoesFrm.ShowModal;
  finally
    FreeAndNil(ConfiguracoesFrm);
  end;
end;

procedure TPrincipalFrm.actFecharExecute(Sender: TObject);
begin
  Close;
end;

procedure TPrincipalFrm.actImportarExecute(Sender: TObject);
var
  podeImportar  : boolean;
  msgAviso      : string;
begin
  msgAviso      := '';
  podeImportar  := True;

  if (edtCaminhoExcel.Text = '') then
  begin
    msgAviso      := msgAviso + 'Informe o arquivo excel a ser importado';
    podeImportar  := False;
  end;

  if (podeImportar = false) then
    Application.MessageBox(Pchar(msgAviso), 'IMPORTAR', MB_ICONWARNING)
  else
  begin
    if (importarExcel) then
      Application.MessageBox('Arquivos importados!', 'IMPORTAR', MB_ICONINFORMATION);
  end;
end;

procedure TPrincipalFrm.actLimparCaminhoExecute(Sender: TObject);
begin
  edtCaminhoExcel.Clear;
end;

procedure TPrincipalFrm.actPegarExcelExecute(Sender: TObject);
begin
  if (OpenDialog1.Execute) then
  begin
    edtCaminhoExcel.Text := OpenDialog1.FileName;
  end;
end;

procedure TPrincipalFrm.carregarColunasBanco;
var
  arq: TextFile; { declarando a vari�vel "arq" do tipo arquivo texto }
  linha: string;
  caminho : string;
  nomeColuna, tipoColuna : string;
  lista : TStringList;
begin
  caminho := CaminhoEXE+'\colunas.txt';
  lista := Tstringlist.Create;
  AssignFile(arq, caminho);

  {$I-}         // desativa a diretiva de Input
  Reset(arq);   // [ 3 ] Abre o arquivo texto para leitura
  {$I+}         // ativa a diretiva de Input

  if (IOResult <> 0) then
    ShowMessage('n�o foi possivel abrir')
  else
  begin
    while (not eof(arq)) do
    begin
      readln(arq, linha);
      lista.Delimiter := ' ';
      lista.DelimitedText := linha;
      lColunaNome.Add(lista.Strings[0]);
      lColunaTipo.Add(lista.Strings[1]);
    end;

    CloseFile(arq);
  end;
end;

procedure TPrincipalFrm.FormCreate(Sender: TObject);
begin
  GcaminhoConexaoIni := ExtractFilePath(ParamStr(0)) + 'Conexao.ini';
  caminhoEXE := ExtractFilePath(ParamStr(0));
  if (FileExists(PrincipalFrm.GcaminhoConexaoIni) = false) then
  begin
    if (Application.messagebox('Conex�o n�o foi configurada ou arquivo n�o '+'encontrado, Deseja configurar agora?','CONECTAR',mb_YesNo+mb_IconInformation+mb_DefButton2) = IDYES) then
    begin
      Application.CreateForm(TConexaoFrm, ConexaoFrm);
      try
        ConexaoFrm.ShowModal;
      finally
        FreeAndNil(ConexaoFrm);
      end;
    end;
  end
  else
  begin
    if (ConexaoDtm.Conectar = false) then
      ShowMessage('N�o foi poss�vel conectar!');
  end;

  if (ConexaoDtm.Conexao.Connected = false) then
    Application.Terminate;


  lColunaNome := TStringList.Create;
  lColunaTipo := TStringList.Create;
  carregarColunasBanco;
end;

function TPrincipalFrm.importarExcel: boolean;
var
   excel, sheet: OLEVariant;
   totalLinha, totalColuna: Integer;
   cont : integer;
   nome : string;
   matriz : array of array of string;

   colunasSQL : string;
   valuesSQL : string;
  I: Integer;
  qryImportar : TFDQuery;
begin
  Result := False;
  // Cria Excel- OLE Object
  excel := CreateOleObject('Excel.Application');
  qryImportar := TFDQuery.Create(nil);
  try
    Excel.WorkBooks.Open(OpenDialog1.FileName);
    Excel.Visible := false;
    Sheet := Excel.Workbooks[1].WorkSheets[1];

    // Pegar o n�mero da �ltima linha
    totalLinha := excel.ActiveCell.Row;
    // Pegar o n�mero da �ltima coluna
    totalColuna := excel.ActiveCell.Column;
    //for linha := 2 to x do
    totalLinha := 2;

    colunasSQL := '';
    for I := 0 to lColunaNome.Count-1 do
    begin
      if (colunasSQL <> '') then
        colunasSQL := colunasSQL + ', ';
      colunasSQL := colunasSQL + lColunaNome.Strings[I];
    end;
    colunasSQL := '('+colunasSQL+')';


    qryImportar.Close;

    for cont := 2 to (totalLinha+1) do
    begin
      for I := 1 to lColunaNome.Count do
      begin
        nome := Sheet.Cells[cont, i];



      end;
      
      //coluna2 Sheet.Cells[cont, 2].value;

    end;
















    SetLength(Matriz,totalLinha,totalColuna);
    for cont := 2 to (totalLinha+1) do
    begin
      //linha, coluna
      matriz[cont-2,0] := Sheet.Cells[cont, 1].value;
      matriz[cont-2,1] := Sheet.Cells[cont, 2].value;
    end;

    for cont := 2 to (totalLinha+1) do
    begin
      ListBox1.Items.Add(Matriz[cont-2,0]+'-'+Matriz[cont-2,1]);
    end;
  finally
    excel.quit;
  end;
end;

procedure TPrincipalFrm.rdbAdicionarClick(Sender: TObject);
begin
  if (rdbAdicionar.Checked) then
    rdbZerar.Checked := False;
end;

procedure TPrincipalFrm.rdbZerarClick(Sender: TObject);
begin
  if (rdbZerar.Checked) then
    rdbAdicionar.Checked := False;

end;

end.
