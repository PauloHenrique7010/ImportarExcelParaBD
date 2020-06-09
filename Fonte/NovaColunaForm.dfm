object NovaColunaFrm: TNovaColunaFrm
  Left = 0
  Top = 0
  Caption = 'NOVA COLUNA'
  ClientHeight = 129
  ClientWidth = 229
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  DesignSize = (
    229
    129)
  PixelsPerInch = 96
  TextHeight = 13
  object btnFechar: TBitBtn
    Left = 121
    Top = 96
    Width = 100
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'FECHAR(ESC)'
    TabOrder = 2
  end
  object edtNomeColuna: TEdit
    Left = 24
    Top = 31
    Width = 197
    Height = 21
    TabOrder = 0
    TextHint = 'nome varchar(50) not null'
  end
  object btnConfirmar: TBitBtn
    Left = 121
    Top = 65
    Width = 100
    Height = 25
    Action = actConfirmar
    Anchors = [akRight, akBottom]
    Caption = 'CONFIRMAR'
    TabOrder = 1
  end
  object ActionList1: TActionList
    object actFechar: TAction
      Caption = 'FECHAR(ESC)'
      ShortCut = 27
      OnExecute = actFecharExecute
    end
    object actConfirmar: TAction
      Caption = 'CONFIRMAR'
      OnExecute = actConfirmarExecute
    end
  end
end
