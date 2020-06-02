object PrincipalFrm: TPrincipalFrm
  Left = 0
  Top = 0
  Caption = 'IMPORTAR ARQUIVO EXCEL PARA BANCO DE DADOS'
  ClientHeight = 184
  ClientWidth = 467
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  DesignSize = (
    467
    184)
  PixelsPerInch = 96
  TextHeight = 13
  object btnFechar: TBitBtn
    Left = 359
    Top = 151
    Width = 100
    Height = 25
    Action = actFechar
    Anchors = [akRight, akBottom]
    Caption = 'FECHAR(ESC)'
    TabOrder = 0
    ExplicitLeft = 457
    ExplicitTop = 371
  end
  object btnConfiguracao: TBitBtn
    Left = 359
    Top = 120
    Width = 100
    Height = 25
    Action = actConfiguracoes
    Anchors = [akRight, akBottom]
    Caption = 'CONFIGURA'#199#213'ES'
    TabOrder = 1
  end
  object ActionManager1: TActionManager
    Left = 8
    StyleName = 'IDE Theme Style'
    object actFechar: TAction
      Caption = 'FECHAR(ESC)'
      ShortCut = 27
      OnExecute = actFecharExecute
    end
    object actConfiguracoes: TAction
      Caption = 'Configura'#231#245'es'
    end
  end
end
