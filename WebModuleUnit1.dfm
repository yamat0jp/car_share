object WebModule1: TWebModule1
  Actions = <
    item
      Default = True
      MethodType = mtGet
      Name = 'DefaultHandler'
      PathInfo = '/'
      OnAction = WebModule1DefaultHandlerAction
    end
    item
      Name = 'WebActionItem1'
      PathInfo = '/select'
      OnAction = WebModule1WebActionItem1Action
    end
    item
      MethodType = mtPost
      Name = 'WebActionItem2'
      PathInfo = '/post'
      OnAction = WebModule1WebActionItem2Action
    end>
  Height = 230
  Width = 415
  object FDConnection1: TFDConnection
    Params.Strings = (
      
        'Database=C:\Users\yamat\Documents\Embarcadero\Studio\Projects\ca' +
        'r_share\SHARE.IB'
      'User_Name=sysdba'
      'Password=masterkey'
      'OpenMode=OpenOrCreate'
      'DriverID=IB')
    Connected = True
    LoginPrompt = False
    Left = 144
    Top = 40
  end
  object FDTable1: TFDTable
    Active = True
    Filtered = True
    IndexFieldNames = 'CAR ID'
    Connection = FDConnection1
    ResourceOptions.AssignedValues = [rvEscapeExpand]
    TableName = 'MAIN'
    Left = 64
    Top = 40
    object FDTable1ID: TIntegerField
      FieldName = 'ID'
      Origin = 'ID'
      Required = True
    end
    object FDTable1CARID: TIntegerField
      FieldName = 'CAR ID'
      Origin = '"CAR ID"'
      Required = True
    end
    object FDTable1DATE: TSQLTimeStampField
      FieldName = 'DATE'
      Origin = '"DATE"'
      Required = True
    end
    object FDTable1MATERSTART: TIntegerField
      FieldName = 'MATER START'
      Origin = '"MATER START"'
    end
    object FDTable1MATERSTOP: TIntegerField
      FieldName = 'MATER STOP'
      Origin = '"MATER STOP"'
      Required = True
    end
    object FDTable1CODENAME: TIntegerField
      FieldName = 'CODE NAME'
      Origin = '"CODE NAME"'
      Required = True
    end
    object FDTable1CUSTOM: TWideStringField
      FieldName = 'CUSTOM'
      Origin = 'CUSTOM'
      Size = 80
    end
  end
  object DataSetTableProducer1: TDataSetTableProducer
    Columns = <
      item
        FieldName = 'DATE'
      end
      item
        FieldName = 'MATER START'
      end
      item
        FieldName = 'MATER STOP'
      end
      item
        FieldName = 'DISTANCE'
      end
      item
        FieldName = 'CODE NAME'
      end
      item
        FieldName = 'CUSTOM'
      end>
    Footer.Strings = (
      
        '<p style=text-align:center><input type=submit value="'#26356#26032'"></p></f' +
        'orm>'
      '<p style=text-align:center><a href="/select">return</a></p>')
    Header.Strings = (
      '')
    DataSet = FDTable1
    TableAttributes.Border = 1
    OnFormatCell = DataSetTableProducer1FormatCell
    Left = 64
    Top = 120
  end
  object PageProducer1: TPageProducer
    HTMLDoc.Strings = (
      '<html>'
      '<head><title>Car Share</title>'
      '</head>'
      '<body>'
      '<div style=text-align:center>'
      '<form action="/select" method=post>'
      '<p><br /></p>'
      '  <#select>'
      '<p><br /></p>'
      '<input type=submit value="'#27770#23450'"></form>'
      '</div>'
      '</body>'
      '</html>')
    OnHTMLTag = PageProducer1HTMLTag
    Left = 216
    Top = 120
  end
  object FDTable2: TFDTable
    Active = True
    Connection = FDConnection1
    ResourceOptions.AssignedValues = [rvEscapeExpand]
    TableName = '"CAR DATA"'
    Left = 240
    Top = 40
    object FDTable2GROUP: TIntegerField
      FieldName = 'GROUP'
      Origin = '"GROUP"'
      Required = True
    end
    object FDTable2CARID: TIntegerField
      FieldName = 'CAR ID'
      Origin = '"CAR ID"'
      Required = True
    end
    object FDTable2CATEGORY: TWideStringField
      FieldName = 'CATEGORY'
      Origin = 'CATEGORY'
      Size = 80
    end
    object FDTable2CARNUMBER: TWideStringField
      FieldName = 'CAR NUMBER'
      Origin = '"CAR NUMBER"'
      Required = True
      Size = 80
    end
  end
end
