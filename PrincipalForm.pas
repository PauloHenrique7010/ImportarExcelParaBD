unit PrincipalForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, System.Actions, Vcl.ActnList,
  Vcl.StdCtrls, Vcl.Buttons, IDETheme.ActnCtrls, Vcl.ActnMan;

type
  TPrincipalFrm = class(TForm)
    ActionManager1: TActionManager;
    actFechar: TAction;
    btnFechar: TBitBtn;
    actConfiguracoes: TAction;
    btnConfiguracao: TBitBtn;
    procedure actFecharExecute(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  PrincipalFrm: TPrincipalFrm;

implementation

{$R *.dfm}

procedure TPrincipalFrm.actFecharExecute(Sender: TObject);
begin
  Close;
end;

end.
