unit ConexaoForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, System.Actions,
  Vcl.ActnList, Vcl.Buttons;

type
  TConexaoFrm = class(TForm)
    Label1: TLabel;
    edtHost: TEdit;
    Label2: TLabel;
    edtLogin: TEdit;
    Label3: TLabel;
    edtPorta: TEdit;
    Label4: TLabel;
    edtSenha: TEdit;
    btnFechar: TBitBtn;
    ActionList1: TActionList;
    actFechar: TAction;
    actConectar: TAction;
    btnConectar: TBitBtn;
    Label5: TLabel;
    edtBD: TEdit;
    procedure actFecharExecute(Sender: TObject);
    procedure actConectarExecute(Sender: TObject);
  private
    { Private declarations }
  public
    procedure Iniciar;

  end;

var
  ConexaoFrm: TConexaoFrm;

implementation

{$R *.dfm}

uses ConexaoData, IniFiles, PrincipalForm;

procedure TConexaoFrm.actConectarExecute(Sender: TObject);
var
  conexaoIni : Tinifile;
begin
  try
    ConexaoDtm.Conexao.Connected := False;
    ConexaoDtm.Conexao.Params.Values['DriverID']  := 'MySQL';
    ConexaoDtm.Conexao.Params.Values['Server']    := edtHost.Text;
    ConexaoDtm.Conexao.Params.Values['Database']  := edtBD.Text;
    ConexaoDtm.Conexao.Params.Values['User_name'] := edtLogin.Text;
    ConexaoDtm.Conexao.Params.Values['Password']  := edtSenha.Text;
    ConexaoDtm.Conexao.Params.Values['Port']      := edtPorta.Text;
    ConexaoDtm.Conexao.Connected := True;
    Application.MessageBox('Conectado com sucesso! ser� criado um arquivo com as configura��es para conex�o','CONEX�O',MB_ICONWARNING);

    conexaoIni := TIniFile.Create(PrincipalFrm.GcaminhoConexaoIni);

    conexaoIni.WriteString('Conexao', 'User_name',edtLogin.Text);
    conexaoIni.WriteString('Conexao', 'Password', edtSenha.Text);
    conexaoIni.WriteString('Conexao', 'DriverID', 'MySQL');
    conexaoIni.WriteString('Conexao', 'Server', edtHost.Text);
    conexaoIni.WriteString('Conexao', 'Database', edtBD.Text);
    conexaoIni.WriteString('Conexao', 'Port', edtPorta.Text);

    conexaoIni.Free;
    Close;
    //salva um arquivo com as conf de conexao
  except
    Application.MessageBox('N�o foi poss�vel conectar ao banco de dados informado','CONECTAR',MB_ICONERROR);
  end;

end;

procedure TConexaoFrm.actFecharExecute(Sender: TObject);
begin
  Close;
end;

procedure TConexaoFrm.Iniciar;
begin
  edtHost.Text  := ConexaoDtm.Conexao.Params.Values['Server'];
  edtLogin.Text := ConexaoDtm.Conexao.Params.Values['User_name'];
  edtSenha.Text := ConexaoDtm.Conexao.Params.Values['Password'];
  edtBD.Text    := ConexaoDtm.Conexao.Params.Values['Database'];
  edtPorta.Text := ConexaoDtm.Conexao.Params.Values['Port'];
end;

end.
