object ConfigurarTabelaFrm: TConfigurarTabelaFrm
  Left = 0
  Top = 0
  Caption = 'CONFIGURAR TABELA'
  ClientHeight = 299
  ClientWidth = 280
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  DesignSize = (
    280
    299)
  PixelsPerInch = 96
  TextHeight = 13
  object btnFechar: TBitBtn
    Left = 172
    Top = 266
    Width = 100
    Height = 25
    Action = actFechar
    Anchors = [akRight, akBottom]
    Caption = 'FECHAR(ESC)'
    TabOrder = 3
    ExplicitLeft = 510
    ExplicitTop = 382
  end
  object btnAdicionar: TBitBtn
    Left = 172
    Top = 204
    Width = 100
    Height = 25
    Action = actAdicionarColuna
    Anchors = [akRight, akBottom]
    Caption = 'ADICIONAR'
    TabOrder = 1
  end
  object lstColunas: TListBox
    Left = 16
    Top = 24
    Width = 137
    Height = 265
    ItemHeight = 13
    TabOrder = 0
  end
  object btnExcluir: TBitBtn
    Left = 172
    Top = 235
    Width = 100
    Height = 25
    Action = actExcluir
    Anchors = [akRight, akBottom]
    Caption = 'EXCLUIR'
    TabOrder = 2
  end
  object ActionList1: TActionList
    object actFechar: TAction
      Caption = 'FECHAR(ESC)'
      ShortCut = 27
      OnExecute = actFecharExecute
    end
    object actAdicionarColuna: TAction
      Caption = 'ADICIONAR'
      OnExecute = actAdicionarColunaExecute
    end
    object actExcluir: TAction
      Caption = 'EXCLUIR'
      OnExecute = actExcluirExecute
    end
  end
  object cmd: TFDCommand
    Connection = ConexaoDtm.Conexao
    Left = 32
  end
end
