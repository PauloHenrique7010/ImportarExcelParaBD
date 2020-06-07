unit NovaColunaForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, System.Actions,
  Vcl.ActnList, Vcl.Buttons;

type
  TNovaColunaFrm = class(TForm)
    btnFechar: TBitBtn;
    ActionList1: TActionList;
    actFechar: TAction;
    actConfirmar: TAction;
    edtNomeColuna: TEdit;
    btnConfirmar: TBitBtn;
    procedure actFecharExecute(Sender: TObject);
    procedure actConfirmarExecute(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  NovaColunaFrm: TNovaColunaFrm;

implementation

{$R *.dfm}

procedure TNovaColunaFrm.actConfirmarExecute(Sender: TObject);
begin
  modalResult := mrOk;
end;

procedure TNovaColunaFrm.actFecharExecute(Sender: TObject);
begin
  Close;
End;

end.
