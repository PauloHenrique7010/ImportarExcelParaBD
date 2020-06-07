object ConexaoDtm: TConexaoDtm
  OldCreateOrder = False
  Height = 221
  Width = 358
  object Conexao: TFDConnection
    Params.Strings = (
      'User_Name=root'
      'Password=1234'
      'DriverID=MySQL')
    LoginPrompt = False
    Left = 56
    Top = 32
  end
  object qry: TFDQuery
    Connection = Conexao
    Left = 192
    Top = 32
  end
end
