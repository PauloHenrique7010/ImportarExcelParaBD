unit ConexaoData;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.MySQL,
  FireDAC.Phys.MySQLDef, FireDAC.VCLUI.Wait, Data.DB, FireDAC.Comp.Client,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,
  FireDAC.Comp.DataSet;

type
  TConexaoDtm = class(TDataModule)
    Conexao: TFDConnection;
    qry: TFDQuery;
  private
    { Private declarations }
  public
    function Conectar:boolean;
  end;

var
  ConexaoDtm: TConexaoDtm;

implementation

Uses Inifiles, Vcl.Forms, Winapi.Windows, PrincipalForm;

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TConexaoDtm }

function TConexaoDtm.Conectar: boolean;
var
  conexaoIni : TIniFile;
begin
  result := False;

  conexaoIni := TIniFile.Create(PrincipalFrm.GcaminhoConexaoIni);
  try
    ConexaoDtm.Conexao.Connected := False;
    ConexaoDtm.Conexao.Params.Values['DriverID']  := 'MySQL';
    ConexaoDtm.Conexao.Params.Values['Server']    := conexaoIni.ReadString('Conexao', 'Server', EmptyStr);
    ConexaoDtm.Conexao.Params.Values['Database']  := conexaoIni.ReadString('Conexao', 'Database', EmptyStr);
    ConexaoDtm.Conexao.Params.Values['User_name'] := conexaoIni.ReadString('Conexao', 'User_name', EmptyStr);
    ConexaoDtm.Conexao.Params.Values['Password']  := conexaoIni.ReadString('Conexao', 'Password', EmptyStr);
    ConexaoDtm.Conexao.Params.Values['Port']      := conexaoIni.ReadString('Conexao', 'Port', EmptyStr);
    ConexaoDtm.Conexao.Connected := True;

    result := True;
  except
    on e:exception do
      Application.messagebox(Pchar('Não foi possível conectar, ocorreu o seguinte erro: '+#13+e.Message),'CONECTAR',MB_ICONERROR);
  end;
  conexaoIni.Free;
end;

end.
