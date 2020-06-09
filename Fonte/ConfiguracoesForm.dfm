object ConfiguracoesFrm: TConfiguracoesFrm
  Left = 0
  Top = 0
  Caption = 'Configura'#231#245'es'
  ClientHeight = 118
  ClientWidth = 395
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  DesignSize = (
    395
    118)
  PixelsPerInch = 96
  TextHeight = 13
  object btnFechar: TBitBtn
    Left = 287
    Top = 85
    Width = 100
    Height = 25
    Action = actFechar
    Anchors = [akRight, akBottom]
    Caption = 'FECHAR(ESC)'
    TabOrder = 4
  end
  object edtNomeDatabase: TEdit
    Left = 8
    Top = 39
    Width = 197
    Height = 21
    TabOrder = 1
    TextHint = 'Digite o nome do banco de dados'
  end
  object btnCriar: TBitBtn
    Left = 211
    Top = 37
    Width = 85
    Height = 25
    Action = actCriarDatabase
    Caption = 'CRIAR'
    TabOrder = 2
  end
  object btnConfigurarConexao: TBitBtn
    Left = 8
    Top = 8
    Width = 137
    Height = 25
    Action = actConfigurarBD
    Caption = 'CONFIGURAR CONEX'#195'O'
    TabOrder = 0
  end
  object btnConfigurarTabela: TBitBtn
    Left = 302
    Top = 37
    Width = 85
    Height = 25
    Action = actConfigurarTabela
    Caption = 'CONFIGURAR'
    TabOrder = 3
  end
  object ActionList1: TActionList
    object actFechar: TAction
      Caption = 'FECHAR(ESC)'
      ShortCut = 27
      OnExecute = actFecharExecute
    end
    object actCriarDatabase: TAction
      Caption = 'CRIAR'
      OnExecute = actCriarDatabaseExecute
    end
    object actVerificarDatabase: TAction
      Caption = 'VERIFICAR SE EXISTE'
      OnExecute = actVerificarDatabaseExecute
    end
    object actConfigurarBD: TAction
      Caption = 'CONFIGURAR CONEX'#195'O'
      OnExecute = actConfigurarBDExecute
    end
    object actConfigurarTabela: TAction
      Caption = 'CONFIGURAR'
      OnExecute = actConfigurarTabelaExecute
    end
  end
end
