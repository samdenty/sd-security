object TPersHolder
  P.Name = 'SDS Build History'
  P.Extensions = 'sds_history'
  P.SyntaxBlocks = <
    item
      Name = 'Default'
      ID = 0
      UseStrings = True
      UseSingleLineStrings = True
      BlockDelimiters = <>
      SingleLineStringDelimiters = <
        item
          FontID = 1
          LeftDelimiter = '^'
          RightDelimiter = '^'
        end
        item
          FontID = 2
          LeftDelimiter = '**'
          RightDelimiter = '|'
        end
        item
          FontID = 3
          LeftDelimiter = '++'
          RightDelimiter = '|'
        end
        item
          FontID = 4
          LeftDelimiter = '--'
          RightDelimiter = '|'
        end
        item
          FontID = 5
          LeftDelimiter = '!!'
          RightDelimiter = '|'
        end>
    end>
  P.FontTable = <
    item
      FontID = 1
      GlobalAttrID = 'Custom'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Style = []
      BackColor = 4770047
      UseDefBack = False
    end
    item
      FontID = 2
      GlobalAttrID = 'Custom'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 16711422
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Style = []
      BackColor = 16766221
      UseDefBack = False
    end
    item
      FontID = 3
      GlobalAttrID = 'Custom'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Style = []
      BackColor = 4646502
      UseDefBack = False
    end
    item
      FontID = 4
      GlobalAttrID = 'Custom'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Style = []
      BackColor = 8222182
      UseDefBack = False
    end
    item
      FontID = 5
      GlobalAttrID = 'Custom'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Style = []
      BackColor = 6225915
      UseDefBack = False
    end>
  P.CodeTemplates = <>
  P.SyntaxVersion = 3
end
